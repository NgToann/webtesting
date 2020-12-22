using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using WebsiteTesting.Entities;
using WebsiteTesting.Models.Saoviet;
using System.Data.SqlClient;
namespace WebsiteTesting.Controllers.Saoviet
{
    public class FaultController
    {
        static SaovietEntities db = new SaovietEntities();
        public static List<FaultModel> Select(string faultType)
        {
            var @FaultType = new SqlParameter("@FaultType", faultType);
            return db.ExecuteStoreQuery<FaultModel>("sp_m_SelectFaultByFaultType @FaultType", @FaultType).ToList();
        }        
    }
}