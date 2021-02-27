using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using WebsiteTesting.Entities;
using WebsiteTesting.Models.Saoviet;
using System.Data.SqlClient;
namespace WebsiteTesting.Controllers.Saoviet
{
    public class ProductOutputController
    {
        static SaovietEntities db = new SaovietEntities();
        public static List<ProductOutputModel> Select(DateTime date)
        {
            var @ModifiedTime = new SqlParameter("@ModifiedTime", date);
            return db.ExecuteStoreQuery<ProductOutputModel>("sp_m_SelectProductOutputByDateTime @ModifiedTime", @ModifiedTime).ToList();
        }

        public static List<ProductOutputModel> Select(string lineId, DateTime date)
        {
            var @LineId = new SqlParameter("@LineId", lineId);
            var @ModifiedTime = new SqlParameter("@ModifiedTime", date);
            return db.ExecuteStoreQuery<ProductOutputModel>("sp_m_SelectProductOutputByLineIdDateTime @LineId, @ModifiedTime", @LineId, @ModifiedTime).ToList();
        }
    }
}