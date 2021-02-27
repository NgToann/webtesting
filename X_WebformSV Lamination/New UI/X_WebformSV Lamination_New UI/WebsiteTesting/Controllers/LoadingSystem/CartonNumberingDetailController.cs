﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using WebsiteTesting.Entities;
using WebsiteTesting.Models.LoadingSystem;
using System.Data.SqlClient;
namespace WebsiteTesting.Controllers.LoadingSystem
{
    class CartonNumberingDetailController
    {
        static SaovietWeightControlEntities db = new SaovietWeightControlEntities();

        public static List<CartonNumberingDetailModel> Get(string productNo)
        {
            var @ProductNo = new SqlParameter("@ProductNo", productNo);
            return db.ExecuteStoreQuery<CartonNumberingDetailModel>("spm_SelectCartonNumberingDetailByProductNo @ProductNo", @ProductNo).ToList();
        }

        public static bool Create(CartonNumberingDetailModel model)
        {
            var @ProductNo = new SqlParameter("@ProductNo", model.ProductNo);
            var @SizeNo = new SqlParameter("@SizeNo", model.SizeNo);
            var @CartonNo = new SqlParameter("@CartonNo", model.CartonNo);
            if (db.ExecuteStoreCommand("spm_InsertCartonNumberingDetail @ProductNo, @SizeNo, @CartonNo", @ProductNo, @SizeNo, @CartonNo) > 0)
            {
                return true;
            }
            return false;
        }

        public static bool Delete(string productNo)
        {
            var @ProductNo = new SqlParameter("@ProductNo", productNo);
            if (db.ExecuteStoreCommand("spm_DeleteCartonNumberingDetailByProductNo @ProductNo", @ProductNo) > 0)
            {
                return true;
            }
            return false;
        }
    }
}
