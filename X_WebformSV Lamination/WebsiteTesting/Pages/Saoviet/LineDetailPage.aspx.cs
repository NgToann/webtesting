using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using WebsiteTesting.Models.Saoviet;
using WebsiteTesting.Controllers.Saoviet;
using System.Data;
using System.Drawing;
namespace WebsiteTesting.Pages.Saoviet
{
    public partial class LineDetailPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.IsPostBack == false)
            {
                string lineId = Request.QueryString["LineId"];
                LineModel line = LineController.First(lineId);
                if (line == null)
                {
                    return;
                }
                lblLineName.Text = string.Format("<b>{0}</b>", line.LineName.ToUpper());
                DateTime date = DateTime.Now;
                List<ProductOutputModel> productOutputList = ProductOutputController.Select(lineId, date);
                List<QualityChecklistModel> qualityChecklistList = QualityChecklistController.Get(lineId, date);
                List<AlertModel> alertList = AlertController.Get(lineId, date);
                string[] productNoArray = productOutputList.Select(p => p.ProductNumber).Distinct().ToArray();
                string productNoString = "";
                foreach (string productNo in productNoArray)
                {
                    productNoString += string.Format("<b>{0}</b>; ", productNo);
                }
                lblProductNo.Text = productNoString;
                int outputLine = productOutputList.Count();
                lblOutput.Text = string.Format("<b>{0}prs</b>", outputLine);
                int defectLine = qualityChecklistList.Count();
                double rftLine = 0;
                if (outputLine > 0)
                {
                    rftLine = Math.Round((double)(100 - 100 * ((double)defectLine / (double)outputLine)), 2);
                }
                lblRft.Text = string.Format("<b>{0}%</b>", rftLine);
                List<TimelineModel> timelineList = TimelineController.Get();
                DataTable dt = new DataTable();
                dt.Columns.Add("BackColor", typeof(Color));
                dt.Columns.Add("DefectName", typeof(string));
                gridViewLineDetail.Columns.Add(new BoundField() { HeaderText = "", DataField = "DefectName", ItemStyle = { Wrap = false} });
                foreach (TimelineModel timeline in timelineList)
                {
                    dt.Columns.Add(string.Format("Timeline{0}", timeline.TimeLineId), typeof(string));
                    gridViewLineDetail.Columns.Add(new BoundField()
                    {
                        HeaderText = string.Format("{0}:{1}-{2}:{3}", timeline.StartTime.Hours, timeline.StartTime.Minutes, timeline.EndTime.Hours, timeline.EndTime.Minutes),
                        DataField = string.Format("Timeline{0}", timeline.TimeLineId),
                        HeaderStyle = { BackColor = System.Drawing.Color.LightGray, ForeColor = System.Drawing.Color.Blue },
                        ItemStyle = { HorizontalAlign = HorizontalAlign.Center },
                    });
                }

                //Product Output
                DataRow drOutput = dt.NewRow();
                drOutput["BackColor"] = Color.RoyalBlue;
                drOutput["DefectName"] = "Hourly Output";
                foreach (TimelineModel timeline in timelineList)
                {
                    int outputHourly = productOutputList.Where(p => p.ModifiedTime.TimeOfDay >= timeline.StartTime && p.ModifiedTime.TimeOfDay < timeline.EndTime).Count();
                    drOutput[string.Format("Timeline{0}", timeline.TimeLineId)] = string.Format("{0}", outputHourly);
                }
                dt.Rows.Add(drOutput);

                //Quality Checklist
                Color[] alertColorArray = { Color.White, Color.Yellow, Color.Orange, Color.Red };
                List<FaultModel> faultList = FaultController.Select(line.LineType);
                string[] defectIdArray = qualityChecklistList.GroupBy(q => q.FaultId).Select(q => new { FaultId = q.Key, Count = q.Count() }).OrderByDescending(q => q.Count).Select(q => q.FaultId).ToArray();
                foreach (string defectId in defectIdArray)
                {
                    FaultModel fault = faultList.Where(f => f.FaultId == defectId).FirstOrDefault();
                    if (fault != null)
                    {
                        DataRow drDefect = dt.NewRow();
                        AlertModel alert = alertList.Where(a => a.FaultId.ToString() == fault.FaultId).FirstOrDefault();
                        drDefect["BackColor"] = alertColorArray[0];
                        if (alert != null)
                        {
                            drDefect["BackColor"] = alertColorArray[alert.AlertCode];
                        }
                        drDefect["DefectName"] = string.Format("[{0}] {1}", fault.KeyString, fault.FaultEnglish);
                        dt.Rows.Add(drDefect);
                        List<QualityChecklistModel> qualityChecklistList_ByDefectId = qualityChecklistList.Where(q => q.FaultId == defectId).ToList();
                        foreach (TimelineModel timeline in timelineList)
                        {
                            int defectHourly = qualityChecklistList_ByDefectId.Where(q => q.ModifiedTime.TimeOfDay >= timeline.StartTime && q.ModifiedTime.TimeOfDay < timeline.EndTime).Count();
                            drDefect[string.Format("Timeline{0}", timeline.TimeLineId)] = string.Format("{0}", defectHourly);
                        }
                    }
                }

                //Set Data Source
                gridViewLineDetail.DataSource = dt;
                gridViewLineDetail.DataBind();
            }
        }

        protected void gridViewLineDetail_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow)
            {
                return;
            }
            DataRow dr = (e.Row.DataItem as DataRowView).Row as DataRow;
            Color alertColor = (dr["BackColor"] as Color?).Value;
            e.Row.BackColor = alertColor;
        }
    }
}