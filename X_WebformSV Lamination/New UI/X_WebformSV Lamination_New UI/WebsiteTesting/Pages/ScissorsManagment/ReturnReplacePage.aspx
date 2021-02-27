<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReturnReplacePage.aspx.cs" Inherits="WebsiteTesting.Pages.ScissorsManagment.ReturnReplacePage" MasterPageFile="~/Main.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Scissors Managment - Return / Replace</title>
        <link href="assets/style.css" rel="Stylesheet"/>
        <link href="../../assets/css/styleForPage.css" rel="Stylesheet"/>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script type="text/javascript">
            function Confirm() {
                var confirm_value = document.createElement("INPUT");
                confirm_value.type = "hidden";
                confirm_value.name = "confirm_value";
                if (confirm("Confirm return the Scissors ?")) {
                    confirm_value.value = "Yes";
                } else {
                    confirm_value.value = "No";
                }
                document.forms[0].appendChild(confirm_value);
            }
        </script>
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
                    <span class="breadcrumb__point" aria-current="page">Return / Replace Scissors</span>
                </li>
                </ol>
            </nav>
            <section class="sectionHeader">
                <h1 class="text-center">RETURN / REPLACE SCISSORS</h1>
            </section>
            <div class="row">
                <div class="col-12 col-md-6">
                    <div class="row mt-3 mt-md-0 mt-md-sm-0 mt-lg-0">
                        <div class="col-3 col-md-3 mt-2"><p>ID No:</p></div>
                        <div class="col-9 col-md-9">
                            <div class="input-group">
                                <asp:TextBox ID="txtWorkerID" CssClass="form-control rounded-0" runat="server" placeholder="Worker Id"></asp:TextBox>
                                <div class="input-group-append">
                                    <asp:Button CssClass="input-group-text btn btn-primary rounded-0" ID="btnWorkerIdOK" runat="server" Text="OK" onclick="btnWorkerIdOK_Click"/>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-3 mt-md-0 mt-md-sm-0 mt-lg-0">
                        <div class="col-3 col-md-3 mt-2"><p>Name:</p></div>
                        <div class="col-9 col-md-9">
                            <asp:TextBox ID="txtWorkerName" CssClass="form-control rounded-0" runat="server" Enabled="false" placeholder="Name"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row mt-3 mt-md-0 mt-md-sm-0 mt-lg-0">
                        <div class="col-3 col-md-3 mt-2"><p>Section:</p></div>
                        <div class="col-9 col-md-9">
                            <asp:TextBox ID="txtSection" CssClass="form-control rounded-0" runat="server" Enabled="false" placeholder="Section"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row mt-3 mt-md-0 mt-md-sm-0 mt-lg-0">
                        <div class="col-3 col-md-3 mt-2"><p>Line:</p></div>
                        <div class="col-9 col-md-9">
                            <asp:TextBox ID="txtLine" CssClass="form-control rounded-0" runat="server" Enabled="false" placeholder="Line"></asp:TextBox>
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col-3 col-md-3 mt-2 font-weight-bold"><p>Big Scissors</p></div>
                        <div class="col-9 col-md-9">
                            <div class="input-group">
                                <asp:Button CssClass="input-group-text btn btn-primary btnReturn rounded-0" ID="btnReturnBigScissors" runat="server" Text="RETURN" OnClientClick="Confirm()" onclick="btnReturnBigScissors_Click"/>
                                <asp:Button CssClass="input-group-text btn btn-danger btnReplace rounded-0 ml-4" ID="btnReplaceBigScissors" runat="server" Text="REPLACE" onclick="btnReplaceBigScissors_Click"/>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-2">
                        <div class="col-3 col-md-3 mt-2 font-weight-bold"><p>Small Scissors</p></div>
                        <div class="col-9 col-md-9">
                            <div class="input-group">
                                <asp:Button CssClass="input-group-text btn btn-primary btnReturn rounded-0" ID="btnReturnSmallScissors" runat="server" Text="RETURN" OnClientClick="Confirm()" onclick="btnReturnSmallScissors_Click"/>
                                <asp:Button CssClass="input-group-text btn btn-danger btnReplace rounded-0 ml-4" ID="btnReplaceSmallScissors" runat="server" Text="REPLACE" onclick="btnReplaceSmallScissors_Click"/>
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
