using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using WebsiteTesting.Entities;
using System.Data.SqlClient;
using WebsiteTesting.Models.LoadingSystem;

namespace WebsiteTesting.Controllers.LoadingSystem
{
    class PackingController
    {
        static SaovietWeightControlEntities db = new SaovietWeightControlEntities();

        public static List<PackingModel> Get(string productNo)
        {
            var @ProductNo = new SqlParameter("@ProductNo", productNo);
            return db.ExecuteStoreQuery<PackingModel>("spm_SelectPackingByProductNo @ProductNo", @ProductNo).ToList();
        }

        public static bool CreateUpdate(PackingModel model)
        {
            var @ProductNo = new SqlParameter("@ProductNo", model.ProductNo);
            var @SizeNo = new SqlParameter("@SizeNo", model.SizeNo);
            var @CartonNo = new SqlParameter("@CartonNo", model.CartonNo);
            var @ActualWeight = new SqlParameter("@ActualWeight", model.ActualWeight);
            var @DifferencePercent = new SqlParameter("@DifferencePercent", model.DifferencePercent);
            var @IsPass = new SqlParameter("@IsPass", model.IsPass);
            var @IsFirstPass = new SqlParameter("@IsFirstPass", model.IsFirstPass);
            var @CreatedAccount = new SqlParameter("@CreatedAccount", model.CreatedAccount);
            if (db.ExecuteStoreCommand("spm_InsertPacking_2 @ProductNo, @SizeNo, @CartonNo, @ActualWeight, @DifferencePercent,@IsPass, @IsFirstPass, @CreatedAccount", @ProductNo, @SizeNo, @CartonNo, @ActualWeight, @DifferencePercent, @IsPass, @IsFirstPass, @CreatedAccount) > 0)
            {
                return true;
            }
            return false;
        }
    }
}
