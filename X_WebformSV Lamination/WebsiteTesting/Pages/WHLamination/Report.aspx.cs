using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Microsoft.Reporting.WebForms;

using WebsiteTesting.DataSets.WHLamination;
using WebsiteTesting.Models.WHLamination;
using WebsiteTesting.Controllers.WHLamination;

namespace WebsiteTesting.Pages.WHLamination
{
    public partial class Report : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
                return;
        }

        protected void btnPreview_Click(object sender, EventArgs e)
        {
            var dtDefault = new DateTime(1999, 12, 31);

            var fromDateString = txtStart.Text.Trim().ToString();
            var toDateString = txtFinish.Text.Trim().ToString();

            var fromDate    = ConvertDate(fromDateString);
            var toDate      = ConvertDate(toDateString);

            if (fromDate == dtDefault || toDate == dtDefault)
            {
                ShowAlert("FromDate or ToDate is invalid !");
                return;
            }
            
            try {

                DataTable dt = new WHLaminationDataSet().Tables[0];

                var whlReportList = ReportController.GetWHLaminationUser(fromDate, toDate);
                foreach(var whlReport in whlReportList)
                {
                    DataRow dr          = dt.NewRow();
                    dr["Date"]          = String.Format("{0:MM/dd/yyyy}", whlReport.CreatedTime);
                    dr["ProductNoList"] = whlReport.ProductNoList;
                    dr["MaterialDescription"] = whlReport.MaterialName;
                    dr["CaseNo"]        = "";
                    dr["LabelQuantity"] = whlReport.LabelQuantity.ToString();
                    dr["ActualQuantity"] = whlReport.ActualQuantity.ToString();
                    dr["RemainingQuantity"] = (whlReport.LabelQuantity - whlReport.ActualQuantity).ToString();
                    dr["LabelWidth"]    = whlReport.LabelWidth.ToString();
                    dr["ActualWidth"]   = whlReport.ActualWidth.ToString();
                    dr["Length"]        = "";
                    dr["Width"]         = "";
                    dr["Supplier"]      = whlReport.SupplierName;
                    dr["DefectType1"]   = whlReport.DefectType1.ToString();
                    dr["DefectType2"]   = whlReport.DefectType2.ToString();
                    dr["DefectType3"]   = whlReport.DefectType3.ToString();
                    dr["DefectType4"]   = whlReport.DefectType4.ToString();
                    dr["HoleType2"]     = whlReport.HoleType2.ToString();
                    dr["HoleType4"]     = whlReport.HoleType4.ToString();

                    //dr["TotalPoints"]   = whlReport.TotalScore.ToString();
                    //(Total points / Actual Qty) *(36 / Actual width) *100
                    var pointPerYards = ((double)whlReport.TotalScore / (double)whlReport.ActualQuantity) * (36.0 / (double)whlReport.ActualWidth) * 100;
                    //dr["PointPerYards"] = pointPerYards.ToString("N0");

                    // Revise
                    dr["TotalPoints"] = whlReport.TotalDefect.ToString();
                    dr["PointPerYards"] = whlReport.TotalScore.ToString();

                    dr["Accept"]        = whlReport.TotalScore <= 20 ? "Accept" : "";
                    dr["Reject"]        = whlReport.TotalScore > 20 ? "Reject" : "";
                    dr["Remarks"]       = whlReport.Remarks;

                    dt.Rows.Add(dr);
                }

                reportViewer.LocalReport.ReportPath = @"Reports\WHLamination\WHLaminationReport.rdlc";
                //ReportParameter rpProductNo = new ReportParameter("ProductNo", productNo);
                ReportDataSource rds = new ReportDataSource();
                rds.Name = "WHLaminationSource";
                rds.Value = dt;
                //reportViewer.LocalReport.SetParameters(new ReportParameter[] { rpProductNo, rpPackingDate, rpTotalWeight });
                reportViewer.LocalReport.DataSources.Clear();
                reportViewer.LocalReport.DataSources.Add(rds);
            }
            catch (Exception ex)
            {
                ShowAlert(String.Format("{0}", ex.Message.ToString()));
                return;
            }
        }
        private DateTime ConvertDate(string dateString)
        {
            DateTime result = new DateTime(1999, 12, 31);
            try
            {
                if (!String.IsNullOrEmpty(dateString) &&
                    dateString.Contains("/") &&
                    dateString.Split('/').Count() == 3)
                {
                    var dateSearchStringSplit = dateString.Split('/');
                    int year = 0, month = 0, day = 0;
                    //11/16/1992
                    Int32.TryParse(dateSearchStringSplit[0], out month);
                    Int32.TryParse(dateSearchStringSplit[1], out day);
                    Int32.TryParse(dateSearchStringSplit[2], out year);

                    result = new DateTime(year, month, day);
                }
            }
            catch { return result; }
            return result;
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