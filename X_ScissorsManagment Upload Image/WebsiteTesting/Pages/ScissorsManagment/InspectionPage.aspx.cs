using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.DynamicData;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebsiteTesting.Controllers.ScissorsController;
using WebsiteTesting.Entities;
using WebsiteTesting.Models.ScissorsManagmentSystem;

namespace WebsiteTesting.Pages.ScissorsManagment
{
    public partial class InspectionPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var toDay               = DateTime.Now;
            var inspectionListToDay = ScissorsMainController.GetInspectionByDate(toDay);
            var scissorsList        = ScissorsMainController.GetAllScissors();
            var issuanceList        = ScissorsMainController.GetIssuance();

            lblTitle.Text = String.Format("INSPECTION {0:MM/dd/yyyy}", toDay);

            updateDataTable(issuanceList, inspectionListToDay);

            ViewState["inspectionListToDay"]    = inspectionListToDay;
            ViewState["issuanceList"]           = issuanceList;
            ViewState["toDay"]                  = toDay;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            var inspectionListToDay = ViewState["inspectionListToDay"] as List<InspectionModel>;
            var issuanceList        = ViewState["issuanceList"] as List<IssuanceModel>;
            var toDay               = (DateTime)ViewState["toDay"];
            var usernameGet         = Page.User.Identity.Name.ToString();
            txtWorkerId.Text        = "";

            string barcodeScanned = txtScissorsBarcode.Text.ToString();
            if (String.IsNullOrEmpty(barcodeScanned))
            {
                ShowAlert("Barcode Empty !");
                return;
            }

            var checkScannedOrnot = inspectionListToDay.FirstOrDefault(f => f.Barcode == barcodeScanned);
            if (checkScannedOrnot != null)
            {
                ShowAlert("Scanned !");
                return;
            }

            var checkScisscorIssuedOrNot = issuanceList.FirstOrDefault(f => f.ScissorsBarcode == barcodeScanned && f.IsReturn == false);
            if (checkScisscorIssuedOrNot == null)
            {
                ShowAlert("The Scissors not assigned to any one !");
                return;
            }
            var insertModel = new InspectionModel() {
                WorkerId        = checkScisscorIssuedOrNot.WorkerId,
                WorkerName      = checkScisscorIssuedOrNot.WorkerName,
                Barcode         = checkScisscorIssuedOrNot.ScissorsBarcode,
                InspectionDate  = toDay,
                Inspector       = usernameGet
            };
            try 
            {
                ScissorsMainController.InsertInspection(insertModel);
                inspectionListToDay.Add(insertModel);

                updateDataTable(issuanceList, inspectionListToDay);
                ViewState["InspectionCurrent"] = inspectionListToDay;
            }
            catch (Exception ex)
            {
                ShowAlert(ex.Message);
            }
        }

        private void updateDataTable(List<IssuanceModel> issuanceList, List<InspectionModel> inspectionList)
        {
            tableInspection.Rows.Clear();
            // update table current.

            TableRow trHeader = new TableRow();
            TableCell tcNoOfHeader = new TableCell();
            tcNoOfHeader.Text = "<b><center>No.</center></b>";
            trHeader.Cells.Add(tcNoOfHeader);
            trHeader.Width = 68;

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

            tableInspection.Rows.Add(trHeader);

            // Binding data to table
            var workerIdList = inspectionList.Select(s => s.WorkerId).Distinct().ToList();

            int index = 1;
            foreach (var workerId in workerIdList)
            {
                var issuanceListByWorkerId = issuanceList.Where(f => f.WorkerId == workerId).ToList();
                TableRow tr = new TableRow();

                TableCell tcNoOf = new TableCell();
                tcNoOf.Text = string.Format("<center>{0}</center>", index);
                tr.Cells.Add(tcNoOf);

                TableCell tcWorkerId = new TableCell();
                tcWorkerId.Text = workerId;
                tr.Cells.Add(tcWorkerId);

                TableCell tcWorkerName = new TableCell();
                tcWorkerName.Text = issuanceListByWorkerId.FirstOrDefault().WorkerName;
                tr.Cells.Add(tcWorkerName);

                TableCell tcSmall = new TableCell();

                var checkSmallIssuedOrNot = issuanceListByWorkerId.FirstOrDefault(f => f.IsBig == false && f.IsReturn == false);
                if (checkSmallIssuedOrNot == null)
                    tcSmall.BackColor = System.Drawing.Color.Black;
                else
                {
                    // Scanned or not
                    var checkSmallScannedOrNot = inspectionList.FirstOrDefault(f => f.Barcode == checkSmallIssuedOrNot.ScissorsBarcode);
                    if (checkSmallScannedOrNot != null)
                    {
                        tcSmall.BackColor = System.Drawing.Color.Green;
                        tcSmall.Text = string.Format("<center>{0}</center>", checkSmallScannedOrNot.Barcode);
                    }
                    else
                        tcSmall.BackColor = System.Drawing.Color.Red;
                }

                tr.Cells.Add(tcSmall);

                TableCell tcBig = new TableCell();
                var checkBigIssuedOrNot = issuanceListByWorkerId.FirstOrDefault(f => f.IsBig == true && f.IsReturn == false);
                if (checkBigIssuedOrNot == null)
                    tcBig.BackColor = System.Drawing.Color.Black;
                else
                {
                    // Scanned or not
                    var checkBigScannedOrNot = inspectionList.FirstOrDefault(f => f.Barcode == checkBigIssuedOrNot.ScissorsBarcode);
                    if (checkBigScannedOrNot != null)
                    {
                        tcBig.BackColor = System.Drawing.Color.Green;
                        tcBig.Text = string.Format("<center>{0}</center>", checkBigScannedOrNot.Barcode);
                    }
                    else
                        tcBig.BackColor = System.Drawing.Color.Red;
                }

                tr.Cells.Add(tcBig);

                tableInspection.Rows.Add(tr);

                index++;
            }
        }

        private void ShowAlert(string msg)
        {
            string script = string.Format("alert('{0}');", msg);
            if (Page != null && !Page.ClientScript.IsClientScriptBlockRegistered("alert"))
            {
                Page.ClientScript.RegisterClientScriptBlock(Page.GetType(), "alert", script, true);
            }
        }

        protected void btnWorkerSearch_Click(object sender, EventArgs e)
        {
            var inspectionListToDay = ViewState["inspectionListToDay"] as List<InspectionModel>;
            var issuanceList = ViewState["issuanceList"] as List<IssuanceModel>;
            string searchWhat = txtWorkerId.Text.Trim().ToUpper().ToString();
            // Search nodata.
            if (inspectionListToDay == null)
                return;
            var inspectionSearchByWorker = inspectionListToDay.Where(w => w.WorkerId == searchWhat).ToList();
            updateDataTable(issuanceList, inspectionSearchByWorker);
        }
    }
}