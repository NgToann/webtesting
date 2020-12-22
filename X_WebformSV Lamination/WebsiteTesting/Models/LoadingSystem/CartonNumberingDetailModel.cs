using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WebsiteTesting.Models.LoadingSystem
{
    [Serializable]
    class CartonNumberingDetailModel
    {
        public string ProductNo { get; set; }
        public string SizeNo { get; set; }
        public int CartonNo { get; set; }
    }
}
