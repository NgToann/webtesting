<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="WebsiteTesting.Pages.SewingMachines.HomePage" MasterPageFile="~/Main.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
<!DOCTYPE html>
    <head>
        <title>Sewing Machines - Home</title>
        <link href="../../assets/css/styleForPage.css" rel="Stylesheet"/>
        <meta name="viewport" content="width=device-width, initial-scale=1">
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
                            <span class="breadcrumb__point" aria-current="page">Sewing Machine</span>
                        </li>
                    </ol>
                </nav>

                <div class="text-center">
                    <h2 class="font-weight-bold">COMPUTER SEWING MACHINES MANAGMENT</h2>
                </div>

                <div class="row sewingMachineContent">
                    <!--First columnn-->
                    <div class="col-12 col-md-4">
                        <div class="card wow fadeIn cardMenu rounded-0">
                            <div class="view overlay hm-white-slight">
                                <a href="MachineDatabase.aspx"><img src="assets/images/machineDB.png" class="img-fluid"></a>
                            </div>
                            <div class="card-block p-2">
                                <h4 class="card-title">Machine Database</h4>
                                <p class="card-text">Update sewing machine barcode</p>
                                <a href="MachineDatabase.aspx" class="btn btn-info rounded-0">Scan</a>
                            </div>
                        </div>
                    </div>

                    <!--Second columnn-->
                    <div class="col-12 col-md-4 mt-2 mt-md-0">
                        <div class="card wow fadeIn cardMenu rounded-0">
                            <div class="view overlay hm-white-slight">
                                <a href="SummaryAndInventory.aspx"><img src="assets/images/inventory.png" class="img-fluid"></a>
                            </div>
                            <div class="card-block p-2">
                                <h4 class="card-title">Summary</h4>
                                <p class="card-text">Line Summary &amp; Machine Inventory</p>
                                <a href="SummaryAndInventory.aspx" class="btn btn-primary rounded-0">Show more</a>
                            </div>
                        </div>
                    </div>

                    <!--Third columnn-->
                    <div class="col-12 col-md-4 mt-2 mt-md-0">
                        <div class="card wow fadeIn cardMenu rounded-0">
                            <div class="view overlay hm-white-slight">
                                <a href="Allocation.aspx"><img src="assets/images/allocate.png" class="img-fluid"></a>
                            </div>
                            <div class="card-block p-2">
                                <h4 class="card-title">Machine Allocation</h4>
                                <p class="card-text">Allocate sewing machine to the Line</p>
                                <a href="Allocation.aspx" class="btn btn-danger rounded-0">Create</a>
                            </div>
                        </div>
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
