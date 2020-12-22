using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebsiteTesting.Models.CheckInSystem
{
    public class HolidayModel
    {
        public int HolidayId { get; set; }
        public DateTime Date { get; set; }
        public string Description { get; set; }
    }
}