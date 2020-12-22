using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebsiteTesting.Models.Saoviet
{
    public class LineModel
    {
        public string LineId { get; set; }
        public int Ordinal { get; set; }
        public string LineName { get; set; }
        public string LineType { get; set; }
        public bool RemoveFlag { get; set; }
    }
}