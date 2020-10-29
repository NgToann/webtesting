using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebsiteTesting.Models.ScissorsManagmentSystem;

namespace WebsiteTesting.Pages.ScissorsManagment
{
    public partial class FloatingScissorsReportDetailPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string lineClicked = Request.Params["line"];
            lblLine.Text = String.Format("Line: {0}", lineClicked);
            var issuanceList = Session["IssuanceList"] as List<IssuanceModel>;

            var returnedScissorsListByLine = issuanceList.Where(w => w.IsReturn == true && w.Line == lineClicked).ToList();
            if (returnedScissorsListByLine.Count() > 0)
                returnedScissorsListByLine = returnedScissorsListByLine.OrderBy(o => o.ReturnTime).ToList();
            // Create Table

            tableAvailableScissorsDetail.Rows.Clear();

            TableRow trHeader = new TableRow();

            TableCell tcNoOfHeader = new TableCell();
            tcNoOfHeader.Text = "<b><center>No</center></b>";
            trHeader.Cells.Add(tcNoOfHeader);

            TableCell tcHeaderBarcode = new TableCell();
            tcHeaderBarcode.Text = "<b><center>Barcode</center></b>";
            trHeader.Cells.Add(tcHeaderBarcode);

            TableCell tcHeaderWorker = new TableCell();
            tcHeaderWorker.Text = "<b><center>Worker</center></b>";
            trHeader.Cells.Add(tcHeaderWorker);

            TableCell tcHeaderReturnTime = new TableCell();
            tcHeaderReturnTime.Text = "<b><center>Return Time</center></b>";
            trHeader.Cells.Add(tcHeaderReturnTime);

            tableAvailableScissorsDetail.Rows.Add(trHeader);

            int index = 1;
            foreach (var returnScissors in returnedScissorsListByLine)
            {
                TableRow trContent = new TableRow();
                TableCell tcContentIndex = new TableCell() { Text = String.Format("<center>{0}</center>", index), };
                trContent.Cells.Add(tcContentIndex);

                TableCell tcContentBarcode = new TableCell() { Text = String.Format("<center>{0}{1}</center>", returnScissors.IsBig == true ? "B" : "S", returnScissors.ScissorsBarcode), };
                trContent.Cells.Add(tcContentBarcode);

                TableCell tcContentWorker = new TableCell() { Text = String.Format("{0} {1}", returnScissors.WorkerId, returnScissors.WorkerName), };
                trContent.Cells.Add(tcContentWorker);

                TableCell tcContentReturnTime = new TableCell()
                {
                    Text = String.Format("<center>{0}</center>", returnScissors.ReturnTime),
                };
                trContent.Cells.Add(tcContentReturnTime);

                tableAvailableScissorsDetail.Rows.Add(trContent);
                index++;
            }
        }
    }
}