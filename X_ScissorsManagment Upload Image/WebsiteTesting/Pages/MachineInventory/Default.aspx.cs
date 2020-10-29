using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using BarcodeLib.BarcodeReader;
using System.Drawing;

namespace WebsiteTesting.Pages.MachineInventory
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            string[] fileExtension = { ".jpg", ".JPG", ".png", ".PNG", ".gif", ".GIF" };
            if (fileUpload.HasFile == false || (fileExtension.Contains(Path.GetExtension(fileUpload.FileName)) == false))
            {
                return;
            }
            string fileFolder = string.Format("{0}/Barcode/", Server.MapPath("~/Uploads"));
            string fileUrlFolder = string.Format("{0}/Barcode/", "~/Uploads");
            if (Directory.Exists(fileFolder) == false)
            {
                Directory.CreateDirectory(fileFolder);
            }
            string filePath = fileFolder + fileUpload.FileName;
            string fileUrlPath = fileUrlFolder + fileUpload.FileName;
            fileUpload.SaveAs(filePath);
            imageBarcode.ImageUrl = fileUrlPath;
            imageBarcode.DataBind();
            string[] results = BarcodeReader.read(filePath, BarcodeReader.QRCODE);
            if (results != null)
            {
                lblResult.Text = results.FirstOrDefault();
                lblResult.ForeColor = Color.Green;
            }
            else
            {
                lblResult.ForeColor = Color.Red;
                lblResult.Text = "Error";
            }
        }
    }
}