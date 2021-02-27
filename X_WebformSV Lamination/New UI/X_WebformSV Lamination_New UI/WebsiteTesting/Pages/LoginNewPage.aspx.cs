using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebsiteTesting.Pages
{
    public partial class LoginNewPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void loginMain_Authenticate(object sender, AuthenticateEventArgs e)
        {
            //bool authenticated = true;
            //if (authenticated == true)
            //{
            //    FormsAuthentication.RedirectFromLoginPage(loginMain.UserName, loginMain.RememberMeSet);
            //}
        }
    }
}