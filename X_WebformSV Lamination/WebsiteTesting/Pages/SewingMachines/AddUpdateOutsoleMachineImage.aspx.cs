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
using System.Globalization;
using System.Web.Script.Services;

namespace WebsiteTesting.Pages.SewingMachines
{
    public partial class AddUpdateOutsoleMachineImage : System.Web.UI.Page
    {
        private static string PREFIX_FOLDER_IMAGE = @"~/pics/OutsolePaperImage/";
        protected void Page_Load(object sender, EventArgs e)
        {
            var osMachineTypeList = CommonController.GetOutsoleMachineTypeList();
            var par = Request.Params["par"];
            Session["osPaperId"] = par;
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string LoadPage()
        {
            try
            {
                var osMachineTypeList = CommonController.GetOutsoleMachineTypeList();
                var par = HttpContext.Current.Session["osPaperId"];
                
                int idFromPar = 0;
                Int32.TryParse(par != null ? par.ToString() : "", out idFromPar);
                var osPaperMachineById = CommonController.GetOutsolePaperMachineById(idFromPar);
                var sectionList = osMachineTypeList.Select(s => s.SectionName).Distinct().ToList();
                if (osPaperMachineById != null)
                {
                    if (!String.IsNullOrEmpty(osPaperMachineById.LeftImagePath))
                        osPaperMachineById.LeftImageDisplay = PREFIX_FOLDER_IMAGE.Replace("~", "") + osPaperMachineById.LeftImagePath;
                    if (!String.IsNullOrEmpty(osPaperMachineById.RightImagePath))
                        osPaperMachineById.RightImageDisplay = PREFIX_FOLDER_IMAGE.Replace("~", "") + osPaperMachineById.RightImagePath;
                }
                var resource = new object[] { osMachineTypeList, sectionList, osPaperMachineById };
                //if (osPaperMachineById == null)
                //    resource = new object[] { osMachineTypeList, sectionList, "null" };
                return JsonConvert.SerializeObject(resource);
            }
            catch (Exception ex)
            {
                return String.Format("Exception: {0}", ex.InnerException.InnerException.Message.ToString());
            }
        }


        [WebMethod]
        public static string Upload(OutsolePaperMachineModel osPaperInsert)
        {
            // Convert Image
            try
            {
                // Left image
                if (osPaperInsert.LeftImageContent.Contains(","))
                {
                    var fileName = Guid.NewGuid() + ".png";
                    var imgSource = osPaperInsert.LeftImageContent.Split(',')[1].ToString().Replace("\">", "").ToString();
                    var leftImageBytes = Convert.FromBase64String(imgSource);
                    using (var mem = new MemoryStream(leftImageBytes))
                    {
                        var leftImg = System.Drawing.Image.FromStream(mem);
                        leftImg.Save(HttpContext.Current.Server.MapPath(PREFIX_FOLDER_IMAGE) + fileName, System.Drawing.Imaging.ImageFormat.Png);
                        osPaperInsert.LeftImagePath = fileName;
                    }
                }

                // Right image
                if (osPaperInsert.RightImageContent.Contains(","))
                {
                    var fileName = Guid.NewGuid() + ".png";
                    var imgSource = osPaperInsert.RightImageContent.Split(',')[1].ToString().Replace("\">", "").ToString();
                    var rightImageBytes = Convert.FromBase64String(imgSource);
                    using (var mem = new MemoryStream(rightImageBytes))
                    {
                        var rightImg = System.Drawing.Image.FromStream(mem);
                        rightImg.Save(HttpContext.Current.Server.MapPath(PREFIX_FOLDER_IMAGE) + fileName, System.Drawing.Imaging.ImageFormat.Png);
                        osPaperInsert.RightImagePath = fileName;
                    }
                }

                osPaperInsert.CreatedDate = ConvertDateStatic(osPaperInsert.CreatedDateString);
                var sucesss = CommonController.InsertOutsoleMachineImage(osPaperInsert);
                if (sucesss)
                    return "Successful";
                else
                    return "Can not insert data please try again !";
            }
            catch (Exception ex)
            {
                return String.Format("Exception: {0}", ex.Message.ToString());
            }

            //string imageString = "read the image string from XML file";
            //byte[] imageBytes = Convert.FromBase64String(imageString);
            //MemoryStream memStream = new MemoryStream(imageBytes);
            //Image image = Image.FromStream(memStream);

        }

        [WebMethod]
        public static string UploadImage(string updateWhat, 
        string sectionName, string lineName, string productNo, string style, string outsoleCode, string machineType ,string createdDate, string leftImage, string rightImage)
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

            // Create file name
            Guid guidobj = Guid.NewGuid();  // Generates a unique identifier
            var objName = guidobj.ToString();

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
                //LeftImage   = leftImageByte,
                //RightImage  = rightImageByte,
                //CreatedDate         = ConvertDateStatic(createdDate),
                //UpdateLeftImage     = leftImage != osImageEmpty.ImgString ? "UpdateLeftImage" : "None",
                //UpdateRightImage    = rightImage != osImageEmpty.ImgString ? "UpdateRightImage" : "None",
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

        public class UploadOSPaperModel
        {
            public int OutsolePaperType { get; set; }
            public string SectionName { get; set; }
            public string LineName { get; set; }
            public string ProductNo { get; set; }
            public string OutsoleCode { get; set; }
            public string MachineType { get; set; }
            public string CreatedDateString { get; set; }
            public string LeftImageContent { get; set; }
            public string RightImageContent { get; set; }
        }
    }
}