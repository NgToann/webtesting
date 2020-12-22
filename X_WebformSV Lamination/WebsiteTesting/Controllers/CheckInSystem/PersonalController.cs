using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebsiteTesting.Models.CheckInSystem;
using WebsiteTesting.Entities;
using System.Data.SqlClient;

namespace WebsiteTesting.Controllers.CheckInSystem
{
    public class PersonalController
    {
        static SaovietCheckInEntities db = new SaovietCheckInEntities();
        public static List<PersonalModel> Select()
        {            
            return db.ExecuteStoreQuery<PersonalModel>("spw_SelectPersonal").ToList();
        }

        public static List<PersonalModel> Select(string departments)
        {            
            List<PersonalModel> personalList = new List<PersonalModel>();
            foreach (string department in departments.Split(','))
            {
                var @Department = new SqlParameter("@Department", department);
                personalList.AddRange(db.ExecuteStoreQuery<PersonalModel>("spw_SelectPersonalByDepartment @Department", @Department).ToList());
            }
            return personalList;
        }
    }
}