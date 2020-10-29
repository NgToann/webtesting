<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SummaryReport.aspx.cs" Inherits="WebsiteTesting.Pages.ScissorsManagment.SummaryReport" MasterPageFile="~/Main.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
    <!DOCTYPE html>
    <html>
    <head>
        <title>Scissors Managment - Summary Report Report</title>
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
                    <span class="breadcrumb__point" aria-current="page">Summary Report</span>
                </li>
                </ol>
            </nav>

            <section class="sectionHeader">
                <h1 class="text-center">SUMMARY REPORT</h1>
            </section>
            <div class="col-12 col-md-6 col-lg-6">
                <div class="row">
                    <div class="col-3 col-md-3 mt-2"><p>Section:</p></div>
                    <div class="col-9 col-md-9">
                        <asp:DropDownList ID="cboSection" CssClass="btn rounded-0 border-dark" runat="server" DataTextField="Name" DataValueField="SectionId"
                            AutoPostBack="true" OnSelectedIndexChanged="cboSection_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                </div>
            </div>

            <div class="col-row">
                <asp:Table ID="tableSummaryReport" CssClass="table table-hover table-bordered" runat="server">
                </asp:Table>
            </div>

            <div class="col-12 col-md-6 col-lg-6 border mt-3 p-3 font-weight-bold">
                <div class="row col-12"><asp:Label ID="lblTotalIssued" runat="server"></asp:Label></div>
                <div class="row col-12 mt-2"><asp:Label ID="lblTotalBroken" runat="server"></asp:Label></div>
                <div class="row col-12 mt-2"><asp:Label ID="lblTotalLoss" runat="server"></asp:Label></div>
            </div>
        </div>
        <footer class="page-footer font-small">
            <div class="footer-copyright text-center py-3">© 2020 Created by:<a runat="server" href="../../Default.aspx"> IT Saoviet</a></div>
        </footer>
    </body>
    </html>
</asp:Content>
