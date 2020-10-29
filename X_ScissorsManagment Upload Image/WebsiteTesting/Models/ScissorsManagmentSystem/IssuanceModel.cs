using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebsiteTesting.Models.ScissorsManagmentSystem
{
    [Serializable]
    public class IssuanceModel
    {
        public int IssuanceId { get; set; }
        public string WorkerId { get; set; }
        public string WorkerName { get; set; }
        public string Section { get; set; }
        public string Line { get; set; }
        public string ScissorsBarcode { get; set; }
        public bool IsBig { get; set; }
        public string IssuanceBy { get; set; }
        public DateTime IssuanceTime { get; set; }
        public bool IsReturn { get; set; }
        public DateTime? ReturnTime { get; set; }
        public bool IsReplace { get; set; }
        public string Reason { get; set; }
        public string ScissorsBarcodeReplace { get; set; }
        public DateTime? ReplaceTime { get; set; }

    }
}