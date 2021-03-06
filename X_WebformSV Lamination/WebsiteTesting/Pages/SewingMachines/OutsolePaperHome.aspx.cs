using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebsiteTesting.Controllers.SewingMachineController;
using WebsiteTesting.Models.SewingMachine;

namespace WebsiteTesting.Pages.SewingMachines
{
    public partial class OutsolePaperHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
                return;
            LoadData();
        }
        
        private void LoadData()
        {
            var osMachineList = CommonController.GetOutsolePaperMachineList();

            tblListOfMahineImage.Rows.Clear();

            // Header
            TableRow trHeader = new TableRow();

            TableCell tcNoOfHeader = new TableCell();
            tcNoOfHeader.Text = "<b><center>No.</center></b>";
            trHeader.Cells.Add(tcNoOfHeader);

            TableCell tchSectionName = new TableCell();
            tchSectionName.Text = "<b><center>Section</center></b>";
            trHeader.Cells.Add(tchSectionName);

            TableCell tchLineName = new TableCell();
            tchLineName.Text = "<b><center>Line</center></b>";
            trHeader.Cells.Add(tchLineName);

            TableCell tchStyleName = new TableCell();
            tchStyleName.Text = "<b><center>Style</center></b>";
            trHeader.Cells.Add(tchStyleName);

            TableCell tchOutsoleCode = new TableCell();
            tchOutsoleCode.Text = "<b><center>O/S Code</center></b>";
            trHeader.Cells.Add(tchOutsoleCode);

            TableCell tchMachineType = new TableCell();
            tchMachineType.Text = "<b><center>Machine Type</center></b>";
            trHeader.Cells.Add(tchMachineType);

            TableCell tchCreatedDate = new TableCell();
            tchCreatedDate.Text = "<b><center>Created Date</center></b>";
            trHeader.Cells.Add(tchCreatedDate);

            TableCell tchLeftImage = new TableCell();
            tchLeftImage.Text = "<b><center>Left Image</center></b>";
            trHeader.Cells.Add(tchLeftImage);

            TableCell tchRightImage = new TableCell();
            tchRightImage.Text = "<b><center>Right Image</center></b>";
            trHeader.Cells.Add(tchRightImage);

            tblListOfMahineImage.Rows.Add(trHeader);

            // Content
            int noOfRow = 1;
            foreach (var osMachine in osMachineList)
            {
                TableRow trContent = new TableRow();

                TableCell trcNoOfRow = new TableCell();
                trcNoOfRow.Text = String.Format("<center>{0}</center>",noOfRow);
                trContent.Cells.Add(trcNoOfRow);

                TableCell trcSection = new TableCell();
                trcSection.Text = String.Format("{0}", osMachine.SectionName);
                trContent.Cells.Add(trcSection);

                TableCell trcLineName = new TableCell();
                trcLineName.Text = String.Format("{0}", osMachine.LineName);
                trContent.Cells.Add(trcLineName);

                TableCell trcStyleName = new TableCell();
                trcStyleName.Text = String.Format("{0}", osMachine.StyleName);
                trContent.Cells.Add(trcStyleName);

                TableCell trcOSCOde = new TableCell();
                trcOSCOde.Text = String.Format("{0}", osMachine.OutsoleCode);
                trContent.Cells.Add(trcOSCOde);

                TableCell trcMachineType = new TableCell();
                trcMachineType.Text = String.Format("{0}", osMachine.MachineType);
                trContent.Cells.Add(trcMachineType);

                TableCell trcCreatedDate = new TableCell();
                trcCreatedDate.Text = String.Format("{0:MM/dd/yyyy}", osMachine.CreatedDate);
                trContent.Cells.Add(trcCreatedDate);

                TableCell trcLeftImage = new TableCell();
                //if (!osMachine.LeftImageString.Equals("Null"))
                //{
                    var leftMachineLink = new HyperLink
                    {
                        Text = String.Format("L-{0}", osMachine.MachineType),
                        NavigateUrl = String.Format("AddUpdateOutsoleMachineImage.aspx?par={0}", osMachine.OutsolePaperImageId),
                        CssClass = "btn btn-outline-info btn-sm rounded-0"
                    };
                    trcLeftImage.Controls.Add(leftMachineLink);
                //}
                trContent.Cells.Add(trcLeftImage);

                TableCell trcRightImage = new TableCell();
                //if (!osMachine.RightImageString.Equals("Null"))
                //{
                    var rightMachineLink = new HyperLink
                    {
                        Text =  String.Format("R-{0}", osMachine.MachineType),
                        NavigateUrl = String.Format("AddUpdateOutsoleMachineImage.aspx?par={0}", osMachine.OutsolePaperImageId),
                        CssClass = "btn btn-outline-danger btn-sm rounded-0"
                    };
                    trcRightImage.Controls.Add(rightMachineLink);
                //}
                trContent.Cells.Add(trcRightImage);

                tblListOfMahineImage.Rows.Add(trContent);
                noOfRow++;
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