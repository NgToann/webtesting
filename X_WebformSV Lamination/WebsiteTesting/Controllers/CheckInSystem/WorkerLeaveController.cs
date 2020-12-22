using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebsiteTesting.Entities;
using WebsiteTesting.Models.CheckInSystem;
using System.Data.SqlClient;

namespace WebsiteTesting.Controllers.CheckInSystem
{
    public class WorkerLeaveController
    {
        static SaovietCheckInEntities db = new SaovietCheckInEntities();
        public static List<WorkerLeaveModel> Select(int year, int month)
        {            
            var @Year = new SqlParameter("@Year", year);
            var @Month = new SqlParameter("@Month", month);
            return db.ExecuteStoreQuery<WorkerLeaveModel>("spw_SelectWorkerLeaveByYearMonth @Year, @Month", @Year, @Month).ToList();
        }
    }
}