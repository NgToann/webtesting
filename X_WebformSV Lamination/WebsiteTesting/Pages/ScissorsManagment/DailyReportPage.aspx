<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DailyReportPage.aspx.cs" Inherits="WebsiteTesting.Pages.ScissorsManagment.DailyReportPage" MasterPageFile="~/Main.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
    <!DOCTYPE html>
    <html>
    <head>
        <title>Scissors Managment - Daily Report</title>
        <link href="assets/style.css" rel="Stylesheet"/>
        <link href="../../assets/css/styleForPage.css" rel="Stylesheet"/>
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="stylesheet" href="assets/jquery-ui.css">
        <script src="assets/jquery-1-12.4.js"></script>
        <script src="assets/jquery-ui.js"></script>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="//code.jquery.com/jquery-1.12.4.js"></script>
        <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

        <script type="text/javascript" language="javascript">
            $(function () {
                $('#<%=txtDatePicker.ClientID %>').datepicker();
            });
        </script>
        <style>
            /*.ui-datepicker-next {
                background: red !important;
            }*/
        </style>
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
                    <span class="breadcrumb__point" aria-current="page">Daily Report</span>
                </li>
                </ol>
            </nav>
            <section class="sectionHeader">
                <h1 class="text-center">DAILY REPORT</h1>
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
                <div class="row mt-2 mt-md-0 mt-md-sm-0 mt-lg-0">
                    <div class="col-12 mt-1 input-group">
                        <asp:TextBox ID="txtDatePicker" CssClass="form-control rounded-0" runat="server" placeholder="Select a Date"></asp:TextBox>
                        <div class="input-group-append">
                            <asp:Button CssClass="btn btn-primary rounded-0" ID="btnPreview" runat="server" Text="Preview" onclick="btnPreview_Click"/>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-12 mt-3">
                <asp:Table ID="tableDailyReport" CssClass="table table-hover table-bordered" runat="server">
                </asp:Table>
            </div>

        </div>
        <footer class="page-footer font-small">
            <div class="footer-copyright text-center py-3">© 2020 Created by:<a runat="server" href="../../Default.aspx"> IT Saoviet</a></div>
        </footer>
    </body>
    </html>
</asp:Content>