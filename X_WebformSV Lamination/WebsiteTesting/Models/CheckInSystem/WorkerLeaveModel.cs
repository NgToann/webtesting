using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Drawing;

namespace WebsiteTesting.Models.CheckInSystem
{
    public class WorkerLeaveModel
    {
        public int WorkerLeaveId { get; set; }
        public string WorkerId { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public int LeaveType { get; set; }
        public DateTime CreatedDate { get; set; }
    }
    public class LeaveTypeModel
    {
        public int LeaveTypeId { get; set; }
        public string Name { get; set; }
        public Color BackgroundColor { get; set; }        
        public bool HaveIncentive { get; set; }

        public static List<LeaveTypeModel> Init()
        {
            List<LeaveTypeModel> leaveTypeList = new List<LeaveTypeModel>();
            leaveTypeList.Add(new LeaveTypeModel
            {
                LeaveTypeId = 1,
                Name = "Leave",
                BackgroundColor = Color.Green,                
                HaveIncentive = true,
            });
            leaveTypeList.Add(new LeaveTypeModel
            {
                LeaveTypeId = 2,
                Name = "Pregnant",
                BackgroundColor = Color.Yellow,                
                HaveIncentive = false,
            });
            leaveTypeList.Add(new LeaveTypeModel
            {
                LeaveTypeId = 3,
                Name = "Special Leave",
                BackgroundColor = Color.Cyan,                
                HaveIncentive = true,
            });
            return leaveTypeList;
        }
    }
}