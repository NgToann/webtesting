using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebsiteTesting.Models.CheckInSystem;
using WebsiteTesting.Controllers.CheckInSystem;

namespace WebsiteTesting.Pages.CheckInSystem
{
    public partial class AttendancePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack == true)
            {
                return;
            }
            List<SectionModel> sectionList = SectionController.Select();
            sectionList.Insert(0, new SectionModel());
            ViewState["sectionList"] = sectionList;
            cboSection.DataSource = sectionList;
            cboSection.DataBind();            
        }

        protected void cboSection_SelectedIndexChanged(object sender, EventArgs e)
        {
            List<SectionModel> sectionList = ViewState["sectionList"] as List<SectionModel>;
            SectionModel section = sectionList[cboSection.SelectedIndex];
            string[] lineArray = {};
            List<PersonalModel> personalList = new List<PersonalModel>();
            if (string.IsNullOrEmpty(section.Keyword) == false)
            {
                personalList = PersonalController.Select(section.Keyword);                
                lineArray = personalList.Select(p => p.Department).Distinct().ToArray();

            }            
            ViewState["personalList"] = personalList;
            cboLine.DataSource = lineArray;
            cboLine.DataBind();    
            
        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            string line = cboLine.SelectedValue;
            if (string.IsNullOrEmpty(line) == true)
            {
                return;
            }
            List<PersonalModel> personalList = ViewState["personalList"] as List<PersonalModel>;
            personalList = personalList.Where(p => p.Department == line).OrderBy(p => p.WorkerId).ToList();
            DateTime date = DateTime.Now;
            List<SourceModel> sourceList = SourceController.Select(line, date);
            List<WorkerLeaveModel> workerLeaveList = WorkerLeaveController.Select(date.Year, date.Month);
            List<HolidayModel> holidayList = HolidayController.Select(date.Year, date.Month);            

            TableRow trHeader = new TableRow();
            TableCell tcNumberOfHeader = new TableCell();
            tcNumberOfHeader.Text = "<b>No.</b>";
            trHeader.Cells.Add(tcNumberOfHeader);
            TableCell tcWorkerIdHeader = new TableCell();
            tcWorkerIdHeader.Text = "<b>Worker ID</b>";
            trHeader.Cells.Add(tcWorkerIdHeader);
            TableCell tcNameHeader = new TableCell();
            tcNameHeader.Text = "<center><b>Full Name</b></center>";
            trHeader.Cells.Add(tcNameHeader);
            TableCell tcDateHeader = new TableCell();
            tcDateHeader.Text = string.Format("<b>{0:dd/MM}</b>", date);
            trHeader.Cells.Add(tcDateHeader);
            tableAttendance.Rows.Add(trHeader);

            int i = 1;
            foreach (PersonalModel personal in personalList)
            {                
                SourceModel source = sourceList.Where(s => s.CardId == personal.CardId).FirstOrDefault();
                if (source == null)
                {
                    TableRow tr = new TableRow();
                    TableCell tcNumberOf = new TableCell();
                    tcNumberOf.Text = string.Format("{0}", i);
                    tr.Cells.Add(tcNumberOf);
                    TableCell tcWorkerId = new TableCell();
                    tcWorkerId.Text = personal.WorkerId;
                    tr.Cells.Add(tcWorkerId);
                    TableCell tcName = new TableCell();
                    tcName.Text = personal.Name;
                    tr.Cells.Add(tcName);

                    TableCell tcDate = new TableCell();                    
                    tcDate.BackColor = System.Drawing.Color.Transparent;
                    if (date.DayOfWeek != DayOfWeek.Sunday && holidayList.Select(h => h.Date.Date).Contains(date.Date) == false)
                    {
                        List<WorkerLeaveModel> workerLeaveList_ByWorkerId = workerLeaveList.Where(w => w.WorkerId == personal.WorkerId && w.StartDate.Date <= date.Date && date.Date <= w.EndDate.Date).ToList();
                        if (workerLeaveList_ByWorkerId.Count > 0)
                        {
                            WorkerLeaveModel workerLeave = workerLeaveList_ByWorkerId.OrderBy(w => w.CreatedDate).Last();
                            LeaveTypeModel leaveType = LeaveTypeModel.Init().Where(l => l.LeaveTypeId == workerLeave.LeaveType).FirstOrDefault();
                            if (leaveType != null)
                            {
                                tcDate.BackColor = leaveType.BackgroundColor;
                            }
                        }
                        else
                        {
                            tcDate.BackColor = System.Drawing.Color.Red;
                        }
                    }
                    tr.Cells.Add(tcDate);
                    tableAttendance.Rows.Add(tr);
                    i = i + 1;
                }
            }
        }
    }
}