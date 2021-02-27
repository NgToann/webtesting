using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using WebsiteTesting.Entities;
using System.Data.SqlClient;
using WebsiteTesting.Models.SampleRoom;

namespace WebsiteTesting.Controllers.SampleShoes
{
    public class SampleShoesController
    {
        static SampleRoomEntities db = new SampleRoomEntities();
        public static List<SampleShoesModel> Get(string article)
        {
            var @Article = new SqlParameter("@Article", article);
            return db.ExecuteStoreQuery<SampleShoesModel>("SelectSampleShoesByArticle_1 @Article", @Article).ToList();
        }
    }
}