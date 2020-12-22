<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Allocation.aspx.cs" Inherits="WebsiteTesting.Pages.SewingMachines.Allocation" MasterPageFile="~/Main.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
<!DOCTYPE html>
    <head>
        <title>Allocate machines to the Line</title>
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
        <script type="text/javascript">
            function ButtonClick(buttonId) {
                var style           = $('#<%=txtStyleName.ClientID %>').val();
                var pm              = $('#<%=txtPM.ClientID %>').val();
                var lineName        = $('#<%=txtLine.ClientID %>').val();
                var fromDateString  = $('#<%=txtStart.ClientID %>').val();
                var toDateString    = $('#<%=txtFinish.ClientID %>').val();
                var buttonContent = $('#contentPlaceHolder_' + buttonId).val();

                var confirmAllowcate = confirm('Confirm allocate machine ' + buttonContent + ' ?');
                if (confirmAllowcate == true) {
                    PageMethods.CreateSchedule(buttonId, style, pm, lineName, fromDateString, toDateString, onSuccess, onError);

                    function onSuccess(result) {
                        alert(result);
                        if (result == 'Session timeout, Please login again !')
                            window.location.href = '../LoginPage.aspx';

                        if (result == 'Successful')
                            document.getElementById('contentPlaceHolder_' + buttonId).setAttribute("class", "btn btn-warning rounded-0 m-1");
                    }
                    function onError(result) {
                        alert('An error occurred !');
                    }
                }
                else {
                    return;
                }
            }
            function ButtonNotAvailableNowClick(buttonId) {
                PageMethods.ViewDetailScheduleById(buttonId, onSuccess, onError);
                function onSuccess(result) {
                    if (result == 'Session timeout, Please login again !') {
                        alert(result);
                        window.location.href = '../LoginPage.aspx';
                    }
                    else {
                        window.location.href = 'UpdateSchedule.aspx?par=' + result;
                    }
                    
                }
                function onError(result) {
                    alert('An error occurred !');
                }
            }
        </script>
    </head>
    <html>
        <body>
            <asp:ScriptManager ID="scriptManagerT" runat="server" EnablePageMethods="true" />
            <!--Main layout-->
            <div class="container SVContent">
                <nav class="breadcrumb breadcrumb_type5" aria-label="Breadcrumb">
                    <ol class="breadcrumb__list r-list">
                        <li class="breadcrumb__group">
                            <a href="HomePage.aspx" class="breadcrumb__point r-link"><i class="fa fa-home"></i>Sewing Machine</a>
                            <span class="breadcrumb__divider" aria-hidden="true">›</span>
                        </li>
                        <li class="breadcrumb__group">
                            <span class="breadcrumb__point" aria-current="page">Allocation</span>
                        </li>
                    </ol>
                </nav>

                <div class="text-center">
                    <h2 class="font-weight-bold">ALLOCATION</h2>
                </div>
                
                <!--Searching Information-->
                <div class="container border alert rounded-0 sewingMachineDatabase">
                    <div class="form-group row mt-3">
                        <div class="col-12 col-sm-3 col-md-3 col-lg-3">
                            <div class="input-group">
                                <label class="col-sm-4 col-form-label">PM</label>
                                <div class="col-sm-8">
                                    <asp:TextBox ID="txtPM" CssClass="form-control rounded-0" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-sm-3 col-md-3 col-lg-3">
                            <div class="input-group">
                                <label class="col-sm-4 col-form-label">Line</label>
                                <div class="col-sm-8">
                                    <asp:TextBox ID="txtLine" CssClass="form-control rounded-0" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-sm-6 col-md-6 col-lg-6">
                            <div class="input-group">
                                <label class="col-sm-2 col-form-label">Style</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="txtStyleName" CssClass="form-control rounded-0" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row mt-1">
                        <div class="col-12 col-sm-6 col-md-3 col-lg-3">
                            <div class="input-group">
                                <label class="col-sm-4 col-form-label">Start</label>
                                <div class="col-sm-8">
                                    <asp:TextBox ID="txtStart"  CssClass="form-control rounded-0" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-sm-6 col-md-3 col-lg-3">
                            <div class="input-group">
                                <label class="col-sm-4 col-form-label">Finish</label>
                                <div class="col-sm-8">
                                    <asp:TextBox ID="txtFinish" CssClass="form-control rounded-0" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-sm-3 col-md-3 col-lg-3 d-none d-sm-none d-md-block"></div>
                        <div class="col-12 col-sm-3 col-md-3 col-lg-3">
                            <div class="input-group">
                                <div class="col-12 text-left text-sm-right text-md-right text-lg-right mt-2 mt-sm-2 mt-md-0 mt-lg-0">
                                    <asp:Button CssClass="btn btn-danger rounded-0" ID="btnRefresh" Text="Search" runat="server" onclick="btnRefresh_Click"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!--Available Machine Content-->
                <div class="container border mt-2">
                    <div class="row p-2" runat="server" id="divMachineAvailable">
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

