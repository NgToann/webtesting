<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SummaryAndInventory.aspx.cs" Inherits="WebsiteTesting.Pages.SewingMachines.SummaryAndInventory" MasterPageFile="~/Main.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
<!DOCTYPE html>
    <head>
        <title>Summary &amp; Inventory Machine</title>
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
                $('#<%=txtStart.ClientID %>').datepicker();
            });
            $(function () {
                $('#<%=txtFinish.ClientID %>').datepicker();
            });
        </script>
    </head>
    <html>
        <body>
            <!--Main layout-->
            <div class="container SVContent">
                <nav class="breadcrumb breadcrumb_type5" aria-label="Breadcrumb">
                    <ol class="breadcrumb__list r-list">
                        <li class="breadcrumb__group">
                            <a href="HomePage.aspx" class="breadcrumb__point r-link"><i class="fa fa-home"></i>Sewing Machine</a>
                            <span class="breadcrumb__divider" aria-hidden="true">›</span>
                        </li>
                        <li class="breadcrumb__group">
                            <span class="breadcrumb__point" aria-current="page">Summary &amp; Inventory</span>
                        </li>
                    </ol>
                </nav>

                <div class="text-center mb-4">
                    <h2 class="font-weight-bold">SUMMARY</h2>
                </div>

                <!--Searching Content-->
                <div class="container">
                    <div class="row">
                        <div class="input-group col-12 col-sm-4">
                            <label class="col-12 col-sm-auto col-form-label">Machine Type</label>
                            <div class="col-12 col-sm-3 col-md-3">
                            <asp:DropDownList ID="cboMachineType" CssClass="btn rounded-0 border-dark" runat="server"
                                AutoPostBack="true" OnSelectedIndexChanged="cboMachineType_SelectedIndexChanged"/>
                            </div>
                        </div>
                        <div class="input-group col-12 col-sm-4">
                            <label class="col-12 col-sm-4 col-form-label text-left text-sm-right">From</label>
                            <div class="col-12 col-sm-8">
                                <asp:TextBox ID="txtStart" CssClass="form-control rounded-0" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="input-group col-12 col-sm-4">
                            <label class="col-12 col-sm-4 col-form-label text-left text-sm-right">To</label>
                            <div class="col-12 col-sm-8">
                                <asp:TextBox ID="txtFinish" CssClass="form-control rounded-0" runat="server"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-3">
                        <div class="col d-none d-sm-block"></div>
                        <div class="col-auto col-sm-auto">
                            <div class="col">
                                <asp:Button CssClass="btn btn-info rounded-0" ID="btnLineSummary" Text="Line Summary" runat="server" OnClick="btnLineSummary_Click"/>
                            </div>
                        </div>
                        <div class="col-auto col-sm-auto">
                            <div class="col">
                                <asp:Button CssClass="btn btn-warning rounded-0" ID="btnMachineSummary" Text="Machine Summary" runat="server" OnClick="btnMachineSummary_Click"/>
                            </div>
                        </div>
                    </div>
                </div>
                <!--Data Result Content-->
                <div class="row mt-3">
                    <div class="col text-left text-sm-center d-none">
                        <h5><asp:Label ID="lblTitleReport" runat="server"></asp:Label></h5>
                    </div>
                </div>
                <div class="row flex-row flex-nowrap mt-1">
                    <div class="col-auto">
                        <asp:Table ID="tblReport" CssClass="table table-hover table-bordered" runat="server">
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
