<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ScissorsHome.aspx.cs" Inherits="WebsiteTesting.Pages.ScissorsManagment.ScissorsHome" MasterPageFile="~/Main.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
    <!DOCTYPE html>
    <html>
        <head>
            <title>Scissors Managment Home</title>
            <link href="assets/style.css" rel="Stylesheet"/>
            <link href="../../assets/css/styleForPage.css" rel="Stylesheet"/>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <style>
                body {background-color: #fff;}
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
                        <span class="breadcrumb__point" aria-current="page">Scissors Managment</span>
                    </li>
                    </ol>
                </nav>

                <section class="sectionHeader">
                    <h1>SCISSORS MANAGMENT</h1>
                </section>

                <div class="row mt-3">
                    <div class="col-md-6 mt-3">
                        <div class="card-body border rounded-0">
                            <%--<a><asp:HyperLink runat="server" CssClass="btn btn-danger rounded-0" NavigateUrl="~/Pages/ScissorsManagment/IssuancePage.aspx">ISSUANCE</asp:HyperLink></a>--%>
                            <a><asp:HyperLink runat="server" CssClass="btn btn-danger rounded-0" NavigateUrl="~/Pages/ScissorsManagment/ReleaseScissorsPage.aspx">ISSUANCE</asp:HyperLink></a>
                        </div>
                    </div>
                    <div class="col-md-6 mt-3">
                        <div class="card-body border rounded-0">
                            <asp:HyperLink runat="server" CssClass="btn btn-primary rounded-0" NavigateUrl="~/Pages/ScissorsManagment/ReturnReplacePage.aspx">RETURN / REPLACE</asp:HyperLink>
                        </div>
                    </div>
                </div>

                <div class="row mt-3">
                    <div class="col-md-6 mt-3">
                        <div class="card-body border rounded-0">
                            <asp:HyperLink runat="server" CssClass="btn btn-success rounded-0" NavigateUrl="~/Pages/ScissorsManagment/InspectionPage.aspx">INSPECTION</asp:HyperLink>
                        </div>
                    </div>
                    <div class="col-md-6 mt-3">
                        <div class="card-body border rounded-0 p-2">
                            <div class="input-group">
                                <a class="btn btn-info rounded-0" href="#">REPORT</a>
                                <div class="input-group-append ml-1 ml-md-2 ml-lg-2 mt-1">
                                    <a class="btn btn-warning rounded-0" href="DailyReportPage.aspx">1. Daily Report</a>
                                </div>
                                <div class="input-group-append ml-1 ml-md-2 ml-lg-2 mt-1">
                                    <a class="btn btn-warning rounded-0" href="FloatingScissorsReportPage.aspx">2. Floating Scissors</a>
                                </div>
                                <div class="input-group-append ml-1 ml-md-2 ml-lg-2 mt-1">
                                    <a class="btn btn-warning rounded-0" href="SummaryReport.aspx">3. Summary Report</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
            </div>
            <footer class="page-footer font-small">
                <div class="footer-copyright text-center py-3">© 2020 Created by:<a runat="server" href="../../Default.aspx"> IT Saoviet</a></div>
            </footer>
        </body>
    </html>
</asp:Content>


