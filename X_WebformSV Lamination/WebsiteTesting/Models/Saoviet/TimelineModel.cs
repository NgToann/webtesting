using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebsiteTesting.Models.Saoviet
{
    public class TimelineModel
    {
        public string TimeLineId { get; set; }
        public int Ordinal { get; set; }
        public TimeSpan StartTime { get; set; }
        public TimeSpan EndTime { get; set; }
    }
}