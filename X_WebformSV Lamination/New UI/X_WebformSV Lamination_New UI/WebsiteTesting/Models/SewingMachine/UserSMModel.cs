using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebsiteTesting.Models.SewingMachine
{
    [Serializable]
    public class UserSMModel
    {
        public string UserName { get; set; }
        public string FullName { get; set; }
        public string Password { get; set; }

        public bool IsSewingMachine { get; set; }
        public bool IsOutsoleMachine { get; set; }
    }
}