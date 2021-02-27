using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

using WebsiteTesting.Controllers.ScissorsController;
using WebsiteTesting.Entities;
using WebsiteTesting.Models.ScissorsManagmentSystem;

namespace WebsiteTesting.Pages.ScissorsManagment
{
    public partial class InspectionPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var toDay               = DateTime.Now;
            lblTitle.Text = String.Format("INSPECTION {0:MM/dd/yyyy}", toDay);
        }

        
        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        //public static string ScanScissors(InspectionModel uploadModel)
        public static string ScanScissors(string workerId, string workerName, string barcode, string inspector)
        {
            var uploadModel = new InspectionModel
            {
                WorkerId    = workerId,
                WorkerName  = workerName,
                Barcode     = barcode,
                InspectionDate = DateTime.Now,
                Inspector   = inspector
            };
            uploadModel.InspectionDate = DateTime.Now;
            try {
                if (ScissorsMainController.InsertInspection(uploadModel))
                    return "Successful !";
                else
                    return "Reload page and try again !";
            }
            catch (Exception ex)
            {
                return String.Format("Exception: {0}", ex.InnerException.InnerException.Message.ToString());
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

        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string LoadInspectionToDay()
        {
            try
            {
                var toDay = DateTime.Now;
                var inspectionListToDay = ScissorsMainController.GetInspectionByDate(toDay);
                var issuanceList    = ScissorsMainController.GetIssuance().Where(w => w.IsReturn == false && w.IsReplace == false).ToList();
                var releaseScissors = ScissorsMainController.GetReleaseScissors().Where(w => w.Status == "Borrowed").ToList();
                var userLogin = HttpContext.Current.User.Identity.Name.ToString();
                var resource = new object[] { inspectionListToDay, issuanceList, releaseScissors, userLogin };
                
                return JsonConvert.SerializeObject(resource);
            }
            catch (Exception ex)
            {
                return String.Format("Exception: {0}", ex.InnerException.InnerException.Message.ToString());
            }
        }
    }
}