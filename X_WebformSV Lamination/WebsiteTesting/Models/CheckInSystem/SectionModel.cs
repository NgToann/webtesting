using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebsiteTesting.Models.CheckInSystem
{
    [Serializable]
    public class SectionModel
    {
        public string SectionId { get; set; }
        public string Name { get; set; }
        public string Password { get; set; }
        public string Keyword_1 { get; set; }
        public string Keyword { get; set; }
    }
}