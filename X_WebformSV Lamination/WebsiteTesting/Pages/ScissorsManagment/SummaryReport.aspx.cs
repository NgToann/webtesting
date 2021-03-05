using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using WebsiteTesting.Models.CheckInSystem;
using WebsiteTesting.Controllers.CheckInSystem;
using WebsiteTesting.Models.ScissorsManagmentSystem;
using WebsiteTesting.Controllers.ScissorsController;
using System.Text.RegularExpressions;

namespace WebsiteTesting.Pages.ScissorsManagment
{
    public partial class SummaryReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //var issuanceList = ScissorsMainController.GetIssuance();
            var releasedList = ScissorsMainController.GetReleaseScissors();
            ViewState["releasedList"] = releasedList;

            if (IsPostBack == true)
            {
                return;
            }
            List<SectionModel> sectionList = SectionController.Select();
            sectionList.Insert(0, new SectionModel() { Name = "All" });
            ViewState["sectionList"] = sectionList;

            cboSection.DataSource = sectionList;
            cboSection.DataBind();
            UpdateDataTable(releasedList);
        }

        protected void cboSection_SelectedIndexChanged(object sender, EventArgs e)
        {
            var sectionList = ViewState["sectionList"] as List<SectionModel>;
            var sectionClicked = sectionList[cboSection.SelectedIndex];

            //var issuanceList = ViewState["issuanceList"] as List<IssuanceModel>;
            var releasedList = ViewState["releasedList"] as List<ReleaseScissorsModel>;
            if (!sectionClicked.Name.Equals("All"))
                releasedList = releasedList.Where(w => w.Section.Equals(sectionClicked.Name)).ToList();
            UpdateDataTable(releasedList);
        }

        //protected void UpdateDataTable (List<IssuanceModel> issuanceList)
        protected void UpdateDataTable(List<ReleaseScissorsModel> releasedList)
        {
            tableSummaryReport.Rows.Clear();
            // update table current.

            TableRow trHeader = new TableRow();

            TableCell tcNoOfHeader = new TableCell();
            tcNoOfHeader.Text = "<b><center>No</center></b>";
            tcNoOfHeader.RowSpan = 2;
            tcNoOfHeader.Width = 60;
            trHeader.Cells.Add(tcNoOfHeader);

            TableCell tcLineHeader = new TableCell();
            tcLineHeader.Text = "<b><center>Line</center></b>";
            tcLineHeader.RowSpan = 2;
            tcLineHeader.Width = 80;
            trHeader.Cells.Add(tcLineHeader);

            TableCell tcIssuedHeader = new TableCell();
            tcIssuedHeader.Text = "<b><center>ISSUED</center></b>";
            tcIssuedHeader.Width = 80;
            tcIssuedHeader.ColumnSpan = 2;
            trHeader.Cells.Add(tcIssuedHeader);

            TableCell tcBrokenHeader = new TableCell();
            tcBrokenHeader.Text = "<b><center>BROKEN</center></b>";
            tcBrokenHeader.Width = 80;
            tcBrokenHeader.ColumnSpan = 2;
            trHeader.Cells.Add(tcBrokenHeader);

            TableCell tcLossHeader = new TableCell();
            tcLossHeader.Text = "<b><center>LOSS</center></b>";
            tcLossHeader.Width = 80;
            tcLossHeader.ColumnSpan = 2;
            trHeader.Cells.Add(tcLossHeader);

            tableSummaryReport.Rows.Add(trHeader);

            // Header Detail
            TableRow trHeaderDetail = new TableRow();

            TableCell tcIssuedHeaderSmall = new TableCell();
            tcIssuedHeaderSmall.Text = "<b><center>S</center></b>";
            tcIssuedHeaderSmall.Width = 40;
            trHeaderDetail.Cells.Add(tcIssuedHeaderSmall);

            TableCell tcIssuedHeaderBig = new TableCell();
            tcIssuedHeaderBig.Text = "<b><center>B</center></b>";
            tcIssuedHeaderBig.Width = 40;
            trHeaderDetail.Cells.Add(tcIssuedHeaderBig);

            TableCell tcBrokenHeaderSmall = new TableCell();
            tcBrokenHeaderSmall.Text = "<b><center>S</center></b>";
            tcBrokenHeaderSmall.Width = 40;
            trHeaderDetail.Cells.Add(tcBrokenHeaderSmall);

            TableCell tcBrokenHeaderBig = new TableCell();
            tcBrokenHeaderBig.Text = "<b><center>B</center></b>";
            tcBrokenHeaderBig.Width = 40;
            trHeaderDetail.Cells.Add(tcBrokenHeaderBig);

            TableCell tcLossHeaderSmall = new TableCell();
            tcLossHeaderSmall.Text = "<b><center>S</center></b>";
            tcLossHeaderSmall.Width = 40;
            trHeaderDetail.Cells.Add(tcLossHeaderSmall);

            TableCell tcLossHeaderBig = new TableCell();
            tcLossHeaderBig.Text = "<b><center>B</center></b>";
            tcLossHeaderBig.Width = 40;
            trHeaderDetail.Cells.Add(tcLossHeaderBig);

            tableSummaryReport.Rows.Add(trHeaderDetail);

            var lineList = releasedList.Select(s => s.LineName).Distinct().ToList();
            var regex = new Regex(@"\D");
            var lineCustomList = lineList.Select(s => new { Line = s, LineNumber = regex.IsMatch(s) ? regex.Replace(s, "") : s }).ToList();
            if (lineCustomList.Count() > 0)
                lineCustomList = lineCustomList.OrderBy(o => String.IsNullOrEmpty(o.LineNumber) ? 100 : Int32.Parse(o.LineNumber)).ThenBy(th => th.Line).ToList();

            int rlTotalSmall = 0, rlTotalBig = 0, brokenTotalSmall = 0, brokenTotalBig = 0, lossTotalSmall = 0, lossTotalBig = 0;
            int index = 1;
            Session["ReleasedList"] = releasedList;
            foreach (var line in lineCustomList)
            {
                var rlByLineList = releasedList.Where(w => w.LineName.Equals(line.Line)).ToList();

                int issuedSmall     = rlByLineList.Where(w => w.Status.Equals("Borrowed") && w.ScissorsType.Equals("Small")).Count();
                int issuedBig       = rlByLineList.Where(w => w.Status.Equals("Borrowed") && w.ScissorsType.Equals("Big")).Count();

                int brokenSmall = rlByLineList.Where(w => w.Status.Equals("Replaced") && w.Reason.Equals("Broken") && w.ScissorsType.Equals("Small")).Count();
                int brokenBig = rlByLineList.Where(w => w.Status.Equals("Replaced") && w.Reason.Equals("Broken") && w.ScissorsType.Equals("Big")).Count();

                int lossSmall       = rlByLineList.Where(w => w.Status.Equals("Replaced") && w.Reason.Equals("Loss") && w.ScissorsType.Equals("Small")).Count();
                int lossBig         = rlByLineList.Where(w => w.Status.Equals("Replaced") && w.Reason.Equals("Loss") && w.ScissorsType.Equals("Big")).Count();

                rlTotalSmall    += issuedSmall;
                rlTotalBig      += issuedBig;
                brokenTotalSmall    += brokenSmall;
                brokenTotalBig      += brokenBig;
                lossTotalSmall      += lossSmall;
                lossTotalBig        += lossBig;

                TableRow tr = new TableRow();

                TableCell tcNoOf = new TableCell();
                tcNoOf.Text = string.Format("<center>{0}</center>", index);
                tr.Cells.Add(tcNoOf);

                TableCell tcLine = new TableCell();
                var lnkLine = new HyperLink
                {
                    Text = line.Line,
                    NavigateUrl = String.Format("SummaryDetailReport.aspx?line={0}", line.Line),
                };
                tcLine.Controls.Add(lnkLine);
                tr.Cells.Add(tcLine);

                var issuedSmallView = issuedSmall > 0 ? issuedSmall.ToString() : "";
                TableCell tcIssuedSmall = new TableCell();
                tcIssuedSmall.Text = String.Format("<center>{0}</center>", issuedSmallView);
                tr.Cells.Add(tcIssuedSmall);

                var issuedBigView = issuedBig > 0 ? issuedBig.ToString() : "";
                TableCell tcIssuedBig = new TableCell();
                tcIssuedBig.Text = String.Format("<center>{0}</center>", issuedBigView);
                tr.Cells.Add(tcIssuedBig);

                var brokenSmallView = brokenSmall > 0 ? brokenSmall.ToString() : "";
                TableCell tcBrokenSmall = new TableCell();
                tcBrokenSmall.Text = String.Format("<center>{0}</center>", brokenSmallView);
                tr.Cells.Add(tcBrokenSmall);

                var brokenBigView = brokenBig > 0 ? brokenBig.ToString() : "";
                TableCell tcBrokenBig = new TableCell();
                tcBrokenBig.Text = String.Format("<center>{0}</center>", brokenBigView);
                tr.Cells.Add(tcBrokenBig);

                var lossSmallView = lossSmall > 0 ? lossSmall.ToString() : "";
                TableCell tcLossSmall = new TableCell();
                tcLossSmall.Text = String.Format("<center>{0}</center>", lossSmallView);
                tr.Cells.Add(tcLossSmall);

                var lossBigView = lossBig > 0 ? lossBig.ToString() : "";
                TableCell tcLossBig = new TableCell();
                tcLossBig.Text = String.Format("<center>{0}</center>", lossBigView);
                tr.Cells.Add(tcLossBig);

                tableSummaryReport.Rows.Add(tr);

                index++;
            }

            TableRow trTotal = new TableRow();

            TableCell tcNoOfTotal = new TableCell();
            tcNoOfTotal.Text = String.Format("<center>{0}</center>", index);
            trTotal.Cells.Add(tcNoOfTotal);

            TableCell tcLineTotal = new TableCell();
            tcLineTotal.Text = "<center><b>Total</b></center>";
            trTotal.Cells.Add(tcLineTotal);

            var issuedSmallViewTotal = rlTotalSmall > 0 ? rlTotalSmall.ToString() : "";
            TableCell tcIssuedSmallTotal = new TableCell();
            tcIssuedSmallTotal.Text = String.Format("<center><b>{0}</b></center>", issuedSmallViewTotal);
            trTotal.Cells.Add(tcIssuedSmallTotal);

            var issuedBigViewTotal = rlTotalBig > 0 ? rlTotalBig.ToString() : "";
            TableCell tcIssuedBigTotal = new TableCell();
            tcIssuedBigTotal.Text = String.Format("<center><b>{0}</b></center>", issuedBigViewTotal);
            trTotal.Cells.Add(tcIssuedBigTotal);

            var brokenSmallViewTotal = brokenTotalSmall > 0 ? brokenTotalSmall.ToString() : "";
            TableCell tcBrokenSmallTotal = new TableCell();
            tcBrokenSmallTotal.Text = String.Format("<center><b>{0}</b></center>", brokenSmallViewTotal);
            trTotal.Cells.Add(tcBrokenSmallTotal);

            var brokenBigViewTotal = brokenTotalBig > 0 ? brokenTotalBig.ToString() : "";
            TableCell tcBrokenBigTotal = new TableCell();
            tcBrokenBigTotal.Text = String.Format("<center><b>{0}</b></center>", brokenBigViewTotal);
            trTotal.Cells.Add(tcBrokenBigTotal);

            var lossSmallViewTotal = lossTotalSmall > 0 ? lossTotalSmall.ToString() : "";
            TableCell tcLossSmallTotal = new TableCell();
            tcLossSmallTotal.Text = String.Format("<center><b>{0}</b></center>", lossSmallViewTotal);
            trTotal.Cells.Add(tcLossSmallTotal);

            var lossBigViewTotal = lossTotalBig > 0 ? lossTotalBig.ToString() : "";
            TableCell tcLossBigTotal = new TableCell();
            tcLossBigTotal.Text = String.Format("<center><b>{0}</b></center>", lossBigViewTotal);
            trTotal.Cells.Add(tcLossBigTotal);

            tableSummaryReport.Rows.Add(trTotal);

            lblTotalIssued.Text     = String.Format("TOTAL ISSUED : {0}", rlTotalBig + rlTotalSmall);
            lblTotalBroken.Text     = String.Format("TOTAL BROKEN : {0}", brokenTotalBig + brokenTotalSmall);
            lblTotalLoss.Text       = String.Format("TOTAL LOSS   : {0}", lossTotalBig + lossTotalSmall);
        }
    }
}