using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

using WebsiteTesting.Models.SewingMachine;
using WebsiteTesting.Entities;
using System.Data;

namespace WebsiteTesting.Controllers.SewingMachineController
{
    public class CommonController
    {
        public static List<UserSMModel> GetUserSM()
        {
            using (var db = new SewingMachineEntities())
            {
                return db.Database.SqlQuery<UserSMModel>("EXEC spm_SelectUserSM").ToList();
            }
        }
        public static List<MachineModel> GetMachines()
        {
            using (var db = new SewingMachineEntities())
            {
                return db.Database.SqlQuery<MachineModel>("EXEC spm_SelectMachine").ToList();
            }
        }
        public static bool UpdateMachineBarcode(int machineId, string machineBarcode)
        {
            var @MachineId  = new SqlParameter("@MachineId", machineId);
            var @Barcode    = new SqlParameter("@Barcode", machineBarcode);
            using (var db = new SewingMachineEntities())
            {
                if (db.Database.ExecuteSqlCommand("EXEC spm_UpdateMachineBarcode  @MachineId, @Barcode",
                                                                                  @MachineId, @Barcode) > 0)
                {
                    return true;
                }
                return false;
            }
        }
        

        // Schedule
        public static List<ScheduleModel> GetScheduleFromTo(DateTime fromDate, DateTime toDate)
        {
            var @FromDate   = new SqlParameter("@FromDate", fromDate);
            var @ToDate     = new SqlParameter("@ToDate", toDate);

            using (var db = new SewingMachineEntities())
            {
                return db.Database.SqlQuery<ScheduleModel>("EXEC spm_SelectScheduleFromTo @FromDate, @ToDate", @FromDate, @ToDate).ToList();
            }
        }
        public static ScheduleModel GetScheduleById(int scheduleId)
        {
            var @ScheduleId = new SqlParameter("@ScheduleId", scheduleId);

            using (var db = new SewingMachineEntities())
            {
                return db.Database.SqlQuery<ScheduleModel>("EXEC spm_SelectScheduleById @ScheduleId", @ScheduleId).FirstOrDefault();
            }
        }
        public static List<ScheduleModel> GetAllSchedule()
        {
            using (var db = new SewingMachineEntities())
            {
                return db.Database.SqlQuery<ScheduleModel>("EXEC spm_SelectSchedule").ToList();
            }
        }        
        public static List<ScheduleDetailModel> GetScheduleDetailFromTo(DateTime fromDate, DateTime toDate)
        {
            var @FromDate = new SqlParameter("@FromDate", fromDate);
            var @ToDate = new SqlParameter("@ToDate", toDate);

            using (var db = new SewingMachineEntities())
            {
                return db.Database.SqlQuery<ScheduleDetailModel>("EXEC spm_SelectScheduleDetailFromTo @FromDate, @ToDate", @FromDate, @ToDate).ToList();
            }
        }
        public static bool CreateSchedule(ScheduleModel model, int insertOrUpdateMode)
        {
            var @ScheduleId = new SqlParameter("@ScheduleId", model.ScheduleId);

            var @MachineId  = new SqlParameter("@MachineId", model.MachineId);
            var @FromDate   = new SqlParameter("@FromDate", model.FromDate);
            var @ToDate     = new SqlParameter("@ToDate", model.ToDate);
            var @Style      = new SqlParameter("@Style", model.Style);
            var @PatternNo  = new SqlParameter("@PatternNo", model.PatternNo);
            var @LineName   = new SqlParameter("@LineName", model.LineName);
            var @CreatedBy  = new SqlParameter("@CreatedBy", model.CreatedBy);
            var @Matching   = new SqlParameter("@Matching", model.Matching);
            var @UpdatedBy  = new SqlParameter("@UpdatedBy", model.UpdatedBy);

            // !-999 = Insert Mode
            if (!insertOrUpdateMode.Equals(-999))
                using (var db = new SewingMachineEntities())
                {
                    if (db.Database.ExecuteSqlCommand("EXEC spm_InsertSchedule  @MachineId, @FromDate, @ToDate, @Style, @PatternNo, @LineName, @CreatedBy, @Matching",
                                                                                @MachineId, @FromDate, @ToDate, @Style, @PatternNo, @LineName, @CreatedBy, @Matching) > 0)
                    {
                        return true;
                    }
                    return false;
                }
            // -999 = Update Mode
            else
                using (var db = new SewingMachineEntities())
                {
                    if (db.Database.ExecuteSqlCommand("EXEC spm_UpdateSchedule  @ScheduleId, @FromDate, @ToDate, @Style, @PatternNo, @LineName, @UpdatedBy, @Matching",
                                                                                @ScheduleId, @FromDate, @ToDate, @Style, @PatternNo, @LineName, @UpdatedBy, @Matching) > 0)
                    {
                        return true;
                    }
                    return false;
                }
        }
        public static bool DeleteScheduleById(int scheduleId)
        {
            var @ScheduleId = new SqlParameter("@ScheduleId", scheduleId);
            using (var db = new SewingMachineEntities())
            {
                if (db.Database.ExecuteSqlCommand("EXEC spm_DeleteScheduleById @ScheduleId",
                                                                               @ScheduleId) > 0)
                {
                    return true;
                }
                return false;
            };
        }
        
        // Schedule Detail
        public static bool CreateScheduleDetail(ScheduleDetailModel model)
        {
            var @MachineId = new SqlParameter("@MachineId", model.MachineId);
            var @ScheduleDate = new SqlParameter("@ScheduleDate", model.ScheduleDate);
            var @Remarks = new SqlParameter("@Remarks", model.Remarks);
            var @Matching = new SqlParameter("@Matching", model.Matching);
            using (var db = new SewingMachineEntities())
            {
                if (db.Database.ExecuteSqlCommand("EXEC spm_InsertScheduleDetail @MachineId, @ScheduleDate, @Remarks, @Matching",
                                                                                 @MachineId, @ScheduleDate, @Remarks, @Matching) > 0)
                {
                    return true;
                }
                return false;
            };
        }

        public static bool DeleteScheduleDetailByScheduleId(int scheduleId)
        {
            var @ScheduleId = new SqlParameter("@ScheduleId", scheduleId);
            using (var db = new SewingMachineEntities())
            {
                if (db.Database.ExecuteSqlCommand("EXEC spm_DeleteScheduleDetailByScheduleId @ScheduleId",
                                                                                             @ScheduleId) > 0)
                {
                    return true;
                }
                return false;
            };
        }

        // Outsole Paper
        public static List<OutsoleMachineTypeModel> GetOutsoleMachineTypeList()
        {
            using (var db = new SewingMachineEntities())
            {
                return db.Database.SqlQuery<OutsoleMachineTypeModel>("EXEC spm_os_SelectOutsoleMachineType").ToList();
            }
        }

        public static List<OutsolePaperMachineModel> GetOutsolePaperMachineList()
        {
            using   (var db = new SewingMachineEntities())
            {
                return db.Database.SqlQuery<OutsolePaperMachineModel>("EXEC spm_os_SelectOutsolePaperMachine").ToList();
            }
        }
        public static List<OutsolePaperMachineModel> GetOutsolePaperMachineFromTo(DateTime searchFrom, DateTime searchTo)
        {
            var @SearchFrom = new SqlParameter("@SearchFrom", searchFrom);
            var @SearchTo = new SqlParameter("@SearchTo", searchTo);
            using (var db = new SewingMachineEntities())
            {
                return db.Database.SqlQuery<OutsolePaperMachineModel>("EXEC spm_os_SelectOutsolePaperMachineFromTo @SearchFrom, @SearchTo", @SearchFrom, @SearchTo).ToList();
            }
        }
        public static OutsolePaperMachineModel GetOutsolePaperMachineById(int osmachineId)
        {
            var @OutsolePaperImageId = new SqlParameter("@OutsolePaperImageId", osmachineId);
            using (var db = new SewingMachineEntities())
            {
                return db.Database.SqlQuery<OutsolePaperMachineModel>("EXEC spm_os_SelectOutsolePaperMachineById @OutsolePaperImageId", @OutsolePaperImageId).FirstOrDefault();
            }
        }

        public static bool DeleteOSMachineById(int osmachineId)
        {
            var @OutsolePaperImageId = new SqlParameter("@OutsolePaperImageId", osmachineId);
            using (var db = new SewingMachineEntities())
            {
                if (db.Database.ExecuteSqlCommand("EXEC spm_os_DeleteOutsolePaperMachineById @OutsolePaperImageId",
                                                                                             @OutsolePaperImageId) > 0)
                {
                    return true;
                }
                return false;
            }
        }

        public static bool InsertOutsoleMachineImage(OutsolePaperMachineModel model)
        {
            var @OutsolePaperImageId = new SqlParameter("@OutsolePaperImageId", model.OutsolePaperImageId);
            var @SectionName = new SqlParameter("@SectionName", model.SectionName);
            var @LineName = new SqlParameter("@LineName", model.LineName);
            var @ProductNo = new SqlParameter("@ProductNo", model.ProductNo);
            var @StyleName = new SqlParameter("@StyleName", model.StyleName);
            var @OutsoleCode = new SqlParameter("@OutsoleCode", model.OutsoleCode);
            var @MachineType = new SqlParameter("@MachineType", model.MachineType);
            var @CreatedDate = new SqlParameter("@CreatedDate", model.CreatedDate);
            var @LeftImagePath = new SqlParameter("@LeftImagePath", model.LeftImagePath != null ? model.LeftImagePath : "");
            var @RightImagePath = new SqlParameter("@RightImagePath", model.RightImagePath != null ? model.RightImagePath : "");


            using (var db = new SewingMachineEntities())
            {
                if (db.Database.ExecuteSqlCommand("EXEC spm_os_InsertOutsoleMachineImage_1  @OutsolePaperImageId, @SectionName, @LineName, @ProductNo, @StyleName, @OutsoleCode, @MachineType, @CreatedDate, @LeftImagePath, @RightImagePath",
                                                                                            @OutsolePaperImageId, @SectionName, @LineName, @ProductNo, @StyleName, @OutsoleCode, @MachineType, @CreatedDate, @LeftImagePath, @RightImagePath) > 0)
                {
                    return true;
                }
                return false;
            };
        }
    }
}