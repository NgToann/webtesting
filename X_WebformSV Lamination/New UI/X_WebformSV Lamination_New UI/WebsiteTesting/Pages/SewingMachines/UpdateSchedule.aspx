<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdateSchedule.aspx.cs" Inherits="WebsiteTesting.Pages.SewingMachines.UpdateSchedule" MasterPageFile="~/Main.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
<!DOCTYPE html>
    <head>
        <title>Update machine schedule</title>
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
            function buttonUpdateClick() {
                var style           = $('#<%=txtStyleName.ClientID %>').val();
                var pm              = $('#<%=txtPM.ClientID %>').val();
                var lineName        = $('#<%=txtLine.ClientID %>').val();
                var fromDateString  = $('#<%=txtStart.ClientID %>').val();
                var toDateString    = $('#<%=txtFinish.ClientID %>').val();

                var confirmUpdate = confirm('Confirm Update Schedule ?');
                if (confirmUpdate == true) {
                    PageMethods.UpdateScheduleMethod(style, pm, lineName, fromDateString, toDateString, onSuccess, onError);

                    function onSuccess(result) {
                        if (result == 'Session timeout, Please login again !') {
                            alert(result);
                            window.location.href = '../LoginPage.aspx';
                        }
                        else if (result.includes('Sucessful')) {
                            var par = result.split('[');
                            alert(par[0]);
                            if (result.includes('BckRp'))
                                window.location.href = 'SummaryDetail.aspx?par=' + par[1] + '[' + par[2];
                            else
                                window.location.href = 'Allocation.aspx?rlp=' + par[2];
                        }
                        else
                            alert(result);
                    }
                    function onError(result) {
                        alert('An error occurred !');
                    }
                }
                else {
                    return;
                }
            }

            function buttonDeleteClick() {
                var confirmDelete = confirm('Confirm Delete Schedule ?');
                if (confirmDelete == true) {
                    PageMethods.DeleteSchedule(onSuccess, onError);
                    function onSuccess(result) {
                        if (result == 'Session timeout, Please login again !') {
                            alert(result);
                            window.location.href = '../LoginPage.aspx';
                        }
                        else if (result.includes('Sucessful')) {
                            var par = result.split('[');
                            alert(par[0]);
                            if (result.includes('BckRp'))
                                window.location.href = 'SummaryDetail.aspx?par=' + par[1] + '[' + par[2];
                            else
                                window.location.href = 'Allocation.aspx?rlp=' + par[2];
                        }
                        else
                            alert(result);
                    }
                    function onError(result) {
                        alert('An error occurred !');
                    }
                }
                else {
                    return;
                }
            }

            function TestJsonClick() {
                var style           = $('#<%=txtStyleName.ClientID %>').val();
                var pm              = $('#<%=txtPM.ClientID %>').val();
                var lineName        = $('#<%=txtLine.ClientID %>').val();

                var obj = {
                    Style: style,
                    PM: pm,
                    LineName: lineName
                };
                var myData = JSON.stringify(obj);

                var options = {
                    url: 'UpdateSchedule.aspx/GetSchedule',
                    type: 'POST',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    data: "{obj:" + myData + "}",
                    success: function (result) {
                        var dataReceived = JSON.parse(result.d);
                        alert('LineName: ' + dataReceived.LineName + 'PM:' + dataReceived.PM + 'Style: ' + dataReceived.Style);
                    },
                    error: function () {
                        alert('Error');
                    },
                    failure: function () {
                        alert('Failure');
                    }
                };
                $.ajax(options);
            }
        </script>
    </head>
    <html>
        <body>
            <asp:ScriptManager ID="scriptManagerUpdateSchedule" runat="server" EnablePageMethods="true" />
            <!--Main layout-->
            <div class="container SVContent">
                <nav class="breadcrumb breadcrumb_type5" aria-label="Breadcrumb">
                    <ol class="breadcrumb__list r-list">
                        <li class="breadcrumb__group">
                            <a href="HomePage.aspx" class="breadcrumb__point r-link"><i class="fa fa-home"></i>Sewing Machine</a>
                            <span class="breadcrumb__divider" aria-hidden="true">›</span>
                        </li>
                        <li class="breadcrumb__group">
                            <a href="Allocation.aspx" class="breadcrumb__point r-link">Allocation</a>
                            <span class="breadcrumb__divider" aria-hidden="true">›</span>
                        </li>
                        <li class="breadcrumb__group">
                            <span class="breadcrumb__point" aria-current="page">Update Schedule</span>
                        </li>
                    </ol>
                </nav>

                <div class="text-center">
                    <h2 class="font-weight-bold">SCHEDULE DETAIL</h2>
                </div>
                
                <!--Schedule Information-->
                <div class="container">
                    <div class="row">
                        <div class="col-12 d-none col-sm-2 col-md-2 col-lg-3 d-sm-block d-md-block d-lg-block"></div>

                        <div class="col-12 col-sm-8 col-md-8 col-lg-6 border alert rounded-0 sewingMachineDatabase">
                            <div class="form-group row">
                                <div class="col-12">
                                    <div class="input-group">
                                        <label class="col-12 col-sm-3 col-form-label">Machine</label>
                                        <div class="col-12 col-sm-9">
                                            <asp:TextBox ID="txtMachineName" Enabled="false" CssClass="form-control rounded-0" runat="server"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-12">
                                    <div class="input-group">
                                        <label class="col-12 col-sm-3 col-form-label">Style</label>
                                        <div class="col-12 col-sm-9">
                                            <asp:TextBox ID="txtStyleName" CssClass="form-control rounded-0" runat="server"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-12">
                                    <div class="input-group">
                                        <label class="col-12 col-sm-3 col-form-label">Line</label>
                                        <div class="col-12 col-sm-9">
                                            <asp:TextBox ID="txtLine" CssClass="form-control rounded-0" runat="server"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-12">
                                    <div class="input-group">
                                        <label class="col-12 col-sm-3 col-form-label">PM</label>
                                        <div class="col-12 col-sm-9">
                                            <asp:TextBox ID="txtPM" CssClass="form-control rounded-0" runat="server"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-12">
                                    <div class="input-group">
                                        <label class="col-12 col-sm-3 col-form-label">Start</label>
                                        <div class="col-12 col-sm-9">
                                            <asp:TextBox ID="txtStart"  CssClass="form-control rounded-0" runat="server"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-12">
                                    <div class="input-group">
                                        <label class="col-12 col-sm-3 col-form-label">Finish</label>
                                        <div class="col-12 col-sm-9">
                                            <asp:TextBox ID="txtFinish" CssClass="form-control rounded-0" runat="server"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>                            
                            <div class="row mt-2">
                                <div class="col-auto text-center text-sm-left">
                                    <%--<asp:Button CssClass="btn btn-info rounded-0" ID="btnUpdate" Text="Update" runat="server" OnClientClick="buttonUpdateClick"/>--%>
                                    <input type="button" class="btn btn-info rounded-0" value="Update" onclick="buttonUpdateClick()"/>
                                </div>
                                <div class="col-auto text-center text-sm-left">
                                    <%--<asp:Button CssClass="btn btn-warning rounded-0" ID="btnDelete" Text="Delete" runat="server" OnClientClick="ConfirmDelete()"/>--%>
                                    <input type="button" class="btn btn-warning rounded-0" value="Delete" onclick="buttonDeleteClick()" />
                                </div>
                                <%--<div class="col-auto text-center text-sm-left">
                                    <input type="button" class="btn btn-primary rounded-0" value="Test Json" onclick="TestJsonClick()" />
                                </div>--%>
                            </div>
                        </div>

                        <div class="col-12 d-none col-sm-2 col-md-2 col-lg-3 d-sm-block d-md-block d-lg-block"></div>
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

