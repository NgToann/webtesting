using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebsiteTesting.Controllers.ScissorsController;

namespace WebsiteTesting.Pages.ScissorsManagment
{
    public partial class FloatingScissorsReportPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //var issuanceReturnedList = ScissorsMainController.GetReturnedScissors().ToList();
            //var scissorsAssignedList = ScissorsMainController.GetIssuance().Where(w => w.IsReturn == false && w.IsReplace == false).Select(s => s.ScissorsBarcode).Distinct().ToList();

            var releasedList = ScissorsMainController.GetReleaseScissors().Where(w => !w.Status.Equals("Replaced")).ToList();
            var borrowedList = releasedList.Where(w => w.Status.Equals("Borrowed")).Select(s => s.Barcode).Distinct().ToList();
            var returnedList = releasedList.Where(w => w.Status.Equals("Returned") && !borrowedList.Contains(w.Barcode)).ToList();

            // remove scissors already assigned
            //issuanceReturnedList = issuanceReturnedList.Where(w => borrowedList.Contains(w.ScissorsBarcode) == false).ToList();

            var sectionList         = returnedList.Select(s => s.Section).Distinct().ToList();
            if (sectionList.Count() > 0)
                sectionList = sectionList.OrderBy(o => o).ToList();

            int index = 1;

            tableAvailableScissors.Rows.Clear();

            TableRow trHeader = new TableRow();

            TableCell tcNoOfHeader = new TableCell();
            tcNoOfHeader.Text = "<b><center>No</center></b>";
            tcNoOfHeader.Width = 60;
            trHeader.Cells.Add(tcNoOfHeader);

            TableCell trSectionHeader = new TableCell();
            trSectionHeader.Text = "<b><center>Section</center></b>";
            trHeader.Cells.Add(trSectionHeader);

            TableCell tcLineHeader = new TableCell();
            tcLineHeader.Text = "<b><center>Line</center></b>";
            trHeader.Cells.Add(tcLineHeader);

            TableCell tcSmallHeader = new TableCell();
            tcSmallHeader.Text = "<b><center>SMALL</center></b>";
            tcSmallHeader.Width = 80;
            trHeader.Cells.Add(tcSmallHeader);

            TableCell tcBigHeader = new TableCell();
            tcBigHeader.Text = "<b><center>BIG</center></b>";
            tcBigHeader.Width = 80;
            trHeader.Cells.Add(tcBigHeader);

            tableAvailableScissors.Rows.Add(trHeader);

            int totalSmall = 0, totalBig = 0;
            foreach (var section in sectionList)
            {
                var returnedBySection   = returnedList.Where(w => w.Section.Equals(section)).ToList();
                var lineListLiBySection = returnedBySection.Select(s => s.LineName).Distinct().ToList();

                var regex = new Regex(@"\D");
                var lineCustomList = lineListLiBySection.Select(s => new { Line = s, LineNumber = regex.IsMatch(s) ? regex.Replace(s, "") : s }).ToList();
                if (lineCustomList.Count() > 0)
                    lineCustomList = lineCustomList.OrderBy(o => String.IsNullOrEmpty(o.LineNumber) ? 100 : Int32.Parse(o.LineNumber)).ThenBy(th => th.Line).ToList();

                foreach (var line in lineCustomList)
                {
                    TableRow tr = new TableRow();

                    TableCell tcNoOf = new TableCell();
                    tcNoOf.Text = String.Format("<center>{0}</center>", index);
                    tr.Cells.Add(tcNoOf);

                    TableCell tcSection = new TableCell();
                    tcSection.Text = section;
                    tr.Cells.Add(tcSection);

                    TableCell tcLine = new TableCell();

                    Session["ReturnedList"] = returnedList;
                    var lnkLine = new HyperLink
                    {
                        Text = line.Line,
                        NavigateUrl = String.Format("FloatingScissorsReportDetailPage.aspx?line={0}", line.Line),
                    };
                    tcLine.Controls.Add(lnkLine);
                    tr.Cells.Add(tcLine);

                    var qtySmallReturned = returnedBySection.Where(w => w.LineName.Equals(line.Line) && w.ScissorsType.Equals("Small")).ToList().Count();
                    //int qtySmallReturned = smallScissorsReturnedList.Where(w => smallScissorsAssignedList.Contains(w) == false).Count();
                    totalSmall += qtySmallReturned;

                    var smallView = qtySmallReturned > 0 ? qtySmallReturned.ToString() : "";
                    TableCell tcSmall = new TableCell();
                    tcSmall.Text = String.Format("<center>{0}</center>", smallView);
                    tr.Cells.Add(tcSmall);

                    //var bigScissorsRuturnedReturnedList = issuanceListBySection.Where(w => w.Line.Equals(line) && w.IsBig == true).Select(s => s.ScissorsBarcode).Distinct().ToList();
                    //var bigScissorsAssignedList         = scissorsAssignedList.Where(w => w.IsBig == true && w.IsReturn == false && w.IsReplace == false).Select(s => s.ScissorsBarcode).Distinct().ToList();

                    int qtyBigReturned  = returnedBySection.Where(w => w.LineName.Equals(line.Line) && w.ScissorsType.Equals("Big")).ToList().Count();
                    //int qtyBigReturned = bigScissorsRuturnedReturnedList.Where(w => bigScissorsAssignedList.Contains(w) == false).Count();
                    totalBig += qtyBigReturned;

                    var bigView = qtyBigReturned > 0 ? qtyBigReturned.ToString() : "";
                    TableCell tcBig = new TableCell();
                    tcBig.Text = String.Format("<center>{0}</center>", bigView);
                    tr.Cells.Add(tcBig);

                    if (qtySmallReturned == 0 && qtyBigReturned == 0)
                        continue;

                    tableAvailableScissors.Rows.Add(tr);
                    index++;
                }
            }

            TableRow trTotal = new TableRow();

            TableCell tcNoOfTotal   = new TableCell();
            tcNoOfTotal.Text        = String.Format("<center>{0}</center>", index);
            trTotal.Cells.Add(tcNoOfTotal);

            TableCell tcSectionTotal = new TableCell();
            tcSectionTotal.Text = "<b><center>Total</center></b>";
            trTotal.Cells.Add(tcSectionTotal);

            TableCell tcLineTotal = new TableCell();
            trTotal.Cells.Add(tcLineTotal);

            var smallViewTotal = totalSmall > 0 ? totalSmall.ToString() : "";
            TableCell tcSmallTotal = new TableCell();
            tcSmallTotal.Text = String.Format("<center><b>{0}</b></center>", smallViewTotal);
            trTotal.Cells.Add(tcSmallTotal);

            var bigViewTotal = totalBig > 0 ? totalBig.ToString() : "";
            TableCell tcBigTotal = new TableCell();
            tcBigTotal.Text = String.Format("<center><b>{0}</b></center>", bigViewTotal);
            trTotal.Cells.Add(tcBigTotal);

            tableAvailableScissors.Rows.Add(trTotal);
        }
    }
}