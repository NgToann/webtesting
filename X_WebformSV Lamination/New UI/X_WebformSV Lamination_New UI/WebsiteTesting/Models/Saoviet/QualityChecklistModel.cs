using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebsiteTesting.Models.Saoviet
{
    public class QualityChecklistModel
    {
        public string LineId { get; set; }
        public string ProductNumber { get; set; }
        public string FaultId { get; set; }
        public string ImagePath { get; set; }
        public DateTime ModifiedTime { get; set; }
    }
}