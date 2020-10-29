using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using WebsiteTesting.Entities;
using WebsiteTesting.Models.Saoviet;
using System.Data.SqlClient;
namespace WebsiteTesting.Controllers.Saoviet
{
    public class TimelineController
    {
        static SaovietEntities db = new SaovietEntities();
        public static List<TimelineModel> Get()
        {
            return db.ExecuteStoreQuery<TimelineModel>("sp_m_SelectAllTimeLine").ToList();
        }        
    }
}