using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebsiteTesting.Models.SewingMachine
{
    [Serializable]
    public class ScheduleDetailModel
    {
        public int MachineId { get; set; }
        public DateTime ScheduleDate { get; set; }
        public string Remarks { get; set; }
        public double Matching { get; set; }
    }
}