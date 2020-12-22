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
    public partial class ReturnReplacePage : System.Web.UI.Page
    {
        protected void btnWorkerIdOK_Click(object sender, EventArgs e)
        {
            // Clear value on page
            txtWorkerName.Text = "";
            txtSection.Text = "";
            txtLine.Text = "";

            string workerIdInputted = txtWorkerID.Text.Trim().ToUpper().ToString();
            var issuanceByWorker = ScissorsMainController.GetIssuanceByWorkerId(workerIdInputted);
            if (issuanceByWorker.Count() == 0)
            {
                ShowAlert("Worker not found !");
                ViewState["IssuanceByWorker"] = new List<IssuanceModel>();
                return;
            }
            else
            {
                ViewState["IssuanceByWorker"] = issuanceByWorker;
                txtWorkerName.Text = issuanceByWorker.FirstOrDefault().WorkerName;
                txtSection.Text = issuanceByWorker.FirstOrDefault().Section;
                txtLine.Text = issuanceByWorker.FirstOrDefault().Line;
            }
        }

        protected void btnReturnBigScissors_Click(object sender, EventArgs e)
        {
            var issuanceByWorker = ViewState["IssuanceByWorker"] as List<IssuanceModel>;
            string confirmValue = Request.Form["confirm_value"];

            if (issuanceByWorker != null && confirmValue != null && confirmValue.Equals("Yes"))
            {
                var bigScissorsReturn = issuanceByWorker.FirstOrDefault(f => f.IsBig == true && f.IsReturn == false);
                if (bigScissorsReturn != null)
                {
                    try
                    {
                        ScissorsMainController.ReturnScissors(bigScissorsReturn);
                        ShowAlert("The Big Scissors Returned !");

                        bigScissorsReturn.IsReturn = true;
                        issuanceByWorker.RemoveAll(r => r.IssuanceId == bigScissorsReturn.IssuanceId);
                        issuanceByWorker.Add(bigScissorsReturn);
                        ViewState["IssuanceByWorker"] = issuanceByWorker;
                    }
                    catch (Exception ex)
                    {
                        ShowAlert(ex.Message);
                    }
                }
                else
                    ShowAlert("The Big Scissors not assigned to this worker");
            }
            else
            {
                return;
            }
        }
        protected void btnReturnSmallScissors_Click(object sender, EventArgs e)
        {
            var issuanceByWorker = ViewState["IssuanceByWorker"] as List<IssuanceModel>;
            string confirmValue = Request.Form["confirm_value"];

            if (issuanceByWorker != null && confirmValue.Equals("Yes"))
            {
                var smallScissorsReturn = issuanceByWorker.FirstOrDefault(f => f.IsBig == false && f.IsReturn == false);
                if (smallScissorsReturn != null)
                {
                    try
                    {
                        ScissorsMainController.ReturnScissors(smallScissorsReturn);
                        ShowAlert("The Small Scissors Returned !");

                        smallScissorsReturn.IsReturn = true;
                        issuanceByWorker.RemoveAll(r => r.IssuanceId == smallScissorsReturn.IssuanceId);
                        issuanceByWorker.Add(smallScissorsReturn);

                        ViewState["IssuanceByWorker"] = issuanceByWorker;
                    }
                    catch (Exception ex)
                    {
                        ShowAlert(ex.Message);
                    }
                }
                else
                {
                    ShowAlert("The Small Scissors not assigned to this worker");
                }
            }
            else
            {
                return;
            }
        }
        protected void btnReplaceBigScissors_Click(object sender, EventArgs e)
        {
            var issuanceByWorker = ViewState["IssuanceByWorker"] as List<IssuanceModel>;
            if (issuanceByWorker == null)
                return;
            var bigScissorsNeedReplace = issuanceByWorker.FirstOrDefault(f => f.IsBig == true && f.IsReturn == false);
            if (bigScissorsNeedReplace == null)
            {
                ShowAlert("The Big Scissors not assigned to this worker");
                return;
            }
            else
            {
                Session["ScissorsNeedReplace"] = bigScissorsNeedReplace;
                Response.Redirect("ReplaceScissorsPage.aspx");
            }
        }
        protected void btnReplaceSmallScissors_Click(object sender, EventArgs e)
        {
            var issuanceByWorker = ViewState["IssuanceByWorker"] as List<IssuanceModel>;
            if (issuanceByWorker == null)
                return;

            var smallScissorsNeedReplace = issuanceByWorker.FirstOrDefault(f => f.IsBig == false && f.IsReturn == false);
            if (smallScissorsNeedReplace == null)
            {
                ShowAlert("The Small Scissors not assigned to this worker");
                return;
            }
            else
            {
                Session["ScissorsNeedReplace"] = smallScissorsNeedReplace;
                Response.Redirect("ReplaceScissorsPage.aspx");
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