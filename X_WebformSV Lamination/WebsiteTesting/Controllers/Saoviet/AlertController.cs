using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using WebsiteTesting.Entities;
using WebsiteTesting.Models.Saoviet;
using System.Data.SqlClient;
namespace WebsiteTesting.Controllers.Saoviet
{
    public class AlertController
    {
        static SaovietEntities db = new SaovietEntities();
        public static List<AlertModel> Get(DateTime date)
        {
            var @ModifiedTime = new SqlParameter("@ModifiedTime", date);
            return db.ExecuteStoreQuery<AlertModel>("EXEC sp_m_SelectAlertByDateTime @ModifiedTime", @ModifiedTime).ToList();
        }

        public static List<AlertModel> Get(string lineId, DateTime date)
        {
            var @LineId = new SqlParameter("@LineId", lineId);
            var @ModifiedTime = new SqlParameter("@ModifiedTime", date);
            return db.ExecuteStoreQuery<AlertModel>("EXEC sp_m_SelectAlertByLineIdDateTime @LineId, @ModifiedTime", @LineId, @ModifiedTime).ToList();
        }
    }
}