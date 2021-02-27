using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

using WebsiteTesting.Models.WHLamination;
using WebsiteTesting.Entities;
using System.Data;

namespace WebsiteTesting.Controllers.WHLamination
{
    public class LaminationMaterialController
    {
        public static List<LaminationMaterialModel> GetLaminationMaterialByOrderNo(string orderNo)
        {
            var @OrderNo = new SqlParameter("@OrderNo", orderNo);
            using (var db = new WHLaminationEntities())
            {
                return db.Database.SqlQuery<LaminationMaterialModel>("EXEC spm_SelectLaminationMaterialByOrderNo @OrderNo", @OrderNo).ToList();
            }
        }
    }
}