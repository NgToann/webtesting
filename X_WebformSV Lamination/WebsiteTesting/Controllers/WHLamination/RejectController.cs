using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using WebsiteTesting.Models.WHLamination;
using WebsiteTesting.Entities;
using System.Data;

namespace WebsiteTesting.Controllers.WHLamination
{
    public class RejectController
    {
        public static List<RejectModel> GetWHLaminationRejects()
        {
            using (var db = new WHLaminationEntities())
            {
                return db.Database.SqlQuery<RejectModel>("EXEC spm_SelectRejectWHLamination").ToList();
            }
        }
    }
}