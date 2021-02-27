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
    public partial class UpdateSchedule : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var par = Request.Params["par"];
            if (String.IsNullOrEmpty(par))
                return;

            if (IsPostBack)
                return;

            try
            {
                string shdIdString      = par.Split('[')[0].ToString();
                Session["FromTo"]       = par.Split('[')[1].ToString();
                Session["BackReport"]   = par.Contains("BckRp") == true ? "BckRp" : "";
                int scheduleId = 0;
                Int32.TryParse(shdIdString, out scheduleId);
                var scheduleById = CommonController.GetScheduleById(scheduleId);
                if (scheduleById != null)
                {
                    txtMachineName.Text = String.Format("{0}-{1}", scheduleById.MachineType, scheduleById.MachineName);
                    txtStyleName.Text = scheduleById.Style;
                    txtLine.Text = scheduleById.LineName;
                    txtPM.Text = scheduleById.PatternNo;
                    txtStart.Text = String.Format("{0:MM/dd/yyyy}", scheduleById.FromDate);
                    txtFinish.Text = String.Format("{0:MM/dd/yyyy}", scheduleById.ToDate);
                    ViewState["ScheduleById"] = scheduleById;
                    Session["ScheduleById"] = scheduleById;
                    var currentUserName = Page.User.Identity.Name.ToString();
                    Session["currentUserName"] = currentUserName;
                }
                
            }
            catch (Exception ex)
            {
                ShowAlert(ex.Message);
            }

            
        }
        
        [WebMethod]
        public static string UpdateScheduleMethod(string style, string pm, string lineName, string fromDateString, string toDateString)
        {
            var scheduleModelById   = HttpContext.Current.Session["ScheduleById"] as WebsiteTesting.Models.SewingMachine.ScheduleModel;
            var currentUserName     = HttpContext.Current.Session["currentUserName"] as String;
            var fromTo              = HttpContext.Current.Session["FromTo"] as String;
            var backReport          = HttpContext.Current.Session["BackReport"] as String;
            if (scheduleModelById == null || currentUserName == null || fromTo == null)
                return "Session timeout, Please login again !";

            // Validation
            DateTime dtDefault = new DateTime(1999, 12, 31);
            if (String.IsNullOrEmpty(style))
                return "Style is empty !";
            if (String.IsNullOrEmpty(pm))
                return "PatternNo is empty !";
            if (String.IsNullOrEmpty(lineName))
                return "LineName is empty !";

            var fromDate = ConvertDateStatic(fromDateString);
            var toDate = ConvertDateStatic(toDateString);
            if (fromDate == dtDefault || toDate == dtDefault)
                return "Start Date or Finish Date incorrect format !";
            if (fromDate > toDate)
                return "Start Date canot be greater than Finish Date !";

            var updateScheduleModel = new WebsiteTesting.Models.SewingMachine.ScheduleModel
            {
                ScheduleId  = scheduleModelById.ScheduleId,
                FromDate    = fromDate,
                ToDate      = toDate,
                Style       = style,
                PatternNo   = pm,
                LineName    = lineName,
                UpdatedBy   = currentUserName,
                Matching    = DateTime.Now.ToOADate(),
            };

            try
            {
                var scheduleListInTime = CommonController.GetScheduleFromTo(fromDate, toDate);
                var validateSchedule = scheduleListInTime.FirstOrDefault(f => updateScheduleModel.FromDate <= f.ScheduleDate &&
                                                                            f.ScheduleDate <= updateScheduleModel.ToDate &&
                                                                            f.MachineId == scheduleModelById.MachineId &&
                                                                            f.ScheduleId != scheduleModelById.ScheduleId);
                if (validateSchedule != null)
                    return String.Format("Machine: {0}-{1} has scheduled at Line: {2}\nFrom: {3:MM/dd} to {4:MM/dd}",
                        validateSchedule.MachineType, 
                        validateSchedule.MachineName, 
                        validateSchedule.LineName, 
                        validateSchedule.FromDate, 
                        validateSchedule.ToDate);

                CommonController.DeleteScheduleDetailByScheduleId(updateScheduleModel.ScheduleId);                
                // Update Schedule
                CommonController.CreateSchedule(model: updateScheduleModel, insertOrUpdateMode: -999);
                // Create Schedule detail
                double totalDays = (updateScheduleModel.ToDate - updateScheduleModel.FromDate).TotalDays + 1.0;
                for (var date = updateScheduleModel.FromDate; date <= updateScheduleModel.ToDate; date = date.AddDays(1))
                {
                    CommonController.CreateScheduleDetail(new ScheduleDetailModel
                    {
                        MachineId     = scheduleModelById.MachineId,
                        ScheduleDate  = date,
                        Remarks       = totalDays > 1 ? String.Format("{0}days", totalDays) : String.Format("{0}day", totalDays),
                        Matching      = updateScheduleModel.Matching,
                    });
                }

                return String.Format("Sucessful[{0}[{1}[{2}", scheduleModelById.MachineId, fromTo, backReport);
            }
            catch (Exception ex)
            {
                return ex.Message.ToString();
            }
        }

        [WebMethod]
        public static string DeleteSchedule()
        {
            var scheduleModelById   = HttpContext.Current.Session["ScheduleById"] as WebsiteTesting.Models.SewingMachine.ScheduleModel;
            var fromTo              = HttpContext.Current.Session["FromTo"] as String;
            var backReport          = HttpContext.Current.Session["BackReport"] as String;
            if (scheduleModelById == null || fromTo == null)
                return "Session timeout, Please login again !";

            try {
                CommonController.DeleteScheduleDetailByScheduleId(scheduleModelById.ScheduleId);
                CommonController.DeleteScheduleById(scheduleModelById.ScheduleId);

                return String.Format("Sucessful[{0}[{1}[{2}", scheduleModelById.MachineId, fromTo, backReport);
            }
            catch (Exception ex) {
                return ex.Message.ToString();
            }

            return "";
        }
        

        [WebMethod]
        public static string GetSchedule(TCheck obj)
        {
            var style = obj.Style;
            var pm = obj.PM;
            var lineName = obj.LineName;

            var p = new TCheck
            {
                Style = style + "JSON",
                PM = pm + "JSON",
                LineName = lineName + "JSON",
            };
            return JsonConvert.SerializeObject(p);
        }

        private static DateTime ConvertDateStatic(string dateString)
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

        public class TCheck
        {
            public string Style { get; set; }
            public string PM { get; set; }
            public string LineName { get; set; }
        }
    }
}