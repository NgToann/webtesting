using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebsiteTesting.ViewModels.LoadingSystem
{
    public class CalTotalWeightViewModel
    {
        public string ProductNo { get; set; }
        public int NumberOfCarton { get; set; }
        public int NumberOfPassed { get; set; }
        public double TotalWeight { get; set; }
    }
}