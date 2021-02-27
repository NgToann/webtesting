<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CalTotalWeightPage.aspx.cs" Inherits="WebsiteTesting.Pages.LoadingSystem.CalTotalWeightPage" MasterPageFile="../../Main.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
    <!DOCTYPE html>
    <head>
        <title>Loading | Cal Total Weight</title>
    </head>
    <html>
        <body>
         <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container">
            <div class="row mb-2">
                <div class="col-sm-6">
                <h3 class="m-0">Cal Total Weight</h3>
                </div><!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><p>Loading</p></li>
                        <li class="breadcrumb-item active">Cal total weight</li>
                    </ol>
                </div><!-- /.col -->
            </div><!-- /.row -->
            </div>
        </div>

        <!-- Main content -->
        <div class="content">
            <div class="container">
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
        </div>
        </body>
    </html>
</asp:Content>