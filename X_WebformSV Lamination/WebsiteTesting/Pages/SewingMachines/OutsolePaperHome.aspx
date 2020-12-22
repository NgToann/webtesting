<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OutsolePaperHome.aspx.cs" Inherits="WebsiteTesting.Pages.SewingMachines.OutsolePaperHome" MasterPageFile="~/Main.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
<!DOCTYPE html>
    <head>
        <title>Outsole Paper Pressing Database</title>
        <link href="../../assets/css/styleForPage.css" rel="Stylesheet"/>
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="stylesheet" href="assets/jquery-ui.css">
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="assets/jquery-1-12.4.js"></script>
        <script src="assets/jquery-ui.js"></script>
        <script src="//code.jquery.com/jquery-1.12.4.js"></script>
        <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

        <%--<script type="text/javascript" language="javascript">
            $(function () {
                $('#<%=txtStart.ClientID %>').datepicker();
            });
            $(function () {
                $('#<%=txtFinish.ClientID %>').datepicker();
            });
        </script>--%>

        <style type="text/css">  
            /* Flipping the video as it was not mirror view */  
            video {  
                -webkit-transform: scaleX(-1);  
                transform: scaleX(-1);  
                margin-top: 5px;  
            }  
  
            /* Flipping the canvas image as it was not mirror view */  
            #canvas {  
                -moz-transform: scaleX(-1);  
                -o-transform: scaleX(-1);  
                -webkit-transform: scaleX(-1);  
                transform: scaleX(-1);  
                filter: FlipH;  
                -ms-filter: "FlipH";  
            }  
        </style>
    </head>
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
                <div class="row flex-row flex-nowrap mt-1">
                    <div class="col-auto">
                        <%--<asp:Button CssClass="btn btn-info rounded-0 mb-2" ID="btnLineSummary" Text="Add New" runat="server"/>--%>
                        <a class="btn btn-info rounded-0 mb-2" href="AddUpdateOutsoleMachineImage.aspx">Add New</a>
                        <asp:Table ID="tblListOfMahineImage" CssClass="table table-hover table-bordered" runat="server">
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