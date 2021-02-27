<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DailyReportDetailPage.aspx.cs" Inherits="WebsiteTesting.Pages.ScissorsManagment.DailyReportDetailPage" MasterPageFile="~/Main.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
    <!DOCTYPE html>
    <html>
    <head>
        <title>Scissors Managment - Inspection</title>
        <link href="assets/style.css" rel="Stylesheet"/>
        <link href="../../assets/css/styleForPage.css" rel="Stylesheet"/>
        <meta name="viewport" content="width=device-width, initial-scale=1">
    </head>
    <body>
        <div class="container SVContent">
            <nav class="breadcrumb breadcrumb_type5" aria-label="Breadcrumb">
                <ol class="breadcrumb__list r-list">
                    <li class="breadcrumb__group">
                        <a href="../../Default.aspx" class="breadcrumb__point r-link"><i class="fa fa-home"></i>Home</a>
                        <span class="breadcrumb__divider" aria-hidden="true">›</span>
                    </li>
                    <li class="breadcrumb__group">
                        <a href="ScissorsHome.aspx" class="breadcrumb__point r-link">Scissors Managment</a>
                        <span class="breadcrumb__divider" aria-hidden="true">›</span>
                    </li>
                    <li class="breadcrumb__group">
                        <span class="breadcrumb__point" aria-current="page">Daily Report</span>
                        <span class="breadcrumb__divider" aria-hidden="true">›</span>
                    </li>
                    <li class="breadcrumb__group">
                        <span class="breadcrumb__point" aria-current="page">Detail</span>
                    </li>
                </ol>
            </nav>
            
            <section class="sectionHeader">
                <h1>DAILY REPORT DETAIL</h1>
            </section>
            <div class="row">
                <div class="col-12">
                    <asp:Label ID="lblLine" CssClass="mb-1" runat="server">Line: </asp:Label>
                    <asp:Table ID="tableDailyReportDetail" CssClass="table table-hover table-bordered" runat="server">
                    </asp:Table>
                </div>
            </div>
        </div>
        <footer class="page-footer font-small">
            <div class="footer-copyright text-center py-3">© 2020 Created by:<a runat="server" href="../../Default.aspx"> IT Saoviet</a></div>
        </footer>
    </body>
    </html>
</asp:Content>