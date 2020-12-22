using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Permissions;
using System.Web;

namespace WebsiteTesting.Models.ScissorsManagmentSystem
{
    [Serializable]
    public class InspectionModel
    {
        public string WorkerId { get; set; }
        public string WorkerName { get; set; }
        public string Barcode { get; set; }
        public DateTime InspectionDate { get; set; }
        public string Section { get; set; }
        public string Line { get; set; }
        public string Inspector { get; set; }
    }
}