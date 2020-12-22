using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebsiteTesting.Models.SewingMachine
{
    [Serializable]
    public class OutsoleMachineTypeModel
    {
        public int Id { get; set; }
        public string MachineType { get; set; }
        public int OrderNo { get; set; }
        public string SectionName { get; set; }
    }
}