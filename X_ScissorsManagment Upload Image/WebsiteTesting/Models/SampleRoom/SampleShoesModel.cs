using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebsiteTesting.Models.SampleRoom
{
    public class SampleShoesModel
    {
        public string Article { get; set; }
        public string RDNumber { get; set; }
        public string ArticleName { get; set; }
        public string Color { get; set; }
        public string ShoelastCode { get; set; }
        public string Season { get; set; }
        public string Customer { get; set; }
        public string Size { get; set; }
        public string Factory { get; set; }
        public string Location { get; set; }
        public string ImagePath { get; set; }
        public int Quantity { get; set; }
        public byte[] Image { get; set; }
    }
}