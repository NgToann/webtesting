using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebsiteTesting.Models.Saoviet
{
    public class FaultModel
    {
        public string FaultId { get; set; }
        public int Ordinal { get; set; }
        public string KeyString { get; set; }
        public string FaultEnglish { get; set; }
        public string FaultVietnamese { get; set; }
    }
}