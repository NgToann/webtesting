using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebsiteTesting.Entities;
using WebsiteTesting.Models.CheckInSystem;
using System.Data.SqlClient;

namespace WebsiteTesting.Controllers.CheckInSystem
{
    public class SourceController
    {
        static SaovietCheckInEntities db = new SaovietCheckInEntities();
        public static List<SourceModel> Select(string department, DateTime date)
        {
            var @Line = new SqlParameter("@Line", department);
            var @Date = new SqlParameter("@Date", date);
            return db.ExecuteStoreQuery<SourceModel>("spw_SelectSourceByLineDate @Line, @Date", @Line, @Date).ToList();
        }
    }
}