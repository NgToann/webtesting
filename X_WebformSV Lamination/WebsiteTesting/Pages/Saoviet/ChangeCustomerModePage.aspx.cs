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
    public partial class ChangeCustomerModePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            List<LineModel> lineList = LineController.Select();
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

                TableCell tcLineIdHeader = new TableCell();
                tcLineIdHeader.Text = "<b>LINE</b>";
                trLineHeader.Cells.Add(tcLineIdHeader);

                TableCell tcLineNameHeader = new TableCell();
                tcLineNameHeader.Text = "<b>NAME</b>";
                trLineHeader.Cells.Add(tcLineNameHeader);

                TableCell tcStatusHeader = new TableCell();
                tcStatusHeader.Text = "<b>STATUS</b>";
                trLineHeader.Cells.Add(tcStatusHeader);

                tableMain.Rows.Add(trLineHeader);

                List<LineModel> lineList_BySection = lineList.Where(l => l.LineType == section).ToList();
                int j = 1;
                foreach (LineModel line in lineList_BySection)
                {
                    TableRow trLine = new TableRow();
                    TableCell tcLineId = new TableCell();
                    tcLineId.Text = line.LineId;
                    trLine.Cells.Add(tcLineId);

                    TableCell tcLineName = new TableCell();
                    tcLineName.Text = string.Format("{0}", line.LineName.ToUpper());
                    trLine.Cells.Add(tcLineName);

                    TableCell tcDetail = new TableCell();
                    Button btnStatus = new Button();
                    btnStatus.ID = line.LineId;
                    btnStatus.Font.Bold = true;
                    if (line.RemoveFlag == true)
                    {
                        btnStatus.Text = "On";
                        btnStatus.ForeColor = Color.Green;
                        btnStatus.ToolTip = "Click to Turn Off Customer Mode";
                    }
                    else
                    {
                        btnStatus.Text = "Off";
                        btnStatus.ForeColor = Color.Red;
                        btnStatus.ToolTip = "Click to Turn On Customer Mode";
                    }                    
                    
                    btnStatus.Click += new EventHandler(btnStatus_Click);
                    tcDetail.Controls.Add(btnStatus);
                    trLine.Cells.Add(tcDetail);

                    tableMain.Rows.Add(trLine);
                    j = j + 1;
                }
                i = i + 1;
            }
        }

        private void btnStatus_Click(object sender, EventArgs e)
        {
            Button btnStatus = sender as Button;
            string lineId = btnStatus.ID;
            string statusText = btnStatus.Text;
            if (statusText == "On")
            {
                LineController.ChangeRemoveFlag(lineId, false);                
                btnStatus.Text = "Off";
                btnStatus.ForeColor = Color.Red;
                btnStatus.ToolTip = "Click to Turn On Customer Mode";
                return;
            }
            else if (statusText == "Off")
            {
                LineController.ChangeRemoveFlag(lineId, true);            
                btnStatus.Text = "On";
                btnStatus.ForeColor = Color.Green;
                btnStatus.ToolTip = "Click to Turn Off Customer Mode";
                return;
            }
        }

        protected void btnOnAllLine_Click(object sender, EventArgs e)
        {
            LineController.ChangeRemoveFlag(true);
            Response.Redirect(Request.RawUrl);
        }

        protected void btnOffAllLine_Click(object sender, EventArgs e)
        {
            LineController.ChangeRemoveFlag(false);
            Response.Redirect(Request.RawUrl);
        }
    }
}