<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PackingReportPage.aspx.cs" Inherits="WebsiteTesting.Pages.LoadingSystem.PackingReportPage" MasterPageFile="../../Main.Master" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
    <!DOCTYPE html>
    <head>
        <link href="../../assets/css/styleForPage.css" rel="Stylesheet"/>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Packing Report</title>
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
                            <span class="breadcrumb__point" aria-current="page">Packing Report</span>
                        </li>
                    </ol>
                </nav>

                <div class="text-center">
                    <h2 class="font-weight-bold">LOADING SYSTEM</h2>
                    <br />
                </div>
                <div class="row mt-2">
                    <div class="col-12 col-md-6 col-lg-6">
                        <div class="row">
                            <div class="col-12 col-sm-auto col-md-auto col-lg-auto mt-2"><p>Production No.:</p></div>
                            <div class="col-12 col-md-8">
                                <div class="input-group">
                                    <asp:TextBox ID="txtProductNo" CssClass="form-control rounded-0" runat="server" placeholder="000-0000"></asp:TextBox>
                                    <div class="input-group-append">
                                        <asp:Button CssClass="btn btn-primary rounded-0" ID="btnPreview" runat="server" Text="Preview" onclick="btnPreview_Click" ToolTip="Preview Packing Report"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-12">
                        <asp:ScriptManager runat="server"></asp:ScriptManager>
                        <rsweb:reportviewer id="reportViewer" runat="server" showfindcontrols="False" width="100%"></rsweb:reportviewer>
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
