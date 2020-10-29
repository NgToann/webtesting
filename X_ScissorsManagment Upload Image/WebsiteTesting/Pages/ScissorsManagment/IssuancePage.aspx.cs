using System;
using System.Collections.Generic;
using System.Linq;
using System.Drawing;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.EnterpriseServices;

using WebsiteTesting.Models.CheckInSystem;
using WebsiteTesting.Controllers.CheckInSystem;
using WebsiteTesting.Models.ScissorsManagmentSystem;
using WebsiteTesting.Controllers.ScissorsController;
using System.Text.RegularExpressions;

namespace WebsiteTesting.Pages.ScissorsManagment
{
    public partial class IssuancePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            List<IssuanceModel> issuanceList = new List<IssuanceModel>();
            issuanceList = ScissorsMainController.GetIssuance();
            ViewState["issuanceCurrentList"] = issuanceList;

            if (IsPostBack == true)
            {
                return;
            }

            List<SectionModel> sectionList = SectionController.Select();
            sectionList.Insert(0, new SectionModel());
            ViewState["sectionList"] = sectionList;

            cboSection.DataSource = sectionList;
            cboSection.DataBind();

            updateDataTable(issuanceList);
        }
        
        protected void cboSection_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtWorkerName.Text = "";
            txtWorkerID.Text = "";
            List<SectionModel> sectionList = ViewState["sectionList"] as List<SectionModel>;
            SectionModel section = sectionList[cboSection.SelectedIndex];
            string[] lineArray = { };
            var personalList = new List<PersonalModel>();
            if (string.IsNullOrEmpty(section.Keyword_1) == false)
            {
                personalList = PersonalController.Select(section.Keyword_1);
                lineArray = personalList.Select(p => p.Department).Distinct().ToArray();
            }
            var regex = new Regex(@"\D");
            var lineCustomList = lineArray.Select(s => new { Line = s, LineNumber = regex.IsMatch(s) ? regex.Replace(s, "") : s }).ToList();
            if (lineCustomList.Count() > 0)
                lineCustomList = lineCustomList.OrderBy(o => String.IsNullOrEmpty(o.LineNumber) ? 100 : Int32.Parse(o.LineNumber)).ThenBy(th => th.Line).ToList();
            ViewState["personalList"]   = personalList;
            ViewState["sectionClicked"] = section;
            cboLine.DataSource = lineCustomList.Select(s => s.Line).ToList();
            cboLine.DataBind();

            var issuedList = ViewState["issuanceCurrentList"] as List<IssuanceModel>;
            var issuedListBySection = issuedList.Where(w => w.Section == section.Name).ToList();
            updateDataTable(issuedListBySection);
        }

        protected void btnWorkerIdOK_Click(object sender, EventArgs e)
        {
            txtWorkerName.Text = "";
            var personalList    = ViewState["personalList"] as List<PersonalModel>;
            var issuedList      = ViewState["issuanceCurrentList"] as List<IssuanceModel>;
            //updateDataTable(issuedList);

            btnSave.Enabled = false;
            string workerIdInput = txtWorkerID.Text.Trim().ToUpper().ToString();
            if (personalList == null || personalList.Count() == 0)
            {
                //string msgAlert = "Section or Line empty !";
                //ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "AlertSectionOrLineEmpty()", true);
                ShowAlert("Section or Line Empty !");
                return;
            }
            var personByWorkerId = personalList.FirstOrDefault(f => f.WorkerId.ToUpper() == workerIdInput);
            if (personByWorkerId == null)
            {
                ShowAlert(String.Format("WorkerId {0} not found !", workerIdInput));
                return;
            }

            ViewState["personalInputted"] = personByWorkerId;
            txtWorkerName.Text = personByWorkerId.Name;

            var issuedListWorker = issuedList.Where(w => w.WorkerId == workerIdInput && w.IsReturn == false).ToList();
            updateDataTable(issuedListWorker);

            btnSave.Enabled = true;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string smallBarcode = txtSmallScissorsBarcode.Text.Trim().ToString();
            string bigBarcode   = txtBigScissorsBarcode.Text.Trim().ToString();

            var personalInputted    = ViewState["personalInputted"]         as PersonalModel;
            var sectionClicked      = ViewState["sectionClicked"]           as SectionModel;
            var issuedList          = ViewState["issuanceCurrentList"]      as List<IssuanceModel>;
            var lineClicked         = cboLine.SelectedItem.Value            as String;

            var usernameGet         = Page.User.Identity.Name.ToString();

            //updateDataTable(issuedList);
            updateDataTable(issuedList.Where(w => w.WorkerId == personalInputted.WorkerId && w.IsReturn == false && w.IsReplace == false).ToList());

            if (personalInputted == null || sectionClicked == null)
                return;
            
            try {

                List<string> msgList = new List<string>();
                if (String.IsNullOrEmpty(smallBarcode) && String.IsNullOrEmpty(bigBarcode))
                {
                    string msgEmpty = String.Format("Small and Big Scissors Barcode are empty !");
                    ShowAlert(msgEmpty);
                    return;
                }

                // Small Scisscors
                if (!String.IsNullOrEmpty(smallBarcode))
                {
                    var scissorsIssuedByBarcode    = issuedList.FirstOrDefault(f => f.ScissorsBarcode == smallBarcode && f.IsReturn == false);
                    var workerReceivedScissors     = issuedList.FirstOrDefault(f => f.WorkerId == personalInputted.WorkerId && f.IsBig == false && f.IsReturn == false);
                    var scissorsReplace            = issuedList.FirstOrDefault(f => f.ScissorsBarcodeReplace == smallBarcode);

                    if (scissorsReplace != null)
                        msgList.Add(String.Format("This {0} Scissors was {1}", scissorsReplace.IsBig == false ? "Small" : "Big", scissorsReplace.Reason));
                    else
                    {
                        if (workerReceivedScissors != null)
                            msgList.Add(String.Format("Worker {0} received a Small Scissors", workerReceivedScissors.WorkerId));
                        else
                        {
                            if (scissorsIssuedByBarcode != null)
                                msgList.Add(String.Format("This {0} Scissors {1} assigned to Worker : {2}",
                                    scissorsIssuedByBarcode.IsBig == false ? "Small" : "Big",
                                    scissorsIssuedByBarcode.ScissorsBarcode,
                                    scissorsIssuedByBarcode.WorkerId));
                            else
                            {
                                var issuanceSmallScissors = new IssuanceModel()
                                {
                                    WorkerId = personalInputted.WorkerId,
                                    WorkerName = personalInputted.Name,
                                    Section = sectionClicked.Name,
                                    Line = lineClicked,
                                    ScissorsBarcode = smallBarcode,
                                    IssuanceBy = usernameGet,
                                    IsBig = false,
                                };
                                ScissorsMainController.InsertIssuance(issuanceSmallScissors);
                                issuedList.Add(issuanceSmallScissors);
                                msgList.Add(String.Format("The Small scissors issued !"));
                            }
                        }
                    }
                }

                // Big Scissors
                if (!String.IsNullOrEmpty(bigBarcode))
                {
                    var scissorsIssuedByBarcode     = issuedList.FirstOrDefault(f => f.ScissorsBarcode == bigBarcode && f.IsReturn == false);
                    var workerReceivedBigScissor    = issuedList.FirstOrDefault(f => f.WorkerId == personalInputted.WorkerId && f.IsBig == true && f.IsReturn == false);
                    var scissorsReplace = issuedList.FirstOrDefault(f => f.ScissorsBarcodeReplace == bigBarcode);

                    if (scissorsReplace != null)
                        msgList.Add(String.Format("This {0} Scissors was {1}", scissorsReplace.IsBig == false ? "Small" : "Big", 
                            scissorsReplace.Reason));
                    else
                    {
                        if (workerReceivedBigScissor != null)
                            msgList.Add(String.Format("Worker {0} received a Big Scissors", workerReceivedBigScissor.WorkerId));
                        else
                        {
                            if (scissorsIssuedByBarcode != null)
                                msgList.Add(String.Format("This {0} Scissors {1} assigned to Worker : {2}", 
                                    scissorsIssuedByBarcode.IsBig == false ? "Small" : "Big",
                                    scissorsIssuedByBarcode.ScissorsBarcode,
                                    scissorsIssuedByBarcode.WorkerId));
                            else
                            {
                                var issuanceBigScissors = new IssuanceModel()
                                {
                                    WorkerId = personalInputted.WorkerId,
                                    WorkerName = personalInputted.Name,
                                    Section = sectionClicked.Name,
                                    Line = lineClicked,
                                    ScissorsBarcode = bigBarcode,
                                    IssuanceBy = usernameGet,
                                    IsBig = true,
                                };
                                ScissorsMainController.InsertIssuance(issuanceBigScissors);
                                issuedList.Add(issuanceBigScissors);
                                msgList.Add(String.Format("The Big scissors issued !"));
                            }
                        }
                    }
                }

                // Show Alert
                if (msgList.Count() > 0)
                {
                    string msg = String.Join(@"\n", msgList);
                    ShowAlert(msg);
                }

                ViewState["issuanceCurrentList"] = issuedList;
                // Update data table
                updateDataTable(issuedList.Where(w => w.WorkerId == personalInputted.WorkerId && w.IsReturn == false && w.IsReplace == false).ToList());
                //updateDataTable(issuedList);
                //btnSave.Enabled = false;
            }
            catch (Exception ex) {
                ShowAlert(ex.Message);
            }
        }
        
        private void updateDataTable (List<IssuanceModel> issuedList)
        {
            tableIssuance.Rows.Clear();
            // update table current.

            TableRow trHeader = new TableRow();
            TableCell tcNoOfHeader = new TableCell();
            tcNoOfHeader.Text = "<b><center>No.</center></b>";
            trHeader.Cells.Add(tcNoOfHeader);

            TableCell tcWorkerIdHeader = new TableCell();
            tcWorkerIdHeader.Text = "<b>ID#</b>";
            trHeader.Cells.Add(tcWorkerIdHeader);

            TableCell tcWorkerNameHeader = new TableCell();
            tcWorkerNameHeader.Text = "<b>Name</b>";
            trHeader.Cells.Add(tcWorkerNameHeader);

            TableCell tcSmallHeader = new TableCell();
            tcSmallHeader.Text = "<b><center>Small</center></b>";
            trHeader.Cells.Add(tcSmallHeader);
            tcSmallHeader.Width = 68;

            TableCell tcBigHeader = new TableCell();
            tcBigHeader.Text = "<b><center>Big</center></b>";
            trHeader.Cells.Add(tcBigHeader);
            tcBigHeader.Width = 68;


            tableIssuance.Rows.Add(trHeader);

            // Binding data to table

            var workerIdList = issuedList.Select(s => s.WorkerId).Distinct().ToList();
            if (workerIdList.Count() > 0)
                workerIdList = workerIdList.OrderBy(o => o).ToList();
            int index = 1;
            foreach (var workerId in workerIdList)
            {
                var issuedByWorker = issuedList.Where(w => w.WorkerId == workerId).ToList();
                var isseddByWorkerFirst = issuedByWorker.FirstOrDefault();

                TableRow tr = new TableRow();

                TableCell tcNoOf = new TableCell();
                tcNoOf.Text = string.Format("<center>{0}</center>", index);
                tr.Cells.Add(tcNoOf);

                TableCell tcWorkerId = new TableCell();
                tcWorkerId.Text = workerId;
                tr.Cells.Add(tcWorkerId);

                TableCell tcWorkerName = new TableCell();
                tcWorkerName.Text = isseddByWorkerFirst.WorkerName;
                tr.Cells.Add(tcWorkerName);

                TableCell tcSmall = new TableCell();
                tcSmall.BackColor = System.Drawing.Color.Black;
                var checkIssuedSmall = issuedByWorker.FirstOrDefault(f => f.IsBig == false && f.IsReturn == false);
                if (checkIssuedSmall != null)
                {
                    tcSmall.BackColor   = System.Drawing.Color.Green;
                    tcSmall.Text        = string.Format("<center>{0}</center>", checkIssuedSmall.ScissorsBarcode);
                    tcSmall.ForeColor   = System.Drawing.Color.Black;
                }
                tr.Cells.Add(tcSmall);

                TableCell tcBig = new TableCell();
                tcBig.BackColor = System.Drawing.Color.Black;
                var checkIssuedBig = issuedByWorker.FirstOrDefault(f => f.IsBig == true && f.IsReturn == false);
                if (checkIssuedBig != null)
                {
                    tcBig.BackColor     = System.Drawing.Color.Green;
                    tcBig.Text          = string.Format("<center>{0}</center>", checkIssuedBig.ScissorsBarcode);
                    tcBig.ForeColor     = System.Drawing.Color.Black;
                }
                tr.Cells.Add(tcBig);

                if (checkIssuedSmall == null && checkIssuedBig == null)
                    continue;

                tableIssuance.Rows.Add(tr);
                index++;
            }
        }

        private void ShowAlert (string msg)
        {
            string script = string.Format("alert('{0}');", msg);
            if (Page != null && !Page.ClientScript.IsClientScriptBlockRegistered("alert"))
            {
                Page.ClientScript.RegisterClientScriptBlock(Page.GetType(), "alert", script, true);
            }
        }

        protected void cboLine_SelectedIndexChanged(object sender, EventArgs e)
        {
            var lineSelected = cboLine.SelectedItem.Value.ToString();
            txtWorkerName.Text = "";
            txtWorkerID.Text = "";
            if (String.IsNullOrEmpty(lineSelected))
                return;
            var issuedList = ViewState["issuanceCurrentList"] as List<IssuanceModel>;
            var issuedListByLine = issuedList.Where(w => w.Line == lineSelected).ToList();
            if (issuedListByLine.Count() > 0)
                issuedListByLine = issuedListByLine.OrderBy(o => o.WorkerId).ToList();
            updateDataTable(issuedListByLine);
        }
    }
}