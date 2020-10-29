using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using WebsiteTesting.Models.Saoviet;
using WebsiteTesting.Controllers.Saoviet;
using System.Drawing;
namespace WebsiteTesting.Pages.Saoviet
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.IsPostBack == false)
            {
                List<LineModel> lineList = LineController.Select();
                DateTime date = DateTime.Now;
                List<ProductOutputModel> productOutputList = ProductOutputController.Select(date);
                List<QualityChecklistModel> qualityChecklistList = QualityChecklistController.Get(date);
                List<AlertModel> alertList = AlertController.Get(date);

                Color[] alertColorArray = { Color.White, Color.Yellow, Color.Orange, Color.Red };
                string[] sectionArray = lineList.Select(l => l.LineType).Distinct().ToArray();
                int i = 1;
                foreach (string section in sectionArray)
                {
                    TableRow trSection = new TableRow();
                    TableCell tcSection = new TableCell();
                    tcSection.ColumnSpan = 5;
                    tcSection.Text = string.Format("{0}. <b>SECTION {1}<b/>", i, section.ToUpper());                    
                    tcSection.ForeColor = Color.Blue;
                    tcSection.BackColor = Color.LightGray;
                    trSection.Cells.Add(tcSection);
                    tableMain.Rows.Add(trSection);

                    TableRow trLineHeader = new TableRow();
                    TableCell tcLineNoHeader = new TableCell();
                    trLineHeader.Cells.Add(tcLineNoHeader);

                    TableCell tcLineNameHeader = new TableCell();
                    tcLineNameHeader.Text = "<b>LINE</b>";
                    trLineHeader.Cells.Add(tcLineNameHeader);

                    TableCell tcOutputHeader = new TableCell();
                    tcOutputHeader.Text = "<b>OUTPUT</b>";
                    trLineHeader.Cells.Add(tcOutputHeader);

                    TableCell tcRftHeader = new TableCell();
                    tcRftHeader.Text = "<b>RFT</b>";
                    trLineHeader.Cells.Add(tcRftHeader);

                    TableCell tcDetailHeader = new TableCell();
                    trLineHeader.Cells.Add(tcDetailHeader);
                    tableMain.Rows.Add(trLineHeader);

                    List<LineModel> lineList_BySection = lineList.Where(l => l.LineType == section).ToList();
                    int j = 1;
                    foreach (LineModel line in lineList_BySection)
                    {
                        TableRow trLine = new TableRow();
                        AlertModel alertLine = alertList.Where(a => a.LineId.ToString() == line.LineId).OrderBy(a => a.AlertCode).LastOrDefault();
                        if (alertLine != null)
                        {
                            trLine.BackColor = alertColorArray[alertLine.AlertCode];
                        }
                        TableCell tcLineNo = new TableCell();
                        tcLineNo.Text = string.Format("{1}.", i, j);
                        trLine.Cells.Add(tcLineNo);

                        TableCell tcLineName = new TableCell();
                        tcLineName.Text = string.Format("{0}", line.LineName.ToUpper());                        
                        trLine.Cells.Add(tcLineName);

                        List<ProductOutputModel> productOutputList_ByLineId = productOutputList.Where(p => p.LineId == line.LineId).ToList();
                        int outputLine = productOutputList_ByLineId.Count();
                        List<QualityChecklistModel> qualityChecklistList_ByLineId = qualityChecklistList.Where(q => q.LineId == line.LineId).ToList();
                        int defectLine = qualityChecklistList_ByLineId.Count();
                        double rftLine = 0;
                        if (outputLine > 0)
                        {
                            rftLine = Math.Round((double)(100 - 100 * ((double)defectLine / (double)outputLine)), 2);
                        }
                        TableCell tcOutput = new TableCell();
                        tcOutput.Text = string.Format("<b>{0}<b>prs", outputLine);
                        trLine.Cells.Add(tcOutput);

                        TableCell tcRft = new TableCell();
                        tcRft.Text = string.Format("{0}%", rftLine);
                        trLine.Cells.Add(tcRft);

                        TableCell tcDetail = new TableCell();
                        HyperLink hyperLinkDetail = new HyperLink();
                        hyperLinkDetail.Text = "Detail ...";
                        hyperLinkDetail.NavigateUrl = string.Format("~/Pages/Saoviet/LineDetailPage.aspx?LineId={0}", line.LineId);
                        tcDetail.Controls.Add(hyperLinkDetail);
                        //tcDetail.Text = string.Format(@"<a href='/Pages/Saoviet/LineDetailPage.aspx?LineId={0}'>Detail...<a>", line.LineId);
                        trLine.Cells.Add(tcDetail);

                        tableMain.Rows.Add(trLine);
                        j = j + 1;
                    }                   
                    i = i + 1;
                }
            }
        }
        
    }
}