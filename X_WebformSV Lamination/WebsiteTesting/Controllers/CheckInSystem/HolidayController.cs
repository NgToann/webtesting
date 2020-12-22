using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebsiteTesting.Entities;
using WebsiteTesting.Models.CheckInSystem;
using System.Data.SqlClient;

namespace WebsiteTesting.Controllers.CheckInSystem
{
    public class HolidayController
    {
        static SaovietCheckInEntities db = new SaovietCheckInEntities();
        public static List<HolidayModel> Select(int year, int month)
        {            
            var @Year = new SqlParameter("@Year", year);
            var @Month = new SqlParameter("@Month", month);
            return db.ExecuteStoreQuery<HolidayModel>("spw_SelectHolidayByYearMonth @Year, @Month", @Year, @Month).ToList();
        }
    }
}