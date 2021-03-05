using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebsiteTesting.Models.WHLamination
{
    [Serializable]
    public class RejectModel
    {
        public int RejectId { get; set; }
        public string RejectName { get; set; }
        public string RejectName_1 { get; set; }
        public string RejectKey { get; set; }
        public bool Major { get; set; }
        public bool Minor { get; set; }
        public bool Outsole { get; set; }
        public bool UpperAccessories { get; set; }
        public bool Lamination { get; set; }

    }
}