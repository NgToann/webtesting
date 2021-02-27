using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebsiteTesting.Models.WHLamination
{
    [Serializable]
    public class UserWebModel
    {
        public string UserName { get; set; }
        public string Password { get; set; }
        public bool WHLamimation { get; set; }
    }
}