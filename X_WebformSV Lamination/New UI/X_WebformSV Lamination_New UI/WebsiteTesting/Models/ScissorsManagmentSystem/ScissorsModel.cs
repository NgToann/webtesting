using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebsiteTesting.Models.ScissorsManagmentSystem
{
    [Serializable]
    public class ScissorsModel
    {
        public string Barcode { get; set; }
        public bool IsBig { get; set; }
        public string StatusCurrent { get; set; }
    }
}