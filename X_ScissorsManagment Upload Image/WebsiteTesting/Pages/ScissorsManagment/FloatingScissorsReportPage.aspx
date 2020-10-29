<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FloatingScissorsReportPage.aspx.cs" Inherits="WebsiteTesting.Pages.ScissorsManagment.FloatingScissorsReportPage" MasterPageFile="~/Main.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
    <!DOCTYPE html>
    <html>
    <head>
        <title>Scissors Managment - Floating Scissors Report</title>
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
                    <a href="ScissorsHome.aspx" class="breadcrumb__point r-link">Report</a>
                    <span class="breadcrumb__divider" aria-hidden="true">›</span>
                </li>
                <li class="breadcrumb__group">
                    <span class="breadcrumb__point" aria-current="page">Floating Scissors Report</span>
                </li>
                </ol>
            </nav>

            <section class="sectionHeader">
                <h1 class="text-center">AVAILABLE SCISSORS IN LINE LEADER</h1>
            </section>

            <div class="col-row">
                <asp:Table ID="tableAvailableScissors" CssClass="table table-hover table-bordered" runat="server">
                </asp:Table>
            </div>
        </div>
        <footer class="page-footer font-small">
            <div class="footer-copyright text-center py-3">© 2020 Created by:<a runat="server" href="../../Default.aspx"> IT Saoviet</a></div>
        </footer>
    </body>
    </html>
</asp:Content>