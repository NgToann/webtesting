<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OutsolePaperHome.aspx.cs" Inherits="WebsiteTesting.Pages.SewingMachines.OutsolePaperHome" MasterPageFile="~/Main.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
<!DOCTYPE html>
    <head>
        <title>Outsole Paper Pressing Database</title>
        <link href="../../assets/css/styleForPage.css" rel="Stylesheet"/>
        <meta name="viewport" content="width=device-width, initial-scale=1">
    </head>

    <script>
        function searchByStyle() {
            var input, filter, table, tr, td, i, txtValue;
            input = document.getElementById("myInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("contentPlaceHolder_tblListOfMahineImage");
            tr = table.getElementsByTagName("tr");
            for (i = 1; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[3];
                if (td) {
                    txtValue = td.textContent || td.innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }
    </script>

    <html>
        <body>
            <!--Main layout-->
            <div class="container SVContent">
                <nav class="breadcrumb breadcrumb_type5" aria-label="Breadcrumb">
                    <ol class="breadcrumb__list r-list">
                        <li class="breadcrumb__group">
                            <a href="../../Default.aspx" class="breadcrumb__point r-link"><i class="fa fa-home"></i>Home</a>
                            <span class="breadcrumb__divider" aria-hidden="true">›</span>
                        </li>
                        <li class="breadcrumb__group">
                            <span class="breadcrumb__point" aria-current="page">Outsole Paper Pressing Database</span>
                        </li>
                    </ol>
                </nav>

                <div class="text-center">
                    <h2 class="font-weight-bold">Outsole Paper Pressing Database</h2>
                </div>

                <!--Available Machine Content-->
                <!--Data Result Content-->
                <div class="row mt-3">
                    <div class="col text-left text-sm-center d-none">
                        <h5><asp:Label ID="lblTitleReport" runat="server"></asp:Label></h5>
                    </div>
                </div>
                <div class="row mt-1">
                    <div class="col">
                        <a class="btn btn-info rounded-0 mb-2" href="AddUpdateOutsoleMachineImage.aspx">Add New</a>
                    </div>
                </div>
                <div class="row">
                    <div class="col-auto">
                        <input id="myInput" onkeyup="searchByStyle()" type="text" class="form-control rounded-1 text-primary" placeholder="Search by Style Name" >
                    </div>
                </div>
                <div class="row flex-row flex-nowrap mt-1">
                    <div class="col-auto">
                        <asp:Table ID="tblListOfMahineImage" CssClass="table table-hover table-sm table-bordered" runat="server">
                        </asp:Table>
                    </div>
                </div>
            </div>

            <!--Footer-->
            <%--<footer class="page-footer font-small">
                <div class="footer-copyright text-center py-3">© 2020 Created by:<a runat="server" href="../../Default.aspx"> IT Saoviet</a></div>
            </footer>--%>
        </body>
    </html>
</asp:Content>