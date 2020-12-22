using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebsiteTesting.Models.ScissorsManagmentSystem;

namespace WebsiteTesting.Pages.ScissorsManagment
{
    public partial class DailyReportDetailPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string lineClicked  = Request.Params["line"];
            lblLine.Text = String.Format("Line: {0}", lineClicked);

            var reportListByDate  = Session["InspectionReportByDate"] as List<InspectionReportModel>;
            var reportListByDateByLine = reportListByDate.Where(w => w.Line.Equals(lineClicked)).ToList();

            tableDailyReportDetail.Rows.Clear();

            TableRow trHeader = new TableRow();

            TableCell tcNoOfHeader = new TableCell();
            tcNoOfHeader.Text = "<b><center>No</center></b>";
            tcNoOfHeader.Width = 60;
            trHeader.Cells.Add(tcNoOfHeader);

            TableCell tcScanned = new TableCell();
            tcScanned.Text = "<b><center>Scanned</center></b>";
            trHeader.Cells.Add(tcScanned);

            TableCell tcNotScanned = new TableCell();
            tcNotScanned.Text = "<b><center>Not</center></b>";
            trHeader.Cells.Add(tcNotScanned);

            tableDailyReportDetail.Rows.Add(trHeader);

            var scannedListByWorker     = reportListByDateByLine.Where(w => w.InspectionDate != null).Select(s => s.WorkerId).Distinct().ToList();
            var notYetScanListByWorker  = reportListByDateByLine.Where(w => w.InspectionDate == null).Select(s => s.WorkerId).Distinct().ToList();

            int rowCreated = scannedListByWorker.Count() > notYetScanListByWorker.Count() ? scannedListByWorker.Count() : notYetScanListByWorker.Count();

            for (int i = 0; i < rowCreated; i ++)
            {
                var workerScanned       = i < scannedListByWorker.Count() ? scannedListByWorker[i] : "";
                var workerNotYetScan    = i < notYetScanListByWorker.Count() ? notYetScanListByWorker[i] : "";

                TableRow trContent = new TableRow();

                TableCell tcContenNo = new TableCell();
                tcContenNo.Text = String.Format("<center>{0}</center>", i + 1);
                trContent.Cells.Add(tcContenNo);
                
                TableCell tcContentScanned = new TableCell();
                if (!String.IsNullOrEmpty(workerScanned))
                {
                    var reportByWorkerScanned = reportListByDateByLine.Where(w => w.WorkerId == workerScanned && w.InspectionDate != null).ToList();
                    List<String> barcodeList = new List<string>();
                    string workerName = "";
                    foreach (var reportByWorker in reportByWorkerScanned)
                    {
                        workerName = reportByWorker.WorkerName;
                        barcodeList.Add(String.Format(" {0}{1}", reportByWorker.IsBig == true ? "B" : "S", reportByWorker.ScissorsBarcode));
                    }
                    tcContentScanned.Text = String.Format("{0} {1}", workerName, String.Join("; ", barcodeList));
                }
                trContent.Cells.Add(tcContentScanned);
                
                TableCell tcContentNotScanned = new TableCell();
                if (!String.IsNullOrEmpty(workerNotYetScan))
                {
                    var reportByWorkerNotYet = reportListByDateByLine.Where(w => w.WorkerId == workerNotYetScan && w.InspectionDate == null).ToList();
                    List<String> barcodeList = new List<string>();
                    string workerName = "";
                    foreach (var reportByWorker in reportByWorkerNotYet)
                    {
                        workerName = reportByWorker.WorkerName;
                        barcodeList.Add(String.Format(" {0}{1}", reportByWorker.IsBig == true ? "B" : "S", reportByWorker.ScissorsBarcode));
                    }
                    tcContentNotScanned.Text = String.Format("{0} {1}", workerName, String.Join("; ", barcodeList));
                }

                trContent.Cells.Add(tcContentNotScanned);
                
                tableDailyReportDetail.Rows.Add(trContent);
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
    }
}