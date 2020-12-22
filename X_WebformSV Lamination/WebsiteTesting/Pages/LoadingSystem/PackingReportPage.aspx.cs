using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ComponentModel;
using WebsiteTesting.Models.LoadingSystem;
using WebsiteTesting.Controllers.LoadingSystem;
using WebsiteTesting.DataSets.LoadingSystem;
using System.Data;
using Microsoft.Reporting.WebForms;

namespace WebsiteTesting.Pages.LoadingSystem
{
    public partial class PackingReportPage : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnPreview_Click(object sender, EventArgs e)
        {
            string productNo = txtProductNo.Text;
            if (string.IsNullOrEmpty(productNo) == true)
            {
                return;
            }
            btnPreview.Enabled = false;
            List<CartonNumberingModel> cartonNumberingList = CartonNumberingController.Get(productNo);
            List<CartonNumberingDetailModel> cartonNumberingDetailList = CartonNumberingDetailController.Get(productNo);
            List<PackingModel> packingList = PackingController.Get(productNo);
            DataTable dtCartonNumbering = new CartonNumberingDataSet().Tables[0];
            DataTable dtPacking = new PackingDataSet().Tables[0];
            foreach (CartonNumberingModel cartonNumbering in cartonNumberingList)
            {
                DataRow drCartonNumbering = dtCartonNumbering.NewRow();
                drCartonNumbering["ProductNo"] = cartonNumbering.ProductNo;
                drCartonNumbering["SizeNo"] = cartonNumbering.SizeNo;
                drCartonNumbering["Quantity"] = cartonNumbering.Quantity;
                drCartonNumbering["GrossWeight"] = Math.Round(cartonNumbering.GrossWeight, 2);
                dtCartonNumbering.Rows.Add(drCartonNumbering);

                List<CartonNumberingDetailModel> cartonNumberingDetail_D1 = cartonNumberingDetailList.Where(c => c.SizeNo == cartonNumbering.SizeNo).ToList();
                for (int i = 1; i <= cartonNumberingDetail_D1.Count(); i++)
                {
                    CartonNumberingDetailModel cartonNumberingDetail = cartonNumberingDetail_D1[i - 1];
                    PackingModel packing = packingList.Where(p => p.CartonNo == cartonNumberingDetail.CartonNo).FirstOrDefault();

                    DataRow drPacking = dtPacking.NewRow();
                    drPacking["ProductNo"] = cartonNumbering.ProductNo;
                    drPacking["SizeNo"] = cartonNumbering.SizeNo;
                    drPacking["NumberOf"] = i;
                    drPacking["PackingValue"] = string.Format("{0} |", cartonNumberingDetail.CartonNo);
                    drPacking["IsFirstPass"] = true;
                    if (packing != null)
                    {
                        drPacking["PackingValue"] = string.Format("{0} | {1}\n{2:HH:mm:ss}", cartonNumberingDetail.CartonNo, Math.Round(packing.ActualWeight, 1), packing.CreatedTime);
                        drPacking["IsFirstPass"] = packing.IsFirstPass;
                    }
                    drPacking["IsCartonNoBasic"] = false;
                    if (cartonNumberingDetail.CartonNo == cartonNumbering.CartonNoBasic)
                    {
                        drPacking["IsCartonNoBasic"] = true;
                    }
                    dtPacking.Rows.Add(drPacking);
                }
            }
            string packingDate = "";
            if (packingList.Count > 0)
            {
                packingDate = string.Format("{0:dd/MM/yyyy}", packingList.FirstOrDefault().CreatedTime);
            }
            double totalWeight = packingList.Sum(p => p.ActualWeight);
            btnPreview.Enabled = true;

            reportViewer.LocalReport.ReportPath = @"Reports\LoadingSystem\PackingReport.rdlc";
            ReportParameter rpProductNo = new ReportParameter("ProductNo", productNo);
            ReportParameter rpPackingDate = new ReportParameter("PackingDate", packingDate);
            ReportParameter rpTotalWeight = new ReportParameter("TotalWeight", totalWeight.ToString());
            ReportDataSource rds = new ReportDataSource();
            rds.Name = "CartonNumbering";
            rds.Value = dtCartonNumbering;
            ReportDataSource rds1 = new ReportDataSource();
            rds1.Name = "Packing";
            rds1.Value = dtPacking;
            reportViewer.LocalReport.SetParameters(new ReportParameter[] { rpProductNo, rpPackingDate, rpTotalWeight });
            reportViewer.LocalReport.DataSources.Clear();
            reportViewer.LocalReport.DataSources.Add(rds);
            reportViewer.LocalReport.DataSources.Add(rds1);          
        }       
    }
}