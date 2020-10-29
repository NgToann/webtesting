using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebsiteTesting.Models.LoadingSystem;
using System.Reflection;
using System.IO;
using WebsiteTesting.Controllers.LoadingSystem;
using System.Data.OleDb;
using System.Data;
namespace WebsiteTesting.Pages.LoadingSystem
{
    public partial class ImportPackingListPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRead_Click(object sender, EventArgs e)
        {
            btnImport.Enabled = false;
            if (fileUpload.HasFile == false || (Path.GetExtension(fileUpload.FileName) != ".xls" && Path.GetExtension(fileUpload.FileName) != ".xlsx"))
            {
                return;
            }
            lblStatus.Text = "Uploading...";
            List<CartonNumberingModel> cartonNumberingList = new List<CartonNumberingModel>();
            List<CartonNumberingDetailModel> cartonNumberingDetailList = new List<CartonNumberingDetailModel>();
            ViewState["cartonNumberingList"] = cartonNumberingList;
            ViewState["cartonNumberingDetailList"] = cartonNumberingDetailList;
            string fileFolder = string.Format("{0}/{1:dd-MM-yyyy}/", Server.MapPath("~/Uploads"), DateTime.Now);
            if (Directory.Exists(fileFolder) == false)
            {
                Directory.CreateDirectory(fileFolder);
            }
            string filePath = fileFolder + fileUpload.FileName;
            fileUpload.SaveAs(filePath);
            lblStatus.Text = "Upload-ed. Reading...";

            FileInfo fileInfo = new FileInfo(filePath);
            if (fileInfo.Exists == false)
            {                
                return;
            }
            string fileExtension = fileInfo.Extension;

            //string excel2003ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source={0};Extended Properties='Excel 8.0;HDR={1}'";
            string excel2007ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties='Excel 8.0;HDR={1}'";
            string connectionString = excel2007ConnectionString;
            if (fileExtension == ".xlsx")
            {
                connectionString = excel2007ConnectionString;
            }
            connectionString = string.Format(connectionString, filePath, "No");
            OleDbConnection excelConnection = new OleDbConnection(connectionString);
            try
            {                
                OleDbCommand excelCommand = new OleDbCommand();
                OleDbDataAdapter excelDataAdapter = new OleDbDataAdapter();
                excelCommand.Connection = excelConnection;

                excelConnection.Open();
                DataTable dtExcelSchema;
                dtExcelSchema = excelConnection.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
                string sheetName = dtExcelSchema.Rows[0]["TABLE_NAME"].ToString();                
                DataTable dt = new DataTable();
                excelCommand.CommandText = string.Format("SELECT * FROM [{0}]", sheetName);
                excelDataAdapter.SelectCommand = excelCommand;
                excelDataAdapter.Fill(dt);
                excelConnection.Close();

                var productNoCell = dt.Rows[0][0];
                if (productNoCell != null)
                {
                    string productNo = productNoCell.ToString().Split('/')[0].Replace("PROD. NO:", "").Trim();
                    if (string.IsNullOrEmpty(productNo) == false)
                    {
                        int i = 1;
                        for (int x = 1; x <= dt.Columns.Count - 1; x++)
                        {
                            var sizeNoCell = dt.Rows[4][x];
                            if (sizeNoCell != null)
                            {
                                string sizeNo = sizeNoCell.ToString();
                                if (string.IsNullOrEmpty(sizeNo) == false)
                                {
                                    if (cartonNumberingList.Where(c => c.ProductNo.ToLower() == productNo.ToLower() && c.SizeNo.ToLower() == sizeNo.ToLower()).Count() > 0)
                                    {
                                        sizeNo = string.Format("{0}'", sizeNo);
                                    }
                                    var qtyCell = dt.Rows[6][x];
                                    int qty = 0;
                                    int.TryParse(qtyCell.ToString(), out qty);

                                    CartonNumberingModel cartonNumbering = new CartonNumberingModel
                                    {
                                        ProductNo = productNo,
                                        SizeNo = sizeNo,
                                        Quantity = qty,
                                    };
                                    if (string.IsNullOrEmpty(cartonNumbering.ProductNo) == false
                                        && string.IsNullOrEmpty(cartonNumbering.SizeNo) == false
                                        && cartonNumbering.Quantity > 0)
                                    {
                                        cartonNumberingList.Add(cartonNumbering);
                                    }

                                    for (int y = i; y <= i + qty - 1; y++)
                                    {
                                        int cartonNo = y;
                                        CartonNumberingDetailModel cartonNumberingDetail = new CartonNumberingDetailModel
                                        {
                                            ProductNo = productNo,
                                            SizeNo = sizeNo,
                                            CartonNo = cartonNo,
                                        };
                                        if (string.IsNullOrEmpty(cartonNumberingDetail.ProductNo) == false
                                            && string.IsNullOrEmpty(cartonNumberingDetail.SizeNo) == false
                                            && cartonNumberingDetail.CartonNo > 0)
                                        {
                                            cartonNumberingDetailList.Add(cartonNumberingDetail);
                                        }
                                    }
                                    i = qty + i;
                                }
                            }
                        }
                    }
                }
                ViewState["cartonNumberingList"] = cartonNumberingList;
                ViewState["cartonNumberingDetailList"] = cartonNumberingDetailList;
                btnImport.Enabled = true;
            }
            catch
            {                
                cartonNumberingList.Clear();
                cartonNumberingDetailList.Clear();
            }
            finally
            {
                excelConnection.Close();
            }
            lblStatus.Text = string.Format("Read-ed! Packing List Contain <b>{0}</b> Size & <b>{1}</b> Carton.", cartonNumberingList.Count(), cartonNumberingDetailList.Count());
        }

        protected void btnImport_Click(object sender, EventArgs e)
        {
            List<CartonNumberingModel> cartonNumberingList = ViewState["cartonNumberingList"] as List<CartonNumberingModel>;
            List<CartonNumberingDetailModel> cartonNumberingDetailList = ViewState["cartonNumberingDetailList"] as List<CartonNumberingDetailModel>;
            if (cartonNumberingList.Count() <= 0 || cartonNumberingDetailList.Count() <= 0)
            {
                btnImport.Enabled = false;
                return;
            }
            lblStatus.Text = "Importing...";
            List<String> productNoList = cartonNumberingList.Select(c => c.ProductNo).Distinct().ToList();
            bool isClear = rbtnClear.Checked;
            if (isClear == true)
            {
                foreach (string productNo in productNoList)
                {
                    CartonNumberingController.Delete(productNo);
                    CartonNumberingDetailController.Delete(productNo);
                }
            }
            foreach (CartonNumberingModel model in cartonNumberingList)
            {
                CartonNumberingController.Create(model);
            }
            foreach (CartonNumberingDetailModel model in cartonNumberingDetailList)
            {
                CartonNumberingDetailController.Create(model);
            }
            btnImport.Enabled = false;
            lblStatus.Text = "Import-ed!";
        }
    }
}