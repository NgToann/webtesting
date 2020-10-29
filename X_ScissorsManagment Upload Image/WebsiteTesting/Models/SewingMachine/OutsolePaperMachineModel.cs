using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebsiteTesting.Models.SewingMachine
{
    [Serializable]
    public class OutsolePaperMachineModel
    {
        public string SectionName { get; set; }
        public string LineName { get; set; }
        public string ProductNo { get; set; }
        public string StyleName { get; set; }
        public string OutsoleCode { get; set; }
        public string MachineType { get; set; }
        public DateTime CreatedDate { get; set; }
        public byte[] LeftImage { get; set; }
        public byte[] RightImage { get; set; }
        public string CreatedBy { get; set; }
        public string LeftImageString { get; set; }
        public string RightImageString { get; set; }
    }
}