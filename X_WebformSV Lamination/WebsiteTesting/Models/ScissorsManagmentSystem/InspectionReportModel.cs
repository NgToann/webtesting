using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebsiteTesting.Models.ScissorsManagmentSystem
{
    [Serializable]
    public class InspectionReportModel
    {
        public string WorkerId { get; set; }
        public string WorkerName { get; set; }
        public string Section { get; set; }
        public string Line { get; set; }
        public string ScissorsBarcode { get; set; }
        public bool IsBig { get; set; }
        public string  Scanned { get; set; }
        public Nullable<DateTime> IssuanceTime { get; set; }
        public Nullable<DateTime> InspectionDate { get; set; }
        public Nullable<DateTime> CreatedTime { get; set; }
    }
}