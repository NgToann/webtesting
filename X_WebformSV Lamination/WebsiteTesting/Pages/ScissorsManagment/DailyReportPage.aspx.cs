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
    public partial class DailyReportPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack == true)
            {
                return;
            }
            List<SectionModel> sectionList = SectionController.Select();
            sectionList.Insert(0, new SectionModel() { Name = "All" });
            ViewState["sectionList"] = sectionList;

            cboSection.DataSource = sectionList;
            cboSection.DataBind();
            
            string dateSearchDirectly = Request.Params["date"];
            if (!string.IsNullOrEmpty(dateSearchDirectly))
            {
                txtDatePicker.Text = dateSearchDirectly;
                SearchData();
            }
        }

        private void SearchData()
        {
            var dateSearchString = txtDatePicker.Text;
            if (!String.IsNullOrEmpty(dateSearchString) &&
                dateSearchString.Contains("/") &&
                dateSearchString.Split('/').Count() == 3)
            {
                var dateSearchStringSplit = dateSearchString.Split('/');
                int year = 0, month = 0, day = 0;

                Int32.TryParse(dateSearchStringSplit[0], out month);
                Int32.TryParse(dateSearchStringSplit[1], out day);
                Int32.TryParse(dateSearchStringSplit[2], out year);

                try
                {
                    var dateSearch = new DateTime(year, month, day);
                    var inspectionReportByDate = ScissorsMainController.GetInspectionReportByDate(dateSearch);

                    var sectionList = ViewState["sectionList"] as List<SectionModel>;
                    var sectionClicked = sectionList[cboSection.SelectedIndex];

                    UpdateDataTable(inspectionReportByDate, sectionClicked.Name);
                }
                catch (Exception ex)
                {
                    ShowAlert(ex.Message);
                }
            }
        }

        protected void cboSection_SelectedIndexChanged(object sender, EventArgs e)
        {
            SearchData();
        }
        
        protected void btnPreview_Click(object sender, EventArgs e)
        {
            SearchData();
        }

        protected void UpdateDataTable(List<InspectionReportModel> reportList, string section)
        {
            tableDailyReport.Rows.Clear();
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

            TableCell tcSmallHeader = new TableCell();
            tcSmallHeader.Text = "<b><center>SMALL</center></b>";
            tcSmallHeader.Width = 80;
            tcSmallHeader.ColumnSpan = 2;
            trHeader.Cells.Add(tcSmallHeader);

            TableCell tcBigHeader = new TableCell();
            tcBigHeader.Text = "<b><center>BIG</center></b>";
            tcBigHeader.Width = 80;
            tcBigHeader.ColumnSpan = 2;
            trHeader.Cells.Add(tcBigHeader);

            tableDailyReport.Rows.Add(trHeader);


            TableRow trHeaderDetail = new TableRow();

            TableCell tcHeaderSmallScan = new TableCell();
            tcHeaderSmallScan.Text = "<b><center>SCAN</center></b>";
            tcHeaderSmallScan.Width = 40;
            trHeaderDetail.Cells.Add(tcHeaderSmallScan);

            TableCell tcHeaderSmallNotScan = new TableCell();
            tcHeaderSmallNotScan.Text = "<b><center>NOT</center></b>";
            tcHeaderSmallNotScan.Width = 40;
            trHeaderDetail.Cells.Add(tcHeaderSmallNotScan);

            TableCell tcHeaderBigScan = new TableCell();
            tcHeaderBigScan.Text = "<b><center>SCAN</center></b>";
            tcHeaderBigScan.Width = 40;
            trHeaderDetail.Cells.Add(tcHeaderBigScan);

            TableCell tcHeaderBigNotScan = new TableCell();
            tcHeaderBigNotScan.Text = "<b><center>NOT</center></b>";
            tcHeaderBigNotScan.Width = 40;
            trHeaderDetail.Cells.Add(tcHeaderBigNotScan);

            tableDailyReport.Rows.Add(trHeaderDetail);

            //var lineList = issuanceList.Where(w => w.IsReturn == false).Select(s => s.Line).Distinct().ToList();
            var lineList = reportList.Select(s => s.Line).Distinct().ToList();
            if (!section.Equals("All"))
                lineList = reportList.Where(w => w.Section.Equals(section)).Select(s => s.Line).Distinct().ToList();

            int index = 1;
            int totalSmallScann = 0, totalSmallNotScan = 0, totalBigScan = 0, totalBigNotScan = 0;
            var regex = new Regex(@"\D");
            var lineCustomList = lineList.Select(s => new { Line = s, LineNumber = regex.IsMatch(s) ? regex.Replace(s, "") : s }).ToList();
            if (lineCustomList.Count() > 0)
                lineCustomList = lineCustomList.OrderBy(o => String.IsNullOrEmpty(o.LineNumber) ? 100 : Int32.Parse(o.LineNumber)).ThenBy(th => th.Line).ToList();

            foreach (var line in lineCustomList)
            {
                var reportListByLine                    = reportList.Where(w => w.Line == line.Line).ToList();

                var totalScissorsInspectedByLine        = reportListByLine.Where(w => w.Line.Equals(line.Line)).Select(s => s.ScissorsBarcode).Distinct().ToList();
                var totalSmallScissorsByLine            = reportListByLine.Where(w => w.IsBig == false).ToList();
                var totalBigScissorsByLine              = reportListByLine.Where(w => w.IsBig == true).ToList();

                var totalSmallInspected                 = reportListByLine.Where(w => w.InspectionDate != null && w.IsBig == false).ToList().Count();
                var totalBigInspected                   = reportListByLine.Where(w => w.InspectionDate != null && w.IsBig == true).ToList().Count();

                var totalSmallNotInspected              = totalSmallScissorsByLine.Count() - totalSmallInspected;
                var totalBigNotInspected                = totalBigScissorsByLine.Count() - totalBigInspected;

                totalSmallScann     += totalSmallInspected;
                totalSmallNotScan   += totalSmallNotInspected;
                totalBigScan        += totalBigInspected;
                totalBigNotScan     += totalBigNotInspected;

                TableRow tr = new TableRow();

                TableCell tcNoOf = new TableCell();
                tcNoOf.Text = string.Format("<center>{0}</center>", index);
                tr.Cells.Add(tcNoOf);

                TableCell tcLine = new TableCell();
                Session["InspectionReportByDate"] = reportList;
                var lnkLine = new HyperLink
                {
                    Text = line.Line,
                    NavigateUrl = String.Format("DailyReportDetailPage.aspx?line={0}", line.Line),
                };

                tcLine.Controls.Add(lnkLine);

                tr.Cells.Add(tcLine);

                string tatalSmallInspectedView = totalSmallInspected > 0 ? totalSmallInspected.ToString() : "";
                TableCell tcSmallScan = new TableCell();
                tcSmallScan.Text = string.Format("<center>{0}</center>", tatalSmallInspectedView);
                tr.Cells.Add(tcSmallScan);

                string totalSmallNotScanView = totalSmallNotInspected > 0 ? totalSmallNotInspected.ToString() : "";
                TableCell tcSmallNotScan = new TableCell();
                tcSmallNotScan.Text = string.Format("<center>{0}</center>", totalSmallNotScanView);
                tr.Cells.Add(tcSmallNotScan);

                string totalBigScanView = totalBigInspected > 0 ? totalBigInspected.ToString() : "";
                TableCell tcBigScan = new TableCell();
                tcBigScan.Text = string.Format("<center>{0}</center>", totalBigScanView);
                tr.Cells.Add(tcBigScan);

                string totalBigNotScanView = totalBigNotInspected > 0 ? totalBigNotInspected.ToString() : "";
                TableCell tcBigNotScan = new TableCell();
                tcBigNotScan.Text = string.Format("<center>{0}</center>", totalBigNotScanView);
                tr.Cells.Add(tcBigNotScan);

                tableDailyReport.Rows.Add(tr);

                index++;
            }

            TableRow trTotal = new TableRow();

            TableCell tcTotal = new TableCell();
            tcTotal.Text = string.Format("<center>{0}</center>", index);
            trTotal.Cells.Add(tcTotal);

            TableCell tcTotalLine = new TableCell();
            tcTotalLine.Text = string.Format("<center><b>Total</b></center>");
            trTotal.Cells.Add(tcTotalLine);

            string totalSmallViewTotal = totalSmallScann > 0 ? totalSmallScann.ToString() : "";
            TableCell tcSmallScanTotal = new TableCell();
            tcSmallScanTotal.Text = string.Format("<center><b>{0}</b></center>", totalSmallViewTotal);
            trTotal.Cells.Add(tcSmallScanTotal);

            string totalSmallNotScanViewTotal = totalSmallNotScan > 0 ? totalSmallNotScan.ToString() : "";
            TableCell tcSmallNotScanTotal = new TableCell();
            tcSmallNotScanTotal.Text = string.Format("<center><b>{0}</b></center>", totalSmallNotScanViewTotal);
            trTotal.Cells.Add(tcSmallNotScanTotal);

            string totalBigScanViewTotal = totalBigScan > 0 ? totalBigScan.ToString() : "";
            TableCell tcBigScanTotal = new TableCell();
            tcBigScanTotal.Text = string.Format("<center><b>{0}</b></center>", totalBigScanViewTotal);
            trTotal.Cells.Add(tcBigScanTotal);

            string totalBigNotScanViewTotal = totalBigNotScan > 0 ? totalBigNotScan.ToString() : "";
            TableCell tcBigNotScanTotal = new TableCell();
            tcBigNotScanTotal.Text = string.Format("<center><b>{0}</b></center>", totalBigNotScanViewTotal);
            trTotal.Cells.Add(tcBigNotScanTotal);

            tableDailyReport.Rows.Add(trTotal);
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