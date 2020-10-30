﻿using System;
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

            var osMachineTypeList = CommonController.GetOutsoleMachineTypeList().Select(s => s.MachineType).ToList();
            cboMachineType.DataSource = osMachineTypeList;
            cboMachineType.DataBind();

            var par = Request.Params["par"];
            // Not Null is Update
            if (!String.IsNullOrEmpty(par))
            {
                try
                {
                    lblTitle.Text = "Update Image Machine";
                    int idFromPar = 0;
                    Int32.TryParse(par, out idFromPar);
                    var osPaperMachineById = CommonController.GetOutsolePaperMachineById(idFromPar);
                    var x = osMachineTypeList.FirstOrDefault(f => f.Equals(osPaperMachineById.MachineType));
                    cboMachineType.SelectedValue = x;

                    txtSection.Text = osPaperMachineById.SectionName;
                    txtLine.Text = osPaperMachineById.LineName;
                    txtProductNo.Text = osPaperMachineById.ProductNo;
                    txtStyleName.Text = osPaperMachineById.StyleName;
                    txtOutsoleCode.Text = osPaperMachineById.OutsoleCode;
                    txtCreatedDate.Text = string.Format("{0:MM/dd/yyyy}", osPaperMachineById.CreatedDate);

                    imgLeftDisplay.ImageUrl = "data:image;base64," + Convert.ToBase64String(osPaperMachineById.LeftImage);
                    imgLeftDisplay.Visible = true;

                    imgRightDisplay.ImageUrl = "data:image;base64," + Convert.ToBase64String(osPaperMachineById.RightImage);
                    imgRightDisplay.Visible = true;

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

            byte[] imgLeftByte  = Convert.FromBase64String(leftImage);
            byte[] imgRightByte = Convert.FromBase64String(rightImage);

            int outsolePaperImageId = 0;
            if (!String.IsNullOrEmpty(updateWhat))
            {
                Int32.TryParse(updateWhat, out outsolePaperImageId);
            }

            var modelUpdate = new OutsolePaperMachineModel
            {
                OutsolePaperImageId = outsolePaperImageId,
                SectionName = sectionName,
                LineName    = lineName,
                ProductNo   = productNo,
                StyleName   = style,
                OutsoleCode = outsoleCode,
                MachineType = machineType,
                CreatedDate = ConvertDateStatic(createdDate),
                LeftImage   = imgLeftByte,
                RightImage  = imgRightByte,
                UpdateLeftImage = leftImage != osImageEmpty.ImgString ? "UpdateLeftImage" : "None",
                UpdateRightImage = rightImage != osImageEmpty.ImgString ? "UpdateRightImage" : "None",
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