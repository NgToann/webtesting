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
    public partial class ReturnReplaceScissorsPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string LoadReleaseScissors()
        {
            try
            {
                var releaseScissorsList = ScissorsMainController.GetReleaseScissors();
                var userLogin = HttpContext.Current.User.Identity.Name.ToString();
                var resource = new object[] { releaseScissorsList, userLogin };
                return JsonConvert.SerializeObject(resource);
            }
            catch (Exception ex)
            {
                return String.Format("Exception: {0}", ex.InnerException.InnerException.Message.ToString());
            }
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string ReturnScissors(string releaseId)
        {
            try
            {
                if (ScissorsMainController.ReturnScissors_1(int.Parse(releaseId)))
                    return "Successful !";
                else
                    return "Please Reload Page and Try Again !";
            }
            catch (Exception ex)
            {
                return String.Format("Exception: {0}", ex.InnerException.InnerException.Message.ToString());
            }

        }

        [WebMethod]
        public static string ReplaceScissors(ReleaseScissorsModel replaceModel)
        {
            var x = replaceModel.ReleaseId;

            var releaseNew      = replaceModel;
            releaseNew.Barcode  = replaceModel.BarcodeReplace;

            try {
                if (ScissorsMainController.ReplaceScissors_1(replaceModel)
                    && ScissorsMainController.InsertReleaseScissors(releaseNew))
                {
                    return "Successful";
                }
                else
                {
                    return "Reload page and try again !";
                }
            }
            catch (Exception ex)
            {
                return String.Format("Exception: {0}", ex.InnerException.InnerException.Message.ToString());
            }
        }
    }
}