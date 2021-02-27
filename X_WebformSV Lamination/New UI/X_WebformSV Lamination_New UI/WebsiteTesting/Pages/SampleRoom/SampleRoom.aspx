<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SampleRoom.aspx.cs" Inherits="WebsiteTesting.Pages.SampleRoom.SampleRoom" MasterPageFile="../../Main.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
<!DOCTYPE html>
    <head>
        <title>Sample Shoes</title>
        <link href="../../assets/css/styleForPage.css" rel="Stylesheet"/>
        <meta name="viewport" content="width=device-width, initial-scale=1">
    </head>
    <html>
        <body>
            <!--Main layout-->
            <div class="container SVContent">
                <nav class="breadcrumb breadcrumb_type5" aria-label="Breadcrumb">
                    <ol class="breadcrumb__list r-list">
                        <li class="breadcrumb__group">
                            <a href="../../Default.aspx" class="breadcrumb__point r-link"><i class="fa fa-home"></i>Home</a>
                            <span class="breadcrumb__divider" aria-hidden="true">›</span>
                        </li>
                        <li class="breadcrumb__group">
                            <span class="breadcrumb__point" aria-current="page">Sample Shoes</span>
                        </li>
                    </ol>
                </nav>

                <div class="text-center">
                    <h2 class="font-weight-bold">SAMPLE SHOES</h2>
                    <br />
                </div>

                <!--Content-->
                <div class="row">
                    <div class="col-12 col-sm-5 col-md-4 col-lg-4">
                        <div class="input-group">
                            <asp:TextBox ID="txtArticle" CssClass="form-control rounded-0" runat="server" placeholder="Input ArticleNo"></asp:TextBox>
                            <div class="input-group-append">
                                <asp:Button CssClass="input-group-text btn btn-info rounded-0" ID="btnLookup" runat="server" Text="Lookup" OnClick="btnLookup_Click"/>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row mt-3">
                    <div class="col-12">
                        <asp:GridView ID="gridLookupShoes" runat="server" AutoGenerateColumns="False" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" CssClass="mydatagrid" >
                            <Columns>
                                <asp:BoundField HeaderText="WorkerID" DataField="EmployeeId"/>
                                <asp:BoundField HeaderText="Name" DataField="EmployeeName"/>
                                <asp:BoundField HeaderText="Section" DataField="EmployeeSection"/>
                                <asp:BoundField HeaderText="Line" DataField="EmployeeLine"/>
                                <asp:BoundField HeaderText="Phone Number" DataField="PhoneNumber"/>
                                <asp:BoundField HeaderText="Article No" DataField="Article" />
                                <asp:BoundField HeaderText="Shoe Name" DataField="ArticleName"/>
                                <asp:BoundField HeaderText="Quantity" DataField="Quantity"/>
                                <asp:BoundField HeaderText="Description" DataField="Description"/>
                                <asp:BoundField HeaderText="Status" DataField="Status"/>
                                <asp:BoundField HeaderText="Borrow Time" DataField="BorrowTime"/>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>

                <div class="row mt-3">
                    <div class="col-12 col-sm-5 col-md-5 col-lg-5 text-center text-sm-left" runat="server" id="divShoes" visible="false">
                        <div>
                            <asp:Image runat="server" ID="imgShoes" Visible="false" AlternateText="Shoes Image" style="width:80%"/>
                            <p class="mt-1">Shoes Image</p>
                        </div>
                    </div>
                    <div class="col-12 col-sm-5 col-md-5 col-lg-5 mt-2 mt-sm-0 text-center text-sm-left" runat="server" id="divBorrowedPerson" visible="false">
                        <div>
                            <asp:Image runat="server" ID="imgPerson" Visible="false" AlternateText="Borrowed Person" style="width:80%"/>
                            <p class="mt-1">Borrowed Person</p>
                        </div>
                    </div>
                </div>
            </div>
            <!--Footer-->
            <footer class="page-footer font-small">
                <div class="footer-copyright text-center py-3">© 2020 Created by:<a runat="server" href="../../Default.aspx"> IT Saoviet</a></div>
            </footer>
        </body>
    </html>
</asp:Content>
