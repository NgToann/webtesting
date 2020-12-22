using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebsiteTesting.Models.SampleRoom
{
    public class BorrowShoesModel
    {
        public string EmployeeId { get; set; }
        public string EmployeeName { get; set; }
        public string EmployeeSection { get; set; }
        public string Article { get; set; }
        public int Quantity { get; set; }
        public bool Status { get; set; }
        public string Description { get; set; }
        public string EmployeeImagePath { get; set; }
        public string EmployeeLine { get; set; }
        public string PhoneNumber { get; set; }
        public DateTime BorrowTime { get; set; }
        //public DateTime PayTime { get; set; }
    }
}