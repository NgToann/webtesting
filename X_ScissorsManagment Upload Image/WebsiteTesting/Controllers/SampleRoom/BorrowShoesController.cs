using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using WebsiteTesting.Entities;
using System.Data.SqlClient;
using WebsiteTesting.Models.SampleRoom;

namespace WebsiteTesting.Controllers.SampleShoes
{
    public class BorrowShoesController
    {
        static SampleRoomEntities db = new SampleRoomEntities();
        public static List<BorrowShoesModel> Get(string article)
        {
            var @Article = new SqlParameter("@Article", article);
            var @Status = new SqlParameter("@Status", true);
            return db.ExecuteStoreQuery<BorrowShoesModel>("EXEC SelectBorrowShoesByArticleStatus_1 @Article, @Status", @Article, @Status).ToList();
        }
    }
}