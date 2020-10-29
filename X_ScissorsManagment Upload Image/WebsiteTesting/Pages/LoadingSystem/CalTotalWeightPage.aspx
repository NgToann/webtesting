<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CalTotalWeightPage.aspx.cs" Inherits="WebsiteTesting.Pages.LoadingSystem.CalTotalWeightPage" MasterPageFile="../../Main.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
    <!DOCTYPE html>
    <head>
        <link href="../../assets/css/styleForPage.css" rel="Stylesheet"/>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Cal Total Weight</title>
    </head>
    <html>
        <body>
            <div class="container SVContent">
                <nav class="breadcrumb breadcrumb_type5" aria-label="Breadcrumb">
                    <ol class="breadcrumb__list r-list">
                        <li class="breadcrumb__group">
                            <a href="../../Default.aspx" class="breadcrumb__point r-link"><i class="fa fa-home"></i>Home</a>
                            <span class="breadcrumb__divider" aria-hidden="true">›</span>
                        </li>
                        <li class="breadcrumb__group">
                            <span class="breadcrumb__point" aria-current="page">Cal Total Weight</span>
                        </li>
                    </ol>
                </nav>

                <div class="text-center">
                    <h2 class="font-weight-bold">LOADING SYSTEM</h2>
                    <br />
                </div>
                
                <div class="row">
                    <div class="col-12 col-md-6 col-lg-6">
                        <div class="row">
                            <div class="col-12 col-sm-auto col-md-auto col-lg-auto mt-2"><p>PO List:</p></div>
                            <div class="col-12 col-md-8">
                                <div class="input-group">
                                    <asp:TextBox ID="txtProductNo" CssClass="form-control rounded-0" runat="server" placeholder="000-0000"></asp:TextBox>
                                    <div class="input-group-append">
                                        <asp:Button CssClass="btn btn-primary rounded-0" ID="btnPreview" runat="server" Text="Cal" onclick="btnCal_Click"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-12">
                        <asp:GridView ID="gridViewMain" runat="server" AutoGenerateColumns="False" CssClass="mydatagrid" HeaderStyle-CssClass="header" RowStyle-CssClass="rows">
                            <Columns>
                                <asp:BoundField HeaderText="Production No." DataField="ProductNo" />
                                <asp:BoundField HeaderText="Number Of Carton" DataField="NumberOfCarton" />
                                <asp:BoundField DataField="NumberOfPassed" HeaderText="Number Of Passed" />
                                <asp:BoundField HeaderText="Total Weight(kg)" DataField="TotalWeight" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
                <br />
                <div class="row mt-3">
                    <div class="col-12">
                        <asp:Label runat="server" Text="Total Weight:"></asp:Label>
                        <asp:Label ID="lblTotalWeight" runat="server" CssClass="mr-2 ml-2" Font-Bold="true">0</asp:Label>
                        <asp:Label runat="server" Text=" kg"></asp:Label>
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