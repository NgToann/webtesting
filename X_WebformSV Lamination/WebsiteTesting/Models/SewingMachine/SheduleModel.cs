using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebsiteTesting.Models.SewingMachine
{
    [Serializable]
    public class ScheduleModel
    {
		public int ScheduleId { get; set; }
		public int MachineId { get; set; }
		public DateTime ScheduleDate { get; set; }
		public string Remarks { get; set; }
		public DateTime FromDate { get; set; }
		public DateTime ToDate { get; set; }
		public string Style { get; set; }
		public string PatternNo { get; set; }
		public string LineName { get; set; }
		public string MachineType { get; set; }
		public string MachineName { get; set; }
		public string CreatedBy { get; set; }
		public string UpdatedBy { get; set; }
		public double Matching { get; set; }
		public Nullable<DateTime> CreatedTime { get; set; }
		public Nullable <DateTime> UpdatedTime { get; set; }
	}
}