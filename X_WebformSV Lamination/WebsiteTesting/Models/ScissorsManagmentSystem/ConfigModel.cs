using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebsiteTesting.Models.ScissorsManagmentSystem
{
    [Serializable]
    public class ConfigModel
    {
        public int ConfigId { get; set; }
        public int NoOfMaxBigScissors { get; set; }
        public int NoOfMaxSmallScissors { get; set; }
    }
}