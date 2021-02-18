using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

using WebsiteTesting.Controllers.ScissorsController;
using WebsiteTesting.Entities;
using WebsiteTesting.Models.ScissorsManagmentSystem;
using WebsiteTesting.Models.CheckInSystem;
using WebsiteTesting.Controllers.CheckInSystem;

namespace WebsiteTesting.Pages.ScissorsManagment
{
    public partial class ReleaseScissorsPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string SubmitReleaseScissors(ReleaseScissorsModel insertModel)
        {
            try
            {
                if (ScissorsMainController.InsertReleaseScissors(insertModel))
                    return "Successful";
                else
                    return "Reload page and try again !";
            }
            catch (Exception ex)
            {
                return String.Format("Exception: {0}", ex.InnerException.InnerException.Message.ToString());
            }
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string LoadReleaseScissors()
        {
            try
            {
                var userLogin           = HttpContext.Current.User.Identity.Name.ToString();
                var sectionList         = SectionController.Select();
                var releasedScissors    = ScissorsMainController.GetReleaseWithBorrowedStatus();
                var configSystem        = ScissorsMainController.GetConfigSystem();

                var personalList    = new List<PersonalModel>();
                var keyword1List    = new List<String>();
                var lineList        = new List<LineModel>();

                foreach (var section in sectionList)
                {
                    var kwsBySection = section.Keyword_1.Split(',').ToList();
                    foreach (var kw in kwsBySection)
                    {
                        if (keyword1List.Where(w => w.Equals(kw)).Count() > 0 && !String.IsNullOrEmpty(kw))
                            continue;
                        var personalListBySection = PersonalController.Select(kw);
                        foreach (var person in personalListBySection)
                        {
                            person.SectionId = section.SectionId;
                            person.Section = section.Name;
                            person.ReleaseBy = userLogin;
                        }
                        personalList.AddRange(personalListBySection);
                        var listOfListBySection = personalListBySection.Select(s => s.Department).Distinct().ToList();
                        foreach (var line in listOfListBySection)
                        {
                            lineList.Add(new LineModel
                            {
                                SectionId = section.SectionId,
                                LineName = line
                            });
                        }
                        keyword1List.Add(kw);
                    }
                }

                var resource = new object[] { sectionList, lineList, personalList, releasedScissors, configSystem };
                return JsonConvert.SerializeObject(resource);
            }
            catch (Exception ex)
            {
                return String.Format("Exception: {0}", ex.InnerException.InnerException.Message.ToString());
            }
        }
        public class LineModel
        {
            public string SectionId { get; set; }
            public string LineName { get; set; }
        }
    }
}