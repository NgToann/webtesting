using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebsiteTesting.Models.ScissorsManagmentSystem
{
    [Serializable]
    public class UserModel
    {
        public string UserId { get; set; }
        public string Password { get; set; }
    }
}