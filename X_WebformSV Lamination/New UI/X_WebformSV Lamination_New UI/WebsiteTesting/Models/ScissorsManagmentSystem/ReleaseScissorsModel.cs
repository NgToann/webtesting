using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Permissions;
using System.Web;

namespace WebsiteTesting.Models.ScissorsManagmentSystem
{
    [Serializable]
    public class ReleaseScissorsModel
    {
        public int ReleaseId { get; set; }
        public string WorkerId { get; set; }
        public string WorkerName { get; set; }
        public string Section { get; set; }
        public string LineName { get; set; }
        public string Barcode { get; set; }
        public string ScissorsType { get; set; }
        public string Status { get; set; }
        public string BarcodeReplace { get; set; }
        public string Reason { get; set; }
        public string ReleaseBy { get; set; }
        public DateTime CreatedTime { get; set; }
    }
}