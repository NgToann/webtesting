using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

using WebsiteTesting.Controllers.Saoviet;
using WebsiteTesting.Models.Saoviet;
namespace WebsiteTesting.Pages.Saoviet
{
    /// <summary>
    /// Summary description for SaovietWebService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class SaovietWebService : System.Web.Services.WebService
    {
        [WebMethod]
        public string Info()
        {
            return "This Is Saoviet Web Services!";
        }

        [WebMethod]
        public List<FaultModel> SelectFaultByFaultType(string faultType)
        {
            return FaultController.Select(faultType);
        }

        [WebMethod]
        public List<LineModel> SelectLine()
        {
            return LineController.Select();
        }

        [WebMethod]
        public LineModel FirstLineByLineId(string lineId)
        {
            return LineController.First(lineId);
        }

        [WebMethod]
        public List<ProductOutputModel> SelectProductOutputByLineIdDate(string lineId, DateTime date)
        {
            return ProductOutputController.Select(lineId, date);
        }

        [WebMethod]        
        public List<ProductOutputModel> SelectProductOutputByDate(DateTime date)
        {
            return ProductOutputController.Select(date);
        }
    }
}
