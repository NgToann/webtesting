using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebsiteTesting.Controllers.SewingMachineController;
using WebsiteTesting.Models.SewingMachine;

namespace WebsiteTesting.Pages.SewingMachines
{
    public partial class SummaryAndInventory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
                return;
            var allMachineList = CommonController.GetMachines();
            ViewState["allMachineList"] = allMachineList;

            var machineTypeList = new List<String>();
            machineTypeList.Add("None");
            machineTypeList.AddRange(allMachineList.Select(s => s.MachineType).Distinct().ToList());
            cboMachineType.DataSource = machineTypeList;
            cboMachineType.DataBind();
        }

        protected void cboMachineType_SelectedIndexChanged(object sender, EventArgs e)
        {
            var machineTypeSelected = cboMachineType.SelectedItem.Value as String;
            if (machineTypeSelected == null)
                return;
            ViewState["machineTypeSelected"] = machineTypeSelected;
            //LoadData();
        }

        protected void btnMachineSummary_Click(object sender, EventArgs e)
        {
            ViewState["ShowWhat"] = "MachineSummay";
            LoadData();
        }

        protected void btnLineSummary_Click(object sender, EventArgs e)
        {
            ViewState["ShowWhat"] = "LineSummary";
            LoadData();
        }

        private void LoadData()
        {
            DateTime dtDefault = new DateTime(1999, 12, 31);

            var allMachineList = ViewState["allMachineList"] as List<MachineModel>;
            var showWhat = ViewState["ShowWhat"] as String; 
            var machineTypeSelected = ViewState["machineTypeSelected"] as String;

            string fromDateString   = txtStart.Text.ToString();
            string toDateString     = txtFinish.Text.ToString();

            if (allMachineList == null || allMachineList.Count() == 0)
            {
                ShowAlert("Can not get machine list !");
                return;
            }

            var fromDate    = ConvertDateStatic(fromDateString);
            var toDate      = ConvertDateStatic(toDateString);
            if (fromDate == dtDefault || toDate == dtDefault)
            {
                ShowAlert("Start Date or Finish Date incorrect format !");
                return;
            }
            if (fromDate > toDate)
            {
                ShowAlert("Start Date canot be greater than Finish Date !");
                return;
            }

            try {

                var scheduleInTimeList = CommonController.GetScheduleFromTo(fromDate, toDate);
                var scheduleInTimeByMachineTypeList = scheduleInTimeList.Where(w => w.MachineType == machineTypeSelected).ToList();
                var lineList = scheduleInTimeByMachineTypeList.Select(s => s.LineName).Distinct().ToList();
                var regex = new Regex(@"\D");
                
                tblReport.Rows.Clear();
                if (showWhat.Equals("MachineSummay"))
                {
                    var allmachineList = ViewState["allMachineList"] as List<MachineModel>;
                    var machineListByMachineTyple = allmachineList.Where(w => w.MachineType.Equals(machineTypeSelected)).ToList();

                    lblTitleReport.Text = "Machine Summary";

                    TableRow trHeader = new TableRow();

                    TableCell tcNoOfHeader = new TableCell();
                    tcNoOfHeader.Text = "<b><center>Machine</center></b>";
                    trHeader.Cells.Add(tcNoOfHeader);

                    for (var date = fromDate; date <= toDate; date = date.AddDays(1))
                    {
                        TableCell tcDate = new TableCell();
                        tcDate.Text = String.Format("<b><center>{0:MM/dd}</center></b>", date);
                        trHeader.Cells.Add(tcDate);
                    }
                    tblReport.Rows.Add(trHeader);
                    foreach (var machine in machineListByMachineTyple)
                    {
                        TableRow trContentMachine = new TableRow();

                        TableCell tcMachine = new TableCell();
                        tcMachine.Text = String.Format("<center>{0}-{1}</center>", machine.MachineType, machine.Name);
                        trContentMachine.Cells.Add(tcMachine);

                        for (var date = fromDate; date <= toDate; date = date.AddDays(1))
                        {
                            TableCell tcSchedule = new TableCell();
                            trContentMachine.Cells.Add(tcSchedule);
                            var scheduleByMachineByDate = scheduleInTimeByMachineTypeList.FirstOrDefault(f => f.MachineId == machine.MachineId && f.ScheduleDate == date);
                            if (scheduleByMachineByDate != null)
                                tcSchedule.Text = String.Format("<center>{0}</center>", scheduleByMachineByDate.LineName);
                        }

                        tblReport.Rows.Add(trContentMachine);
                    }


                }
                if (showWhat.Equals("LineSummary"))
                {
                    var lineCustomList = lineList.Select(s => new { Line = s, LineNumber = regex.IsMatch(s) ? regex.Replace(s, "") : s }).ToList();
                    if (lineCustomList.Count() > 0)
                        lineCustomList = lineCustomList.OrderBy(o => String.IsNullOrEmpty(o.LineNumber) ? 100 : Int32.Parse(o.LineNumber)).ThenBy(th => th.Line).ToList();

                    lblTitleReport.Text = "Line Summary";

                    TableRow trHeader = new TableRow();
                    TableCell tcNoOfHeader = new TableCell();
                    tcNoOfHeader.Text = "<b><center>Line</center></b>";
                    trHeader.Cells.Add(tcNoOfHeader);

                    for (var date = fromDate; date <= toDate; date = date.AddDays(1))
                    {
                        TableCell tcDate = new TableCell();
                        tcDate.Text = String.Format("<b><center>{0:MM/dd}</center></b>", date);
                        trHeader.Cells.Add(tcDate);
                    }
                    tblReport.Rows.Add(trHeader);                    

                    //tcLine.Controls.Add(lnkLine);
                    //tr.Cells.Add(tcLine);

                    foreach (var line in lineCustomList)
                    {
                        TableRow trContentLine = new TableRow();

                        TableCell tcLine = new TableCell();
                        tcLine.Text = String.Format("<center>{0}</center>", line.Line);
                        trContentLine.Cells.Add(tcLine);
                        for (var date = fromDate; date <= toDate; date = date.AddDays(1))
                        {
                            var scheduleListByLineDate = scheduleInTimeByMachineTypeList.Where(w => w.LineName.Equals(line.Line) && w.ScheduleDate == date).ToList();
                            TableCell tcSchedule = new TableCell();
                            tcSchedule.CssClass = "text-center";
                            int i = 0;
                            foreach (var schedule in scheduleListByLineDate)
                            {
                                var linkSchedule = new HyperLink
                                {
                                    Text = i > 0 == true ? String.Format("</br>{0}", schedule.MachineName) : String.Format("{0}", schedule.MachineName),
                                    NavigateUrl = String.Format("SummaryDetail.aspx?par={0}[{1}-{2}", schedule.MachineId, fromDate.ToOADate(), toDate.ToOADate()),
                                    CssClass = "btn btn-outline-info btn-sm rounded-0"
                                };
                                tcSchedule.Controls.Add(linkSchedule);
                                i++;
                            }
                            //if (scheduleListByLineDate != null)
                            //    tcSchedule.Text = String.Format("<center>{0}</center>", String.Join("</br>", scheduleListByLineDate.Select(s => s.MachineName).ToList()));
                            trContentLine.Cells.Add(tcSchedule);
                        }
                        tblReport.Rows.Add(trContentLine);
                    }

                    // Total Request Row
                    TableRow trTotalRequest = new TableRow();
                    TableCell tcRequest = new TableCell();
                    tcRequest.Text = String.Format("<center><b>{0}</b></center>", "Total Req'd");
                    trTotalRequest.Cells.Add(tcRequest);
                    for (var date = fromDate; date <= toDate; date = date.AddDays(1))
                    {
                        var scheduleByLineByDate = scheduleInTimeByMachineTypeList.Where(w => w.ScheduleDate == date).ToList();
                        TableCell tcRequestDate = new TableCell();
                        if (scheduleByLineByDate.Count() > 0)
                            tcRequestDate.Text = String.Format("<center>{0}</center>", scheduleByLineByDate.Count());
                        trTotalRequest.Cells.Add(tcRequestDate);
                    }
                    tblReport.Rows.Add(trTotalRequest);

                    // Total Excess/Lacking
                    TableRow trExcessLacking = new TableRow();
                    TableCell tcEL = new TableCell();
                    tcEL.Text = String.Format("<center><b>{0}</b></center>", "Excess</br>Lacking");
                    trExcessLacking.Cells.Add(tcEL);
                    var totalMachine = allMachineList.Where(w => w.MachineType.Equals(machineTypeSelected)).ToList().Count();
                    for (var date = fromDate; date <= toDate; date = date.AddDays(1))
                    {
                        var scheduleByLineByDate = scheduleInTimeByMachineTypeList.Where(w => w.ScheduleDate == date).ToList();
                        TableCell tcELDate = new TableCell();
                        tcELDate.Text = String.Format("<center>{0}</center>", totalMachine - scheduleByLineByDate.Count());
                        trExcessLacking.Cells.Add(tcELDate);
                    }
                    tblReport.Rows.Add(trExcessLacking);
                }
            }
            catch (Exception ex)
            {
                ShowAlert(ex.Message.ToString());
                return;
            }
        }

        private DateTime ConvertDateStatic(string dateString)
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