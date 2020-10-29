using System;
using System.Collections.Generic;
using System.Text;

namespace WebsiteTesting.Models.LoadingSystem
{
    [Serializable]
    public class CartonNumberingModel
    {
        public string ProductNo { get; set; }
        public string SizeNo { get; set; }
        public int Quantity { get; set; }
        public double GrossWeight { get; set; }
        public int CartonNoBasic { get; set; }
        public string Barcode { get; set; }
    }
}
