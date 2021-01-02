<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="WebsiteTesting.Pages.WHLamination.Report" MasterPageFile="~/Main.Master"%>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>WHLamination Report</title>
        
        <%--<link rel="stylesheet" href="assets/jquery-ui.css">
        <script src="assets/jquery-1-12.4.js"></script>
        <script src="assets/jquery-ui.js"></script>--%>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="//code.jquery.com/jquery-1.12.4.js"></script>
        <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    </head>
    <script type="text/javascript" language="javascript">
        $(function () {
            $('#<%=txtStart.ClientID %>').datepicker();
        });
        $(function () {
            $('#<%=txtFinish.ClientID %>').datepicker();
        });
    </script>
    <body>
        <div class="container-fluid">
            <div class="card rounded-0 mt-1" style="min-height:98vh;">
                <div class="card-header text-primary">
                    <div class="row">
                        <div class="col">
                            WH Lamination Report
                        </div>
                        <div class="col-auto float-right">
                            <ol class="breadcrumb bg-transparent">
                            <li class="breadcrumb-item"><a href="WHLaminationHome.aspx">Scan Material</a></li>
                            <li class="breadcrumb-item"><a class="text-danger" href="../LoginPage.aspx">Logout !</a>
                            </ol>
                        </div>
                    </div>
                </div>
                <div class="card-body h-100">
                    <div class="row align-items-center mb-1 small">
                        <div class="col-auto"><asp:TextBox ID="txtStart" CssClass="form-control p-0 pl-1 rounded-0" runat="server"></asp:TextBox></div>
                        <div class="col-auto p-0">To</div>
                        <div class="col-auto"><asp:TextBox ID="txtFinish" CssClass="form-control p-0 pl-1 rounded-0" runat="server"></asp:TextBox></div>
                        <div class="col-auto"><asp:Button ID="btnPreview" CssClass="btn btn-info btn-sm rounded-0" runat="server" OnClick="btnPreview_Click" Text="Preview"></asp:Button></div>
                    </div>
                    <asp:ScriptManager runat="server"></asp:ScriptManager>
                    <rsweb:reportviewer id="reportViewer" runat="server" showfindcontrols="true" width="100%"></rsweb:reportviewer>
                </div>
            </div>
        </div>
    </body>
    </html>
</asp:Content>
