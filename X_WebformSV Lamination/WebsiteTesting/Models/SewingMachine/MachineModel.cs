using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebsiteTesting.Models.SewingMachine
{
    [Serializable]
    public class MachineModel
    {
        public int MachineId { get; set; }
        public int Number { get; set; }
        public string MachineType { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public string Barcode { get; set; }
        public string Status { get; set; }
    }
}