<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ScissorsHome.aspx.cs" Inherits="WebsiteTesting.Pages.ScissorsManagment.ScissorsHome" MasterPageFile="~/Main.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
    <!DOCTYPE html>
    <html>
        <head>
            <title>Scissors Managment</title>
        </head>
        <body>
            <!-- Content Header (Page header) -->
            <div class="content-header">
                <div class="container">
                <div class="row mb-2">
                    <div class="col-sm-6">
                    <h3 class="m-0">Scissors Managment</h3>
                    </div><!-- /.col -->
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="ScissorsHome.aspx">Home</a></li>
                        </ol>
                    </div><!-- /.col -->
                </div><!-- /.row -->
                </div><!-- /.container-fluid -->
            </div>
            <!-- /.content-header -->
            <!-- Main content -->
            <div class="content">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6 mt-3">
                            <div class="card-body border shadow-sm bg-white rounded-lg">
                                <a><asp:HyperLink runat="server" CssClass="btn btn-danger rounded-0" NavigateUrl="~/Pages/ScissorsManagment/ReleaseScissorsPage.aspx">ISSUANCE</asp:HyperLink></a>
                            </div>
                        </div>
                        <div class="col-md-6 mt-3">
                            <div class="card-body border shadow-sm">
                                <%--<asp:HyperLink runat="server" CssClass="btn btn-primary rounded-0" NavigateUrl="~/Pages/ScissorsManagment/ReturnReplacePage.aspx">RETURN / REPLACE</asp:HyperLink>--%>
                                <asp:HyperLink runat="server" CssClass="btn btn-primary rounded-0" NavigateUrl="~/Pages/ScissorsManagment/ReturnReplaceScissorsPage.aspx">RETURN / REPLACE</asp:HyperLink>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-3">
                        <div class="col-md-6 mt-3">
                            <div class="card-body border shadow-sm">
                                <asp:HyperLink runat="server" CssClass="btn btn-success rounded-0" NavigateUrl="~/Pages/ScissorsManagment/InspectionPage.aspx">INSPECTION</asp:HyperLink>
                            </div>
                        </div>
                        <div class="col-md-6 mt-3">
                            <div class="card-body border shadow-sm">
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
            </div>
        </body>
    </html>
</asp:Content>


