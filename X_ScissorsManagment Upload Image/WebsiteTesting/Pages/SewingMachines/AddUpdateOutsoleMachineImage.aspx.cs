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
using System.Drawing;
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

        }

        [WebMethod]
        public static string UploadImage(string sectionName, string lineName, string productNo, string style, string outsoleCode, string createdDate, string leftImage, string rightImage)
        {
            byte[] imgLeftByte  = Convert.FromBase64String(leftImage);
            byte[] imgRightByte = Convert.FromBase64String(rightImage);

            using (var str = new MemoryStream(imgLeftByte))
            {
                var bitmapFromStream = new Bitmap(str);

            };

            var modelUpdate = new OutsolePaperMachineModel
            {
                SectionName = sectionName,
                LineName    = lineName,
                ProductNo = productNo,
                StyleName = style,
                OutsoleCode = outsoleCode,
                CreatedDate = ConvertDateStatic(createdDate),
                LeftImage = imgLeftByte,
                RightImage = imgRightByte
            };

            try
            {
                CommonController.InsertOutsoleMachineImage(modelUpdate);
                return "Saved !";
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
        //public static byte[] GetJPGFromBitmapImage(Bitmap bitmapImage)
        //{
        //    //MemoryStream memoryStream = new MemoryStream();
        //    //bitmapImage.Save(memoryStream, ImageFormat.Jpeg);
        //    //return memoryStream.ToArray();
        //}
    }
}