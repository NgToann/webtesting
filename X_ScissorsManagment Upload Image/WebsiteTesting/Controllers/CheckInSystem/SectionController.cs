using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebsiteTesting.Entities;
using WebsiteTesting.Models.CheckInSystem;

namespace WebsiteTesting.Controllers.CheckInSystem
{
    public class SectionController
    {
        static SaovietCheckInEntities db = new SaovietCheckInEntities();
        public static List<SectionModel> Select()
        {
            return db.ExecuteStoreQuery<SectionModel>("spw_SelectSection").ToList();
        }
    }
}