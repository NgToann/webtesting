 <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SummaryDetail.aspx.cs" Inherits="WebsiteTesting.Pages.SewingMachines.SummaryDetail" MasterPageFile="~/Main.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
<!DOCTYPE html>
    <head>
        <title>Report Detail</title>
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
                            <a href="HomePage.aspx" class="breadcrumb__point r-link"><i class="fa fa-home"></i>Sewing Machine</a>
                            <span class="breadcrumb__divider" aria-hidden="true">›</span>
                        </li>
                        <li class="breadcrumb__group">
                            <a href="SummaryAndInventory.aspx" class="breadcrumb__point r-link">Summary &amp; Inventory</a>
                            <span class="breadcrumb__divider" aria-hidden="true">›</span>
                        </li>
                        <li class="breadcrumb__group">
                            <span class="breadcrumb__point" aria-current="page">Detail</span>
                        </li>
                    </ol>
                </nav>

                <div class="text-center">
                    <h4 class="font-weight-bold"><asp:Label ID="lblTitleReport" Text="SCHEDULE AT LINE 1A FROM 4/15 TO 4/25" runat="server"></asp:Label></h4>
                </div>

                <!--Data Result Content-->
                <div class="row">
                    <div class="col-12 col-sm-9 text-center">
                        <asp:Table ID="tblReportDetail" CssClass="table table-hover table-bordered" runat="server">
                        </asp:Table>
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
