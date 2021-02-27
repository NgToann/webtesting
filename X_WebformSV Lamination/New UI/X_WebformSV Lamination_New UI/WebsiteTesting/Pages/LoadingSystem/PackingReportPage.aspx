<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PackingReportPage.aspx.cs" Inherits="WebsiteTesting.Pages.LoadingSystem.PackingReportPage" MasterPageFile="../../Main.Master" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Loading | Packing Report</title>
    </head>
    <body>
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container">
            <div class="row mb-2">
                <div class="col-sm-6">
                <h3 class="m-0">Packing Report</h3>
                </div><!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><p>Loading</p></li>
                        <li class="breadcrumb-item active">Packing Report</li>
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
        </div>
        <!-- /.content -->
    </body>
</html>
</asp:Content>
