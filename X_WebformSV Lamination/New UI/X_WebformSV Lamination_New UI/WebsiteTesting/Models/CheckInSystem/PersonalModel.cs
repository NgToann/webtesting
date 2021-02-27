using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebsiteTesting.Models.CheckInSystem
{
    [Serializable]
    public class PersonalModel
    {
        public string CardId { get; set; }
        public string WorkerId { get; set; }
        public string Name { get; set; }
        public string Department { get; set; }
        public string Position { get; set; }
        public DateTime HiredDate { get; set; }
        public string SectionId { get; set; }
        public string Section { get; set; }
        public string ReleaseBy { get; set; }
    }
}