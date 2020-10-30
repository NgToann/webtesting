using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

using WebsiteTesting.Models.ScissorsManagmentSystem;
using WebsiteTesting.Models.SewingMachine;
using WebsiteTesting.Controllers.ScissorsController;
using WebsiteTesting.Controllers.SewingMachineController;
using WebsiteTesting.Entities;

namespace WebsiteTesting
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack == true)
            {
                return;
            }
            if (Page.User.Identity.IsAuthenticated == false)
            {
                FormsAuthentication.RedirectToLoginPage();
            }
            lblWelcome.Text = String.Format("Hi, {0}   ", Page.User.Identity.Name.ToUpper());

            var usernameGet     = Page.User.Identity.Name.ToString();
            var userScissorsList = ScissorsMainController.GetUserList();
            var userSewingMachineList = CommonController.GetUserSM();

            //var userScissors    = Session["User"] as UserModel;
            //var userSM          = Session["User"] as UserSMModel;

            var userScissors = userScissorsList.FirstOrDefault(f => f.UserId == usernameGet);
            var userSM       = userSewingMachineList.FirstOrDefault(f => f.UserName == usernameGet);

            if (usernameGet != null)
            {
                if (usernameGet == "sampleroom")
                {
                    hlCaltotalPage.Enabled              = false;
                    hlChangeCustomerModePage.Enabled    = false;
                    hlImportCartonNumbering.Enabled     = false;
                    hlLineAttendance.Enabled            = false;
                    hlMachineInventory.Enabled          = false;
                    hlPackingReport.Enabled             = false;
                    hlSummaryInfo.Enabled               = false;
                    hlScissorsManagment.Enabled         = false;
                    hlSewingMachines.Enabled            = false;
                    hlSewingMachines.Enabled = false;
                }
                if (userScissors != null)
                {
                    hlCaltotalPage.Enabled              = false;
                    hlChangeCustomerModePage.Enabled    = false;
                    hlImportCartonNumbering.Enabled     = false;
                    hlLineAttendance.Enabled            = false;
                    hlMachineInventory.Enabled          = false;
                    hlPackingReport.Enabled             = false;
                    hlSummaryInfo.Enabled               = false;
                    hlSampleRoom.Enabled                = false;
                    hlSewingMachines.Enabled            = false;
                    hlSewingMachines.Enabled = false;
                }
                if (userSM != null)
                {
                    hlCaltotalPage.Enabled              = false;
                    hlChangeCustomerModePage.Enabled    = false;
                    hlImportCartonNumbering.Enabled     = false;
                    hlLineAttendance.Enabled            = false;
                    hlMachineInventory.Enabled          = false;
                    hlPackingReport.Enabled             = false;
                    hlSummaryInfo.Enabled               = false;
                    hlScissorsManagment.Enabled         = false;
                    hlSampleRoom.Enabled                = false;

                    hlSewingMachines.Enabled = false;
                    hlOutsoleMachines.Enabled = false;
                    if (userSM.IsOutsoleMachine == true)
                        hlOutsoleMachines.Enabled = true;
                    if (userSM.IsSewingMachine == true)
                        hlSewingMachines.Enabled = true;
                }
            }
        }
    }
}