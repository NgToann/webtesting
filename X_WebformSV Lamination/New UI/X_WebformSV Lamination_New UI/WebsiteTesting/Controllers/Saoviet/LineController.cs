using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using WebsiteTesting.Entities;
using WebsiteTesting.Models.Saoviet;
using System.Data.SqlClient;
namespace WebsiteTesting.Controllers.Saoviet
{
    public class LineController
    {
        static SaovietEntities db = new SaovietEntities();
        public static List<LineModel> Select()
        {
            return db.ExecuteStoreQuery<LineModel>("sp_m_SelectAllLine").ToList();
        }

        public static LineModel First(string lineId)
        {
            var @LineId = new SqlParameter("@LineId", lineId);
            return db.ExecuteStoreQuery<LineModel>("sp_m_SelectLineByLineId @LineId", @LineId).FirstOrDefault();
        }

        public static bool ChangeRemoveFlag(bool removeFlag)
        {            
            var @RemoveFlag = new SqlParameter("@RemoveFlag", removeFlag);
            return db.ExecuteStoreCommand("sp_m_UpdateRemoveFlag @RemoveFlag", @RemoveFlag) > 0;
        }

        public static bool ChangeRemoveFlag(string lineId, bool removeFlag)
        {
            var @LineId = new SqlParameter("@LineId", lineId);
            var @RemoveFlag = new SqlParameter("@RemoveFlag", removeFlag);
            return db.ExecuteStoreCommand("sp_m_UpdateRemoveFlagByLineId @LineId, @RemoveFlag", @LineId, @RemoveFlag) > 0;
        }
    }
}