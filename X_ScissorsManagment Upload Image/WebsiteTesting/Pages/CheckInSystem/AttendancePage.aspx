<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AttendancePage.aspx.cs"  MasterPageFile="~/Main.Master" Inherits="WebsiteTesting.Pages.CheckInSystem.AttendancePage"%>
<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
    <!DOCTYPE html>
    <head>
        <link href="../../assets/css/styleForPage.css" rel="Stylesheet"/>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Attendance</title>
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
                            <span class="breadcrumb__point" aria-current="page">Attendance</span>
                        </li>
                    </ol>
                </nav>
                <div class="text-center">
                    <h2 class="font-weight-bold">CHECKIN</h2>
                    <br />
                </div>
                <div class="row">
                    <div class="col-12">
                        <table>
                            <tr>
                            <td><asp:Label ID="Label1" runat="server" Text="Section:"></asp:Label> </td>
                            <td><asp:DropDownList ID="cboSection" runat="server" DataTextField="Name" DataValueField="SectionId"
                            AutoPostBack="true" onselectedindexchanged="cboSection_SelectedIndexChanged">
                            </asp:DropDownList></td>
                            </tr>
                            <tr>
                            <td><asp:Label runat="server" Text="Line:"></asp:Label> </td>
                            <td><asp:DropDownList ID="cboLine" runat="server">
                            </asp:DropDownList></td>
                            </tr>
                        </table>    
                        <asp:Button ID="btnView" runat="server" Text="View" Font-Bold="true" onclick="btnView_Click"/>    
                        <br />
                        <asp:Table ID="tableAttendance" runat="server" GridLines="Both">
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

