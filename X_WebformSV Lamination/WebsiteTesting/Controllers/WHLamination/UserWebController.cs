using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

using WebsiteTesting.Models.WHLamination;
using WebsiteTesting.Entities;
using System.Data;
namespace WebsiteTesting.Controllers.WHLamination
{
    public class UserWebController
    {
        public static List<UserWebModel> GetWHLaminationUser()
        {
            using (var db = new WHLaminationEntities())
            {
                return db.Database.SqlQuery<UserWebModel>("EXEC spm_SelectUserWeb").ToList();
            }
        }
    }
}