using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using WebsiteTesting.Entities;
using WebsiteTesting.Models.Saoviet;
using System.Data.SqlClient;
namespace WebsiteTesting.Controllers.Saoviet
{
    public class QualityChecklistController
    {
        static SaovietEntities db = new SaovietEntities();
        public static List<QualityChecklistModel> Get(DateTime date)
        {
            var @ModifiedTime = new SqlParameter("@ModifiedTime", date);
            return db.ExecuteStoreQuery<QualityChecklistModel>("sp_m_SelectQualityChecklistByDateTime @ModifiedTime", @ModifiedTime).ToList();
        }

        public static List<QualityChecklistModel> Get(string lineId, DateTime date)
        {
            var @LineId = new SqlParameter("@LineId", lineId);
            var @ModifiedTime = new SqlParameter("@ModifiedTime", date);
            return db.ExecuteStoreQuery<QualityChecklistModel>("sp_m_SelectQualityChecklistByLineIdDateTime @LineId, @ModifiedTime", @LineId, @ModifiedTime).ToList();
        }
    }
}