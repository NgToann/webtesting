using System;
using System.Collections.Generic;
using System.Linq;
using System.Drawing;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

//using WebsiteTesting.Controllers.SampleRoom;
using WebsiteTesting.Controllers.SampleShoes;
using WebsiteTesting.Models.SampleRoom;

namespace WebsiteTesting.Pages.SampleRoom
{

    public partial class SampleRoom : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLookup_Click(object sender, EventArgs e)
        {
            List<BorrowShoesViewModel> borrowShoesViewModelList = new List<BorrowShoesViewModel>();
            List<SampleShoesModel> sampleShoesList = new List<SampleShoesModel>();
            List<BorrowShoesModel> borrowShoesList = new List<BorrowShoesModel>();

            divShoes.Visible = false;
            divBorrowedPerson.Visible = false;
            gridLookupShoes.DataSource = null;
            imgShoes.Visible = false;
            imgShoes.ImageUrl = null;
            

            imgPerson.Visible = false;
            imgPerson.ImageUrl = null;

            string article = txtArticle.Text.ToString().Trim();
            borrowShoesList = BorrowShoesController.Get(article);
            sampleShoesList = SampleShoesController.Get(article);

            if (sampleShoesList.Count != 0)
            {
                foreach (var sampleShoes in sampleShoesList )
                {
                    var borrowShoesViewModel = new BorrowShoesViewModel() 
                    {
                        EmployeeId          = "",
                        EmployeeName        = "",
                        EmployeeSection     = "",
                        EmployeeLine        = "",
                        PhoneNumber         ="",
                        Article             = sampleShoes.Article,
                        ArticleName         = sampleShoes.ArticleName,
                        Quantity            = sampleShoes.Quantity.ToString(),
                        Description         = "",
                        Status              = "Available",
                        BorrowTime          = "",
                    };
                    borrowShoesViewModelList.Add(borrowShoesViewModel);

                    // show shoes image from server
                    using (var mem = new MemoryStream())
                    {
                        //if (File.Exists(sampleShoes.ImagePath))
                        if (!String.IsNullOrEmpty(sampleShoes.ImagePath))
                        {
                            //var bitmapFromFile = new Bitmap(sampleShoes.ImagePath);
                            //bitmapFromFile.Save(mem, System.Drawing.Imaging.ImageFormat.Png);
                            imgShoes.Visible = true;
                            divShoes.Visible = true;
                            //imgShoes.ImageUrl = "data:image;base64," + Convert.ToBase64String(mem.ToArray());
                            imgShoes.ImageUrl = sampleShoes.ImagePath;
                            imgShoes.ToolTip = sampleShoes.ArticleName;
                        }
                    }

                    ////Show Image
                    //if (shoesImageList.Count() > 0)
                    //{
                    //    imgShoes.Visible = true;
                    //    imgShoes.ImageUrl = "data:image;base64," + Convert.ToBase64String(shoesImageList.FirstOrDefault().Image);
                    //    imgShoes.ToolTip = sampleShoes.ArticleName;
                    //}
                }
            }

            if (borrowShoesList.Count != 0)
            {
                borrowShoesViewModelList.Clear();
                foreach (var borrowedShoes in borrowShoesList)
                {
                    var borrowShoesViewModel = new BorrowShoesViewModel()
                    {
                        EmployeeId      = borrowedShoes.EmployeeId,
                        EmployeeName    = borrowedShoes.EmployeeName,
                        EmployeeSection = borrowedShoes.EmployeeSection,
                        EmployeeLine    = borrowedShoes.EmployeeLine,
                        PhoneNumber     = borrowedShoes.PhoneNumber,
                        Article         = borrowedShoes.Article,
                        ArticleName     = sampleShoesList.FirstOrDefault() != null ? sampleShoesList.FirstOrDefault().ArticleName: "",
                        Quantity        = borrowedShoes.Quantity.ToString(),
                        Description     = borrowedShoes.Description,
                        Status          = "Borrowed",
                        BorrowTime      = string.Format("{0:HH:mm:ss dd/MM/yyyy}", borrowedShoes.BorrowTime),
                    };
                    borrowShoesViewModelList.Add(borrowShoesViewModel);


                    // Show borrow person
                    using (var mem = new MemoryStream())
                    {
                        //if (File.Exists(borrowedShoes.EmployeeImagePath))
                        if (!String.IsNullOrEmpty(borrowedShoes.EmployeeImagePath))
                        {
                            //var bitmapFromFile = new Bitmap(borrowedShoes.EmployeeImagePath);
                            //bitmapFromFile.Save(mem, System.Drawing.Imaging.ImageFormat.Png);
                            imgPerson.Visible = true;
                            divBorrowedPerson.Visible = true;
                            //imgPerson.ImageUrl = "data:image;base64," + Convert.ToBase64String(mem.ToArray());
                            imgPerson.ImageUrl = borrowedShoes.EmployeeImagePath;
                            imgPerson.ToolTip = borrowedShoes.EmployeeName;
                        }
                    }
                }
            }

            gridLookupShoes.DataSource = borrowShoesViewModelList;
            gridLookupShoes.DataBind();
        }
    }

    class BorrowShoesViewModel
    {
        public string EmployeeId { get; set; }
        public string EmployeeName { get; set; }
        public string EmployeeSection { get; set; }
        public string EmployeeLine { get; set; }
        public string PhoneNumber { get; set; }
        public string Article { get; set; }
        public string ArticleName { get; set; }
        public string Quantity { get; set; }
        public string Description { get; set; }
        public string Status { get; set; }
        public string BorrowTime { get; set; }
        public string ImagePath { get; set; }
        public byte[] Image { get; set; }
    }
}