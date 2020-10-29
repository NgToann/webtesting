using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using WebsiteTesting.ViewModels.LoadingSystem;
using WebsiteTesting.Models.LoadingSystem;
using WebsiteTesting.Controllers.LoadingSystem;
namespace WebsiteTesting.Pages.LoadingSystem
{
    public partial class CalTotalWeightPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnCal_Click(object sender, EventArgs e)
        {
            List<CalTotalWeightViewModel> calTotalWeightViewList = new List<CalTotalWeightViewModel>();
            string productNoText = txtProductNo.Text;
            if (string.IsNullOrEmpty(productNoText) == true)
            {
                return;
            }
            string[] productNoArray = productNoText.Split(';');
            foreach (string productNo in productNoArray)
            {
                if (string.IsNullOrEmpty(productNo.Trim()) == false)
                {
                    List<CartonNumberingDetailModel> cartonNumberingDetailList = CartonNumberingDetailController.Get(productNo);
                    List<PackingModel> packingList = PackingController.Get(productNo);

                    CalTotalWeightViewModel calTotalWeightView = new CalTotalWeightViewModel {
                        ProductNo = productNo.Trim(),
                        NumberOfCarton = cartonNumberingDetailList.Count(),
                        NumberOfPassed = packingList.Where(p => p.IsPass == true).Count(),
                        TotalWeight = packingList.Sum(p => p.ActualWeight),
                    };

                    calTotalWeightViewList.Add(calTotalWeightView);
                }
            }
            gridViewMain.DataSource = calTotalWeightViewList;
            gridViewMain.DataBind();

            lblTotalWeight.Text = calTotalWeightViewList.Sum(c => c.TotalWeight).ToString();
        }
    }
}