﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

using WebsiteTesting.Entities;
using WebsiteTesting.Models.ScissorsManagmentSystem;

namespace WebsiteTesting.Controllers.ScissorsController
{
    public class ScissorsMainController
    {
        public static String GetFactory()
        {
            using (var db = new ScissorsManagmentEntities())
            {
                return db.Database.SqlQuery<String>("EXEC spm_SelectFactory").FirstOrDefault();
            }
        }
        // User
        public static List<UserModel> GetUserList()
        {
            using (var db = new ScissorsManagmentEntities())
            {
                return db.Database.SqlQuery<UserModel>("EXEC spm_SelectUserList").ToList();
            }
        }

        // Issuance
        public static List<IssuanceModel> GetIssuance()
        {
            using (var db = new ScissorsManagmentEntities())
            {
                return db.Database.SqlQuery<IssuanceModel>("EXEC spm_SelectIssuance").ToList();
            }
        }

        public static List<IssuanceModel> GetReturnedScissors()
        {
            using (var db = new ScissorsManagmentEntities())
            {
                return db.Database.SqlQuery<IssuanceModel>("EXEC spm_SelectIssuanceReturnedScissors").ToList();
            }
        }

        public static List<IssuanceModel> GetIssuanceByWorkerId(string workerId)
        {
            var @WorkerId = new SqlParameter("@WorkerId", workerId);
            using (var db = new ScissorsManagmentEntities())
            {
                return db.Database.SqlQuery<IssuanceModel>("EXEC spm_SelectIssuanceByWorkerId @WorkerId", WorkerId).ToList();
            }
        }

        public static bool InsertIssuance (IssuanceModel model)
        {
            var @WorkerId               = new SqlParameter("@WorkerId", model.WorkerId);
            var @WorkerName             = new SqlParameter("@WorkerName", model.WorkerName);
            var @Section                = new SqlParameter("@Section", model.Section);
            var @Line                   = new SqlParameter("@Line", model.Line);
            var @ScissorsBarcode        = new SqlParameter("@ScissorsBarcode", model.ScissorsBarcode);
            var @IssuanceBy             = new SqlParameter("@IssuanceBy", model.IssuanceBy);
            var @IsBig                  = new SqlParameter("@IsBig", model.IsBig);

            var insertScissors = new ScissorsModel()
            {
                Barcode         = model.ScissorsBarcode,
                StatusCurrent   = "Assigned",
                IsBig           = model.IsBig
            };
            InsertScissors(insertScissors);

            using (var db = new ScissorsManagmentEntities())
            {
                if (db.Database.ExecuteSqlCommand("EXEC spm_InsertIssuance  @WorkerId, @WorkerName, @Section, @Line, @ScissorsBarcode, @IssuanceBy, @IsBig",
                                                                            @WorkerId, @WorkerName, @Section, @Line, @ScissorsBarcode, @IssuanceBy, @IsBig) > 0)
                {
                    return true;
                }
                return false;
            }
        }

        public static bool ReturnScissors(IssuanceModel model)
        {
            
            var @IssuanceId = new SqlParameter("@IssuanceId", model.IssuanceId);

            var returnScissors = new ScissorsModel()
            {
                Barcode         = model.ScissorsBarcode,
                StatusCurrent   = "Returned",
                IsBig           = model.IsBig
            };
            InsertScissors(returnScissors);

            using (var db = new ScissorsManagmentEntities())
            {
                if (db.Database.ExecuteSqlCommand("EXEC spm_ReturnScissors  @IssuanceId",
                                                                            @IssuanceId) > 0)
                {
                    return true;
                }
                return false;
            }
        }

        public static bool ReplaceScissors(IssuanceModel model)
        {
            var @IssuanceId             = new SqlParameter("@IssuanceId", model.IssuanceId);
            var @ScissorsBarcode        = new SqlParameter("@ScissorsBarcode", model.ScissorsBarcode);
            var @ScissorsBarcodeReplace = new SqlParameter("@ScissorsBarcodeReplace", model.ScissorsBarcodeReplace);
            var @Reason                 = new SqlParameter("@Reason", model.Reason);

            var scissorsUpdate = new ScissorsModel()
            {
                Barcode         = model.ScissorsBarcodeReplace,
                StatusCurrent   = model.Reason,
                IsBig           = model.IsBig
            };
            InsertScissors(scissorsUpdate);

            var scissorsReplace = new ScissorsModel() { 
                Barcode         = model.ScissorsBarcode,
                StatusCurrent   = "Assigned",
                IsBig           = model.IsBig
            };
            InsertScissors(scissorsReplace);

            using (var db = new ScissorsManagmentEntities())
            {
                
                if (db.Database.ExecuteSqlCommand("EXEC spm_ReplaceScissors  @IssuanceId, @ScissorsBarcode, @ScissorsBarcodeReplace, @Reason",
                                                                             @IssuanceId, @ScissorsBarcode, @ScissorsBarcodeReplace, @Reason) > 0)
                {
                    return true;
                }
                return false;
            }
        }

        // Scissors
        public static bool InsertScissors(ScissorsModel model)
        {
            var @Barcode        = new SqlParameter("@Barcode", model.Barcode);
            var @IsBig          = new SqlParameter("@IsBig", model.IsBig);
            var @StatusCurrent  = new SqlParameter("@StatusCurrent", model.StatusCurrent);

            using (var db = new ScissorsManagmentEntities())
            {
                if (db.Database.ExecuteSqlCommand("EXEC spm_InsertScissors  @Barcode, @IsBig, @StatusCurrent",
                                                                            @Barcode, @IsBig, @StatusCurrent) > 0)
                {
                    return true;
                }
                return false;
            }
        }

        public static List<ScissorsModel> GetAllScissors()
        {
            using (var db = new ScissorsManagmentEntities())
            {
                return db.Database.SqlQuery<ScissorsModel>("EXEC spm_SelectAllScissors").ToList();
            }
        }

        // Inspection
        public static List<InspectionModel> GetInspectionByDate(DateTime dateSearch)
        {
            var @DateSearch = new SqlParameter("@DateSearch", dateSearch);
            using (var db = new ScissorsManagmentEntities())
            {
                return db.Database.SqlQuery<InspectionModel>("EXEC spm_SelectInspectionByDate @DateSearch", @DateSearch).ToList();
            }
        }

        public static List<InspectionReportModel> GetInspectionReportByDate(DateTime dateSearch)
        {
            var @DateSearch = new SqlParameter("@DateSearch", dateSearch);
            using (var db = new ScissorsManagmentEntities())
            {
                return db.Database.SqlQuery<InspectionReportModel>("EXEC spm_SelectInspectionByDate_1 @DateSearch", @DateSearch).ToList();
            }
        }

        public static bool InsertInspection(InspectionModel model)
        {
            var @Barcode            = new SqlParameter("@Barcode", model.Barcode);
            var @WorkerId           = new SqlParameter("@WorkerId", model.WorkerId);
            var @WorkerName         = new SqlParameter("@WorkerName", model.WorkerName);
            var @InspectionDate     = new SqlParameter("@InspectionDate", model.InspectionDate);
            var @Inspector          = new SqlParameter("@Inspector", model.Inspector);

            using (var db = new ScissorsManagmentEntities())
            {
                if (db.Database.ExecuteSqlCommand("EXEC spm_InsertInspection_1  @WorkerId, @WorkerName, @Barcode, @InspectionDate, @Inspector",
                                                                                @WorkerId, @WorkerName, @Barcode, @InspectionDate, @Inspector) > 0)
                {
                    return true;
                }
                return false;
            }
        }
    }
}