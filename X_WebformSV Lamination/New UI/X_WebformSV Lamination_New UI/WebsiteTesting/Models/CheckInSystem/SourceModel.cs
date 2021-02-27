using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebsiteTesting.Models.CheckInSystem
{
    public class SourceModel
    {
        public string CardId { get; set; }
        public DateTime Date { get; set; }
        public string Time { get; set; }
        public string TerminalNo { get; set; }
    }
}