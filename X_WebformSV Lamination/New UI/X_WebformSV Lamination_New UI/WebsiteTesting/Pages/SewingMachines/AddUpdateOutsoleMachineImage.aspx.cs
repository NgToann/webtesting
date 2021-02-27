using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using WebsiteTesting.Controllers.SewingMachineController;
using WebsiteTesting.Models.SewingMachine;
using Newtonsoft.Json;
using System.IO;


namespace WebsiteTesting.Pages.SewingMachines
{
    public partial class AddUpdateOutsoleMachineImage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
                return;
            var osMachineTypeList = CommonController.GetOutsoleMachineTypeList();
            cboMachineType.DataSource = osMachineTypeList.Select(s => s.MachineType).Distinct().ToList();
            cboMachineType.DataBind();

            cboSectionName.DataSource = osMachineTypeList.Select(s => s.SectionName).Distinct().ToList();
            cboSectionName.DataBind();

            var par = Request.Params["par"];
            // Not Null is Update
            if (!String.IsNullOrEmpty(par))
            {
                try
                {
                    var osImageEmpty = new OutsoleImageEmpty();

                    lblTitle.Text = "Update Image Machine";
                    int idFromPar = 0;
                    Int32.TryParse(par, out idFromPar);
                    var osPaperMachineById = CommonController.GetOutsolePaperMachineById(idFromPar);

                    var mType = osMachineTypeList.FirstOrDefault(f => f.MachineType.Equals(osPaperMachineById.MachineType));
                    cboMachineType.SelectedValue = mType != null ? mType.MachineType : "";

                    var sectionX = osMachineTypeList.FirstOrDefault(f => f.SectionName.Equals(osPaperMachineById.SectionName));
                    cboSectionName.SelectedValue = sectionX != null ? sectionX.SectionName : "";

                    txtLine.Text = osPaperMachineById.LineName;
                    txtProductNo.Text = osPaperMachineById.ProductNo;
                    txtStyleName.Text = osPaperMachineById.StyleName;
                    txtOutsoleCode.Text = osPaperMachineById.OutsoleCode;
                    txtCreatedDate.Text = string.Format("{0:MM/dd/yyyy}", osPaperMachineById.CreatedDate);

                    //divLeftImage.InnerHtml = "<img src=\"data:image/jpeg;base64," + osPaperMachineById.LeftImageString + "\">";
                    var leftImage = new Image();
                    if (osPaperMachineById.LeftImage != Convert.FromBase64String(osImageEmpty.ImgString))
                    {
                        leftImage.ImageUrl = "data:image/png;base64," + Convert.ToBase64String(osPaperMachineById.LeftImage);
                        divLeftImage.Controls.Add(leftImage);
                    }

                    var rightImage = new Image();
                    if (osPaperMachineById.RightImage != Convert.FromBase64String(osImageEmpty.ImgString))
                    {
                        rightImage.ImageUrl = "data:image/png;base64," + Convert.ToBase64String(osPaperMachineById.RightImage);                        
                        divRightImage.Controls.Add(rightImage);
                    }
                    
                    lblId.Text = string.Format("{0}", osPaperMachineById.OutsolePaperImageId);
                }
                catch (Exception ex) {
                    ShowAlert(ex.Message.ToString());
                }
            }
        }

        [WebMethod]
        public static string UploadImage(string updateWhat, string sectionName, string lineName, string productNo, string style, string outsoleCode, string machineType ,string createdDate, string leftImage, string rightImage)
        {
            var osImageEmpty = new OutsoleImageEmpty();

            var leftImageByte = Convert.FromBase64String(osImageEmpty.ImgString);
            if (!String.IsNullOrEmpty(leftImage))
            {
                var leftImageSplit = leftImage.Split(',')[1].ToString().Replace("\">", "").ToString();
                leftImageByte = Convert.FromBase64String(leftImageSplit);
            }

            var rightImageByte = Convert.FromBase64String(osImageEmpty.ImgString);
            if (!String.IsNullOrEmpty(rightImage))
            {
                var rightImageSplit = rightImage.Split(',')[1].ToString().Replace("\">", "").ToString();
                rightImageByte = Convert.FromBase64String(rightImageSplit);
            }


            //byte[] imgLeftByte  = Convert.FromBase64String(leftImage);
            //byte[] imgRightByte = Convert.FromBase64String(rightImage);

            int outsolePaperImageId = 0;
            Int32.TryParse(updateWhat, out outsolePaperImageId);

            var modelUpdate = new OutsolePaperMachineModel
            {
                OutsolePaperImageId = outsolePaperImageId,
                SectionName = sectionName,
                LineName    = lineName,
                ProductNo   = productNo,
                StyleName   = style,
                OutsoleCode = outsoleCode,
                MachineType = machineType,
                LeftImage   = leftImageByte,
                RightImage  = rightImageByte,
                CreatedDate         = ConvertDateStatic(createdDate),
                UpdateLeftImage     = leftImage != osImageEmpty.ImgString ? "UpdateLeftImage" : "None",
                UpdateRightImage    = rightImage != osImageEmpty.ImgString ? "UpdateRightImage" : "None",
            };

            try
            {
                CommonController.InsertOutsoleMachineImage(modelUpdate);
                return "Successful !";
            }
            catch (Exception ex)
            {
                return ex.Message.ToString();
            }
        }

        [WebMethod]
        public static string DeleteRecord(string deleteWhat)
        {
            int idDelete = 0;
            Int32.TryParse(deleteWhat, out idDelete);
            try 
            {
                CommonController.DeleteOSMachineById(idDelete);
                return "Successful !";
            }
            catch (Exception ex)
            {
                return ex.Message.ToString();
            }
        }

        private static DateTime ConvertDateStatic(string dateString)
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