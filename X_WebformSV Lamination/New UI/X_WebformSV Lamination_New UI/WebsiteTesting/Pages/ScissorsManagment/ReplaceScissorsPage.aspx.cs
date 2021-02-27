using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebsiteTesting.Controllers.ScissorsController;
using WebsiteTesting.Models.ScissorsManagmentSystem;

namespace WebsiteTesting.Pages.ScissorsManagment
{
    public partial class ReplaceScissorsPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var scissorsNeedReplace = Session["ScissorsNeedReplace"] as IssuanceModel;
            var issuanceList = ScissorsMainController.GetIssuance();
            ViewState["issuanceList"] = issuanceList;
            ViewState["ScissorsNeedReplace"] = scissorsNeedReplace;

            if (scissorsNeedReplace == null)
            {
                ShowAlert("Scissors empty !");
                return;
            }
            if (scissorsNeedReplace.IsBig == true)
                lblTitle.Text = scissorsNeedReplace.WorkerId + " - " + scissorsNeedReplace.ScissorsBarcode + " REPLACE BIG SCISSORS";
            else
                lblTitle.Text = scissorsNeedReplace.WorkerId + " - " + scissorsNeedReplace.ScissorsBarcode + " REPLACE SMALL SCISSORS";
        }


        protected void btnSave_Click(object sender, EventArgs e)
        {
            var issuanceList        = ViewState["issuanceList"] as List<IssuanceModel>; 
            var scissorsNeedReplace = ViewState["ScissorsNeedReplace"] as IssuanceModel;

            if (scissorsNeedReplace == null)
            {
                ShowAlert("Scissors empty !");
                return;
            }

            var reasonClicked = radReasonBroken.Checked == true ? radReasonBroken.Text : radReasonLoss.Text;
            string barcodeScissorsReplace = txtScissorsReplaceBarcode.Text;
            if (String.IsNullOrEmpty(barcodeScissorsReplace))
            {
                ShowAlert("Barcode Empty !");
                return;
            }

            var checkReplaceBarcode = issuanceList.FirstOrDefault(f => f.ScissorsBarcode == barcodeScissorsReplace && f.IsReturn == false);
            if (checkReplaceBarcode != null)
            {
                ShowAlert(String.Format("The scissors asigned to {0} !", checkReplaceBarcode.WorkerId));
                return;
            }
            string confirmValue = Request.Form["confirm_value"];
            if (confirmValue != null && confirmValue.Equals("Yes"))
            {
                var replaceModel = new IssuanceModel() { 
                    IssuanceId              = scissorsNeedReplace.IssuanceId,
                    ScissorsBarcode         = barcodeScissorsReplace,
                    ScissorsBarcodeReplace  = scissorsNeedReplace.ScissorsBarcode,
                    Reason                  = reasonClicked
                };

                try
                {
                    ScissorsMainController.ReplaceScissors(replaceModel);
                    issuanceList.RemoveAll(r => r.IssuanceId == replaceModel.IssuanceId);
                    issuanceList.Add(replaceModel);

                    ShowAlert("Scissors replaced !");
                }
                catch (Exception ex)
                {
                    ShowAlert(ex.Message);
                }
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