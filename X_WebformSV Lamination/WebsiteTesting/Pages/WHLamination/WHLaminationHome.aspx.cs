using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

using WebsiteTesting.Models.WHLamination;
using WebsiteTesting.Controllers.WHLamination;
using Newtonsoft.Json;

namespace WebsiteTesting.Pages.WHLamination
{
    public partial class WHLaminationHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string CallTest(string orderNo)
        {
            var x = orderNo;
            return x;
        }

        //
        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string GetByOrderNo(string orderNo)
        {
            try 
            {
                var laminationMatsSerach = LaminationMaterialController.GetLaminationMaterialByOrderNo(orderNo).ToList();
                return JsonConvert.SerializeObject(laminationMatsSerach);
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
    }
}