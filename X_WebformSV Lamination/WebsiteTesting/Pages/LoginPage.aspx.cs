using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

using WebsiteTesting.Models.ScissorsManagmentSystem;
using WebsiteTesting.Models.SewingMachine;
using WebsiteTesting.Models.WHLamination;
using WebsiteTesting.Controllers.ScissorsController;
using WebsiteTesting.Controllers.SewingMachineController;
using WebsiteTesting.Controllers.WHLamination;

namespace WebsiteTesting.Pages
{
    public partial class LoginPage : System.Web.UI.Page
    {
        private List<UserModel> userList;
        private List<UserSMModel> userSMList;
        private List<UserWebModel> userWHLaminationList;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string factory = ScissorsMainController.GetFactory();
                lblFactory.Text = String.IsNullOrEmpty(factory) == false ? factory : "Sao Viet";
                userList = ScissorsMainController.GetUserList();
                userSMList = CommonController.GetUserSM();
                userWHLaminationList = UserWebController.GetWHLaminationUser();
            }
            catch (Exception ex)
            {
                ShowAlert(ex.Message.ToString());
            }
        }

        protected void loginMain_Authenticate(object sender, AuthenticateEventArgs e)
        {
            bool authenticated = false;
            authenticated = Login(loginMain.UserName, loginMain.Password);
            if (authenticated == true)
            {
                FormsAuthentication.RedirectFromLoginPage(loginMain.UserName, loginMain.RememberMeSet);
            }
        }

        private bool Login(string userName, string password)
        {
            // Insert code that implements a site-specific custom
            // authentication method here.
            // This example implementation always returns false.
            var userScissorsLogin   = userList.FirstOrDefault(f => f.UserId == userName && f.Password == password);
            var userSMLogin         = userSMList.FirstOrDefault(f => f.UserName.Equals(userName) && f.Password.Equals(password));
            var userWHLamination    = userWHLaminationList.FirstOrDefault(f => f.UserName.Equals(userName) && f.Password.Equals(password));

            if ((userName == "admin" && password == "admin") || (userName == "sampleroom" && password == "sampleroom")
                || userScissorsLogin != null 
                || userSMLogin != null
                || userWHLamination != null)
            {
                if (userScissorsLogin != null)
                    Session["User"] = userScissorsLogin;
                if (userSMLogin != null)
                    Session["User"] = userSMLogin;
                if (userWHLamination != null)
                    Session["User"] = userWHLamination;

                return true;
            }
            return false;
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