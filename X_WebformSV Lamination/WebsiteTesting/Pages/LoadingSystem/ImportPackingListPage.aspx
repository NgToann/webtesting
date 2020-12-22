<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ImportPackingListPage.aspx.cs" Inherits="WebsiteTesting.Pages.LoadingSystem.ImportPackingListPage" MasterPageFile="../../Main.Master" %>
<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
    <!DOCTYPE html>
    <head>
        <link href="../../assets/css/styleForPage.css" rel="Stylesheet"/>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Import Carton Numbering</title>
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
                            <span class="breadcrumb__point" aria-current="page">Import Packing List</span>
                        </li>
                    </ol>
                </nav>
                <div class="text-center">
                    <h2 class="font-weight-bold">LOADING SYSTEM</h2>
                    <br />
                </div>
                <div class="row">
                    <div class="col-12">
                        <asp:FileUpload ID="fileUpload" runat="server" />
                        <br />
                        <asp:Button ID="btnRead" runat="server" Text="Upload & Read" OnClick="btnRead_Click" />
                        <br />
                        <asp:Label runat="server" Text="Clear Old Packing List?"></asp:Label>
                        <asp:RadioButton ID="rbtnClear" runat="server" Text="Yes" GroupName="OldPackingList"
                            ForeColor="Red" />
                        <asp:RadioButton ID="rbtnKeep" runat="server" Text="No" GroupName="OldPackingList"
                            ForeColor="Green" Checked="true" />
                        <br />
                        <asp:Button ID="btnImport" runat="server" Text="Import" OnClick="btnImport_Click"
                            Font-Bold="true" Enabled="false" />
                        <br />
                        <asp:Label ID="lblStatus" runat="server" Text="..."></asp:Label>
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
