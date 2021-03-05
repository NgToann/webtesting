using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebsiteTesting.Models.ScissorsManagmentSystem;

namespace WebsiteTesting.Pages.ScissorsManagment
{
    public partial class SummaryDetailReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string lineClicked = Request.Params["line"];
            lblLine.Text = String.Format("Line: {0}", lineClicked);
            //var issuanceList = Session["IssuanceList"] as List<IssuanceModel>;
            var releasedList = Session["ReleasedList"] as List<ReleaseScissorsModel>;
            if (IsPostBack == true)
                return;

            var releasedByLine  = releasedList.Where(w => w.LineName == lineClicked).ToList();

            //var assignedList = issuanceListByLine.Where(w => w.IsReplace == false && w.IsReturn == false).Select(s => s.WorkerId).Distinct().ToList();
            //var lossList     = issuanceListByLine.Where(w => w.Reason.ToUpper().Equals("LOSS")).Select(s => s.WorkerId).Distinct().ToList();
            //var brokenList   = issuanceListByLine.Where(w => w.Reason.ToUpper().Equals("BROKEN")).Select(s => s.WorkerId).Distinct().ToList();
            //var returnedList = issuanceListByLine.Where(w => w.IsReturn == true).Select(s => s.WorkerId).Distinct().ToList();
            //var indexList    = new int[] { assignedList.Count(), lossList.Count(), brokenList.Count(), returnedList.Count };

            var problemScissorsList = releasedByLine.Where(w => w.Reason.ToUpper().Equals("BROKEN") || w.Reason.ToUpper().Equals("LOSS")).ToList();
            var workerHasProblemScissorsList = problemScissorsList.Select(s => s.WorkerId).Distinct();
            workerHasProblemScissorsList = workerHasProblemScissorsList.Count() > 0 ? workerHasProblemScissorsList.OrderBy(o => o).ToList() : workerHasProblemScissorsList;

            TableRow trHeader = new TableRow();

            TableCell tcNoOfHeader = new TableCell();
            tcNoOfHeader.Text = "<b><center>No</center></b>";
            tcNoOfHeader.Width = 60;
            trHeader.Cells.Add(tcNoOfHeader);

            TableCell tcWorkerId = new TableCell();
            tcWorkerId.Text = "<b><center>Id</center></b>";
            trHeader.Cells.Add(tcWorkerId);

            TableCell tcWorkerName = new TableCell();
            tcWorkerName.Text = "<b><center>Name</center></b>";
            trHeader.Cells.Add(tcWorkerName);

            TableCell tcLossScissors = new TableCell();
            tcLossScissors.Text = "<b><center>Loss</center></b>";
            trHeader.Cells.Add(tcLossScissors);

            TableCell tcBrokenScissors = new TableCell();
            tcBrokenScissors.Text = "<b><center>Broken</center></b>";
            trHeader.Cells.Add(tcBrokenScissors);

            tableSummaryDetailReport.Rows.Add(trHeader);

            int indexNo = 1;
            foreach (var workerId in workerHasProblemScissorsList)
            {
                var problemScissorsByWorker = problemScissorsList.Where(w => w.WorkerId == workerId).ToList();
                var lossScissors    = problemScissorsByWorker.Where(w => w.Reason.ToUpper().Equals("LOSS")).ToList();
                var brokenScissors  = problemScissorsByWorker.Where(w => w.Reason.ToUpper().Equals("BROKEN")).ToList();

                TableRow tr = new TableRow();

                TableCell tcNoOf = new TableCell();
                tcNoOf.Text = string.Format("<center>{0}</center>", indexNo);
                tr.Cells.Add(tcNoOf);

                int maxProblemNo = lossScissors.Count() > brokenScissors.Count() ? lossScissors.Count() : brokenScissors.Count();
                
                var workerContent = problemScissorsByWorker.FirstOrDefault();
                TableCell tcWorkerIdContent = new TableCell();
                tcWorkerIdContent.Text = String.Format("<center>{0}</center>", workerContent.WorkerId);
                tr.Cells.Add(tcWorkerIdContent);

                TableCell tcWorkerNameContent = new TableCell();
                tcWorkerNameContent.Text = String.Format("{0}", workerContent.WorkerName);
                tr.Cells.Add(tcWorkerNameContent);
                    
                TableCell tcLossContent     = new TableCell();
                List<string> lossContent = new List<String>();
                foreach (var loss in lossScissors)
                {
                    lossContent.Add(String.Format("{0}<br>{1}", loss.Barcode, loss.UpdatedTime != null ? loss.UpdatedTime.ToString() : ""));
                }
                tcLossContent.Text = String.Format("{0}", String.Join("<br>", lossContent));
                tr.Cells.Add(tcLossContent);

                TableCell tcBrokenContent = new TableCell();
                List<string> brokenContent = new List<String>();
                foreach (var broken in brokenScissors)
                {
                    brokenContent.Add(String.Format("{0}<br>{1}", broken.Barcode, broken.UpdatedTime != null ? broken.UpdatedTime.ToString() : ""));
                }
                tcBrokenContent.Text = String.Format("{0}", String.Join("<br>", brokenContent));
                tr.Cells.Add(tcBrokenContent);


                tableSummaryDetailReport.Rows.Add(tr);
                indexNo++;
            }
        }
    }
}