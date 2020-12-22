using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using WebsiteTesting.Controllers.SewingMachineController;
using WebsiteTesting.Models.SewingMachine;
using Newtonsoft.Json;

namespace WebsiteTesting.Pages.SewingMachines
{
    public partial class Allocation : System.Web.UI.Page
    {
        DateTime dtDefault = new DateTime(1999, 12, 31);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
                return;

            var par = Request.Params["rlp"];
            if (!String.IsNullOrEmpty(par))
            {
                try {
                    var fd = par.Split('-')[0].ToString();
                    var td = par.Split('-')[1].ToString();
                    double fdDouble = 0, tdDouble = 0;
                    Double.TryParse(fd, out fdDouble);
                    Double.TryParse(td, out tdDouble);
                    var fromDate = DateTime.FromOADate(fdDouble);
                    var toDate = DateTime.FromOADate(tdDouble);

                    txtStart.Text   = String.Format("{0:MM/dd/yyyy}", fromDate);
                    txtFinish.Text  = String.Format("{0:MM/dd/yyyy}", toDate);

                    Reload();
                    Session["Searched"] = false;
                }
                catch 
                {
                    return;
                }
            }

            var currentUserName = Page.User.Identity.Name.ToString();
            Session["currentUserName"] = currentUserName;
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            Reload();
        }

        private void Reload()
        {
            divMachineAvailable.Controls.Clear();
            string fromDateString = txtStart.Text.Trim().ToString();
            string toDateString = txtFinish.Text.Trim().ToString();
            var fromDate = ConvertDate(fromDateString);
            var toDate = ConvertDate(toDateString);

            var scheduleInTimeList = new List<ScheduleModel>();
            var scheduleDetaiInTimeList = new List<ScheduleDetailModel>();

            if (fromDate == dtDefault || toDate == dtDefault)
            {
                ShowAlert("Start Date or Finish Date incorrect format MM/dd/yyyy !");
                return;
            }

            if (fromDate > toDate)
            {
                ShowAlert("Start Date canot be greater than Finish Date !");
                return;
            }

            var allMachineList = CommonController.GetMachines();
            ViewState["allMachineList"] = allMachineList;
            Session["allMachineList"]   = allMachineList;

            scheduleInTimeList = CommonController.GetScheduleFromTo(fromDate, toDate);
            Session["scheduleInTimeList"] = scheduleInTimeList;

            Session["FromTo"] = String.Format("{0}-{1}", fromDate.ToOADate(), toDate.ToOADate());

            var machineTypeList = allMachineList.Select(s => s.MachineType).Distinct().ToList();
            foreach (var machineType in machineTypeList)
            {
                var machineListByMachineType = allMachineList.Where(w => w.MachineType.Equals(machineType)).ToList();

                HtmlGenericControl divMachineTypeTitle = new HtmlGenericControl("div");
                divMachineTypeTitle.Attributes["class"] = "col-12 m-1 mb-0 font-weight-bold";
                divMachineTypeTitle.InnerText = String.Format("List of MachineType: {0}", machineType);
                divMachineAvailable.Controls.Add(divMachineTypeTitle);

                HtmlGenericControl divMachineType = new HtmlGenericControl("div");
                divMachineType.Attributes["class"] = "col-12 text-center text-sm-left mb-3";

                foreach (var machine in machineListByMachineType)
                {
                    var btnMachine = new Button();
                    btnMachine.Text = machine.Name;
                    btnMachine.ID = string.Format("{0}", machine.MachineId);
                    btnMachine.CssClass = "btn btn-success rounded-0 m-1";

                    var scheduleByMachineId = scheduleInTimeList.FirstOrDefault(f => f.MachineId == machine.MachineId);
                    if (scheduleByMachineId != null)
                    {
                        btnMachine.CssClass = "btn btn-danger rounded-0 m-1";
                        btnMachine.OnClientClick = "ButtonNotAvailableNowClick('" + btnMachine.ClientID + "');return false;";
                    }
                    else
                    {
                        btnMachine.Attributes["runat"] = "server";
                        btnMachine.OnClientClick = "ButtonClick('" + btnMachine.ClientID + "');return false;";
                    }

                    btnMachine.Attributes["id"] = machine.MachineId.ToString();
                    divMachineType.Controls.Add(btnMachine);
                    divMachineAvailable.Controls.Add(divMachineType);
                }
            }
        }

        [WebMethod]
        public static string ViewDetailScheduleById(string buttonId)
        {
            var scheduleInTimeList  = HttpContext.Current.Session["scheduleInTimeList"] as List<WebsiteTesting.Models.SewingMachine.ScheduleModel>;
            var fromTo              = HttpContext.Current.Session["FromTo"] as String;

            if (scheduleInTimeList == null || fromTo == null)
                return "Session timeout, Please login again !";
            else
            {
                var scheduleByMachineId = scheduleInTimeList.FirstOrDefault(f => f.MachineId.ToString().Equals(buttonId));
                var result = String.Format("{0}[{1}", scheduleByMachineId.ScheduleId, fromTo);
                return result;
            }
        }

        [WebMethod]
        public static string CreateSchedule(string buttonId, string style, string pm, string lineName, string fromDateString, string toDateString)
        {
            // Validation
            DateTime dtDefault = new DateTime(1999, 12, 31);
            if (String.IsNullOrEmpty(style))
                return "Style is empty !";
            if (String.IsNullOrEmpty(pm))
                return "PatternNo is empty !";
            if (String.IsNullOrEmpty(lineName))
                return "LineName is empty !";

            var fromDate = ConvertDateStatic(fromDateString);
            var toDate  = ConvertDateStatic(toDateString);
            if (fromDate == dtDefault || toDate == dtDefault)
                return "Start Date or Finish Date incorrect format !"; 
            if (fromDate > toDate)
                return "Start Date canot be greater than Finish Date !";

            // Get Session Data
            var scheduleCurrentList         = new List<WebsiteTesting.Models.SewingMachine.ScheduleModel>();
            var scheduleInTimeList          = HttpContext.Current.Session["scheduleInTimeList"] as List<WebsiteTesting.Models.SewingMachine.ScheduleModel>;
            var allMachineList              = HttpContext.Current.Session["allMachineList"]     as List<WebsiteTesting.Models.SewingMachine.MachineModel>;
            var currentUserName             = HttpContext.Current.Session["currentUserName"]    as String;

            if (currentUserName == null)
                return "Session timeout, Please login again !";
            if (allMachineList == null || allMachineList.Count() == 0)
                return "Canot get machineList !";
            var machineClicked = allMachineList.FirstOrDefault(f => f.MachineId.ToString().Equals(buttonId));

            var scheduleCreate = new WebsiteTesting.Models.SewingMachine.ScheduleModel {
                MachineId   = machineClicked.MachineId,
                FromDate    = fromDate,
                ToDate      = toDate,
                Style       = style,
                PatternNo   = pm,
                LineName    = lineName,
                CreatedBy   = currentUserName,
                UpdatedBy   = currentUserName,
                Matching    = DateTime.Now.ToOADate(),
            };

            // Validate inserted before.
            var scheduleCheck = scheduleInTimeList.FirstOrDefault(f => f.MachineId == scheduleCreate.MachineId && f.FromDate == scheduleCreate.FromDate && f.ToDate == scheduleCreate.ToDate);
            if (scheduleCheck != null)
            {
                var machine = allMachineList.FirstOrDefault(f => f.MachineId == scheduleCheck.MachineId);
                return string.Format("Machine: {0} has scheduled at Line: {1}\nSchedule: from {2:MM/dd} to {3:MM/dd}\nCreated By: {4}",
                    machine.Name,
                    scheduleCheck.LineName,
                    scheduleCheck.FromDate,
                    scheduleCheck.ToDate,
                    scheduleCheck.CreatedBy);
            }

            try
            {
                // Insert Schedule
                CommonController.CreateSchedule(model: scheduleCreate, insertOrUpdateMode: 0);

                // Insert Schedule Detail
                double totalDays = (scheduleCreate.ToDate - scheduleCreate.FromDate).TotalDays + 1.0;
                for (var date = scheduleCreate.FromDate; date <= scheduleCreate.ToDate; date = date.AddDays(1))
                {
                    CommonController.CreateScheduleDetail(new ScheduleDetailModel
                    {
                        MachineId       = scheduleCreate.MachineId,
                        ScheduleDate    = date,
                        Remarks         = totalDays > 1 ? String.Format("{0}days", totalDays) : String.Format("{0}day", totalDays),
                        Matching        = scheduleCreate.Matching,
                    });
                }
                scheduleInTimeList.Add(scheduleCreate);
                return String.Format("Successful");
            }
            catch (Exception ex)
            {
                return ex.Message.ToString();
            }
        }
        
        private DateTime ConvertDate(string dateString)
        {
            DateTime result = new DateTime(1999, 12, 31);
            try
            {
                if (!String.IsNullOrEmpty(dateString) &&
                    dateString.Contains("/") &&
                    dateString.Split('/').Count() == 3)
                {
                    var dateSearchStringSplit = dateString.Split('/');
                    int year = 0, month = 0, day = 0;
                    //11/16/1992
                    Int32.TryParse(dateSearchStringSplit[0], out month);
                    Int32.TryParse(dateSearchStringSplit[1], out day);
                    Int32.TryParse(dateSearchStringSplit[2], out year);

                    result = new DateTime(year, month, day);
                }
            }
            catch { return result; }
            return result;
        }

        private static DateTime ConvertDateStatic (string dateString)
        {
            DateTime result = new DateTime(1999, 12, 31);
            try
            {
                if (!String.IsNullOrEmpty(dateString) &&
                    dateString.Contains("/") &&
                    dateString.Split('/').Count() == 3)
                {
                    var dateSearchStringSplit = dateString.Split('/');
                    int year = 0, month = 0, day = 0;
                    //11/16/1992
                    Int32.TryParse(dateSearchStringSplit[0], out month);
                    Int32.TryParse(dateSearchStringSplit[1], out day);
                    Int32.TryParse(dateSearchStringSplit[2], out year);

                    result = new DateTime(year, month, day);
                }
            }
            catch { return result; }
            return result;
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