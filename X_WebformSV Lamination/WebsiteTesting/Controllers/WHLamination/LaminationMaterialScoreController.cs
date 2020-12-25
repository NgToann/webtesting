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
    public class LaminationMaterialScoreController
    {

        public static LaminationMaterialScoreModel GetLaminationMatsScoreByOrderNoId(string orderNoId)
        {
            var @OrderNoId = new SqlParameter("@OrderNoId", orderNoId);
            using (var db = new WHLaminationEntities())
            {
                return db.Database.SqlQuery<LaminationMaterialScoreModel>("EXEC spm_SelectLaminationMaterialScoreByOrderNoId @OrderNoId", @OrderNoId).FirstOrDefault();
            }
        }

        public static bool Insert(LaminationMaterialScoreModel model)
        {
            var @OrderNoId      = new SqlParameter("@OrderNoId", model.OrderNoId);
            var @POQuantity     = new SqlParameter("@POQuantity", model.POQuantity);
            var @LabelQuantity  = new SqlParameter("@LabelQuantity", model.LabelQuantity);
            var @ActualQuantity = new SqlParameter("@ActualQuantity", model.ActualQuantity);
            var @LabelWidth     = new SqlParameter("@LabelWidth", model.LabelWidth);
            var @ActualWidth    = new SqlParameter("@ActualWidth", model.ActualWidth);
            var @DefectType1    = new SqlParameter("@DefectType1", model.DefectType1);
            var @DefectType2    = new SqlParameter("@DefectType2", model.DefectType2);
            var @DefectType3    = new SqlParameter("@DefectType3", model.DefectType3);
            var @DefectType4    = new SqlParameter("@DefectType4", model.DefectType4);
            var @HoleType2      = new SqlParameter("@HoleType2", model.HoleType2);
            var @HoleType4      = new SqlParameter("@HoleType4", model.HoleType4);
            var @TotalScore     = new SqlParameter("@TotalScore", model.TotalScore);
            var @Reviser        = new SqlParameter("@Reviser", model.Reviser);

            using (var db = new WHLaminationEntities())
            {
                if (db.Database.ExecuteSqlCommand("EXEC spm_InsertLaminationMaterialScore @OrderNoId, @POQuantity, @LabelQuantity, @ActualQuantity, @LabelWidth, @ActualWidth, @DefectType1, @DefectType2, @DefectType3, @DefectType4, @HoleType2, @HoleType4, @TotalScore, @Reviser",
                                                                                          @OrderNoId, @POQuantity, @LabelQuantity, @ActualQuantity, @LabelWidth, @ActualWidth, @DefectType1, @DefectType2, @DefectType3, @DefectType4, @HoleType2, @HoleType4, @TotalScore, @Reviser) > 0)
                {
                    return true;
                }
                return false;
            }
        }
    }
}