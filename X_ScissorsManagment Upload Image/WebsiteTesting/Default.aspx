<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebsiteTesting.Default"
    MasterPageFile="Main.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
    <html>        
    <body>
        <div class="container-fluid thHeader sticky-top">
            <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="row">
                        <div class="col-12 text-right mt-1">
                            <ul class="list-unstyled">
                                <%--<asp:HyperLink runat="server" NavigateUrl="~/Default.aspx">Home</asp:HyperLink>--%>
                                <a href=""><i class="fa fa-user-circle"></i></a>
                                <asp:Label ID="lblWelcome" runat="server" Text="Hi, <b>Administrator</b>."></asp:Label>
                                <asp:LoginStatus ID="loginStatus" runat="server" LogoutText="Logout!"/>
                            </ul>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <div class="content">
                                <ul class="exo-menu">
                                    <li>
                                        <a class="toggle-menu d-block d-xl-none d-lg-none d-md-none" href="#">
                                            <i class="fa fa-bars"></i>MENU</a></li>
                                        </a>
                                    </li>
                                    <li><a href="Default.aspx"><i class="fa fa-home"></i>Home</a></li>
                                    <li class="drop-down"><a href="">Loading</a>
                                        <ul class="drop-down-ul animated fadeIn">
                                            <li><asp:HyperLink runat="server" ID="hlPackingReport" NavigateUrl="~/Pages/LoadingSystem/PackingReportPage.aspx">Packing Report</asp:HyperLink></li>
                                            <li><asp:HyperLink runat="server" ID="hlCaltotalPage"  NavigateUrl="~/Pages/LoadingSystem/CalTotalWeightPage.aspx">Cal Total Weight</asp:HyperLink></li>
                                            <li><asp:HyperLink runat="server" ID="hlImportCartonNumbering" NavigateUrl="~/Pages/LoadingSystem/ImportPackingListPage.aspx">Import Carton Numbering</asp:HyperLink></li>
                                        </ul>
                                    </li>
                                    <li class="drop-down d-none"><a href="">QC</a>
                                        <ul class="drop-down-ul animated fadeIn">
                                            <li><asp:HyperLink runat="server" ID="hlSummaryInfo" NavigateUrl="~/Pages/Saoviet">Summary Info</asp:HyperLink></li>
                                            <li><asp:HyperLink runat="server" ID="hlChangeCustomerModePage" NavigateUrl="~/Pages/Saoviet/ChangeCustomerModePage.aspx">Change Visitor Mode</asp:HyperLink></li>
                                        </ul>
                                    </li>
                                    <li class="drop-down"><a href="">Checking In</a>
                                        <ul class="drop-down-ul animated fadeIn">
                                            <li><asp:HyperLink runat="server" ID="hlLineAttendance" NavigateUrl="~/Pages/CheckInSystem">Line Attendance</asp:HyperLink></li>
                                        </ul>
                                    </li>
                                        
                                    <li><asp:Hyperlink runat="server" ID="hlMachineInventory" visible="false" NavigateUrl="~/Pages/MachineInventory">Machine Inventory</asp:Hyperlink></li>

                                    <li class="drop-down"><a href="">Sample Room</a>
                                        <ul class="drop-down-ul animated fadeIn">
                                            <li><asp:HyperLink runat="server" ID="hlSampleRoom" NavigateUrl="~/Pages/SampleRoom/SampleRoom.aspx">Look Up Sample Shoes</asp:HyperLink></li>
                                        </ul>
                                    </li>
                                    <li><asp:HyperLink runat="server" ID="hlScissorsManagment" NavigateUrl="~/Pages/ScissorsManagment/ScissorsHome.aspx"><i class="fa fa-scissors"></i>Scissors Managment</asp:HyperLink></li>
                                    

                                    <li class="drop-down"><a href=""><i class="fa fa-cash-register"></i>Machines Managment</a>
                                        <ul class="drop-down-ul animated fadeIn">
                                            <li><asp:HyperLink runat="server" Enabled="false" ID="hlSewingMachines" NavigateUrl="~/Pages/SewingMachines/HomePage.aspx">Sewing Machines</asp:HyperLink></li>
                                            <li><asp:HyperLink runat="server" ID="HyperLink2"  NavigateUrl="~/Pages/SewingMachines/OutsolePaperHome.aspx">Outsole Paper Image Upload</asp:HyperLink></li>
                                        </ul>
                                    </li>

                                </ul>
                            </div>
                            <script>
                                $(function () {
                                    $('.toggle-menu').click(function () {
                                        $('.exo-menu').toggleClass('display');
                                    });
                                });
                            </script>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div>        

        <div class="SVContent"></div>
        <footer class="page-footer font-small">
            <div class="footer-copyright text-center py-3">© 2020 Created by:<a runat="server" href="../../Default.aspx"> IT Saoviet</a></div>
        </footer>
    </body>
    </html>
</asp:Content>
