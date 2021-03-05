using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

using WebsiteTesting.Models.WHLamination;
using WebsiteTesting.Controllers.WHLamination;

namespace WebsiteTesting.Pages.WHLamination
{
    public partial class WHLaminationHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
                return;
            var currentUserName = Page.User.Identity.Name.ToString();
            if(!String.IsNullOrEmpty(currentUserName))
            {
                lblUser.Text = currentUserName;
                //divUser.Visible = true;
            }
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string CallTest(string orderNo)
        {
            var x = orderNo;
            return x;
        }

        // Get order Information by OrderNo
        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string GetByOrderNo(string orderNo)
        {
            try 
            {
                var laminationMatsSearch = LaminationMaterialController.GetLaminationMaterialByOrderNo(orderNo).ToList();
                var rejectWHLamination = RejectController.GetWHLaminationRejects();
                if (laminationMatsSearch.Count() == 0)
                    return "This PO does not exist in system !";
                object[] source = new object[] { laminationMatsSearch, rejectWHLamination };
                return JsonConvert.SerializeObject(source);
            }
            catch (Exception ex)
            {
                return String.Format("Exception: {0}", ex.InnerException.InnerException.Message.ToString());
            }
        }

        // Get LaminationScore by OrderNoId
        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string GetScoreByOrderNoId(string orderNoId)
        {
            try
            {
                var laMatsByOrderNoIdList = LaminationMaterialScoreController.GetLaminationMatsScoreByOrderNoId(orderNoId);
                if (laMatsByOrderNoIdList != null)
                    return JsonConvert.SerializeObject(laMatsByOrderNoIdList);
                else return "[]";
            }
            catch (Exception ex)
            {
                return String.Format("Exception: {0}", ex.InnerException.InnerException.Message.ToString());
            }
        }

        // Get LaminationScore by OrderNoId By RoundCheck
        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string GetScoreByOrderNoIdByRound(string orderNoId, string btnRoundId)
        {
            try
            {
                int roundCheck = 0;
                Int32.TryParse(btnRoundId, out roundCheck);
                var laminationMatsScore = LaminationMaterialScoreController.GetLaminationMatsScoreByOrderNoIdByRound(orderNoId, roundCheck);
                if (laminationMatsScore != null)
                    return JsonConvert.SerializeObject(laminationMatsScore);
                else return "[]";
            }
            catch (Exception ex)
            {
                return String.Format("Exception: {0}", ex.InnerException.InnerException.Message.ToString());
            }
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string SaveScore( string orderNoId, int poQuantity, int labelQuantity, int actualQuantity, int labelWidth, int actualWidth, int defectType1, int defectType2, int defectType3, int defectType4, int holeType2, int holeType4, int totalScore, string reviser, int roundCheck, int noOfDefects, string remarks)
        //public static string SaveScore(LaminationMaterialScoreModel laminationScore)
        {
            var laminationScoreSave = new LaminationMaterialScoreModel()
            {
                OrderNoId = orderNoId,
                POQuantity = poQuantity,
                LabelQuantity = labelQuantity,
                ActualQuantity = actualQuantity,
                LabelWidth = labelWidth,
                ActualWidth = actualWidth,
                DefectType1 = defectType1,
                DefectType2 = defectType2,
                DefectType3 = defectType3,
                DefectType4 = defectType4,
                HoleType2 = holeType2,
                HoleType4 = holeType4,
                TotalScore = totalScore,
                Reviser = reviser,
                RoundCheck = roundCheck,
                NoOfDefects = noOfDefects,
                Remarks = remarks
            };
            //var laminationScoreSave = laminationScore;
            try
            {
                LaminationMaterialScoreController.Insert(laminationScoreSave);
                return "Successful !";
            }
            catch (Exception ex)
            {
                return String.Format("Exception: {0}", ex.InnerException.InnerException.Message.ToString());
            }
        }
        private void ShowAlert(string msg)
        {
            string script = string.Format("alert('{0}');", msg);
            if (Page != null && !Page.ClientScript.IsClientScriptBlockRegistered("alert"))
            {
                Page.ClientScript.RegisterClientScriptBlock(Page.GetType(), "alert", script, true);
            }
        }
    }
}