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
    public class ReportController
    {
        public static List<WHLaminationReportModel> GetWHLaminationUser(DateTime fromDate, DateTime toDate)
        {
            var @From = new SqlParameter("@From", fromDate);
            var @To = new SqlParameter("@To", toDate);
            using (var db = new WHLaminationEntities())
            {
                return db.Database.SqlQuery<WHLaminationReportModel>("EXEC reporter_WHLaminationFromTo_1 @From, @To", @From, @To).ToList();
            }
        }
    }
}