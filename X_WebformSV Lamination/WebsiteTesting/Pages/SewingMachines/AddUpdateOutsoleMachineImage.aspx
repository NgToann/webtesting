<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddUpdateOutsoleMachineImage.aspx.cs" Inherits="WebsiteTesting.Pages.SewingMachines.AddUpdateOutsoleMachineImage" MasterPageFile="~/Main.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
<!DOCTYPE html>
    <head>
        <title>Sewing Machines Database</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="../../assets/css/styleForPage.css" rel="Stylesheet"/>
        <link rel="stylesheet" href="assets/jquery-ui.css">
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="assets/jquery-1-12.4.js"></script>
        <script src="assets/jquery-ui.js"></script>
        <script src="//code.jquery.com/jquery-1.12.4.js"></script>
        <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
        
	    <script type="text/javascript" language="javascript">
            $(function () {
                $('#<%=txtCreatedDate.ClientID %>').datepicker();
            });
        </script>
        <script language="JavaScript">
            function take_left_snapshot() {
                // take snapshot and get image data
                Webcam.snap(function (data_uri) {
                    // display results in page
                    document.getElementById('contentPlaceHolder_divLeftImage').innerHTML =
                        '<img src="' + data_uri + '"/>';
                    document.getElementById('btnCloseModal').click();
                });
            }
            function take_right_snapshot() {
                // take snapshot and get image data
                Webcam.snap(function (data_uri) {
                    // display results in page
                    document.getElementById('contentPlaceHolder_divRightImage').innerHTML =
                        '<img src="' + data_uri + '"/>';
                    document.getElementById('btnCloseModal').click();
                });
            }
        </script>
    </head>
    <html>
        <body>
            <asp:ScriptManager ID="scriptManagerUpdateMachineImage" runat="server" EnablePageMethods="true" />
            <!--Main layout-->
            <div class="container SVContent">

                <!--Navigator-->
                <nav class="breadcrumb breadcrumb_type5" aria-label="Breadcrumb" style="padding: 12px 16px;">
                    <ol class="breadcrumb__list r-list align-content-center">
                        <li class="breadcrumb__group">
                            <a href="../../Default.aspx" class="breadcrumb__point r-link"><i class="fa fa-home"></i>Home</a>
                            <span class="breadcrumb__divider" aria-hidden="true">›</span>
                        </li>
                        <li class="breadcrumb__group">
                            <a href="OutsolePaperHome.aspx" class="breadcrumb__point r-link">Outsole Paper Pressing</a>
                            <span class="breadcrumb__divider" aria-hidden="true">›</span>
                        </li>
                        <li class="breadcrumb__group">
                            <span class="breadcrumb__point" aria-current="page">Update Machine Image</span>
                        </li>
                    </ol>
                </nav>
                
                <!--Header-->
                <div class="text-center">
                    <h3 class="font-weight-bold"><asp:Label ID="lblTitle" Text="Add New Image" runat="server"></asp:Label></h3>
                    <asp:Label ID="lblId" CssClass="d-none" runat="server"></asp:Label>
                </div>
                
                <!--Content-->
                <div class="row">
                    <div class="col-12 d-none col-sm-2 col-md-2 col-lg-3 d-sm-block d-md-block d-lg-block"></div>

                    <div class="col-12 col-sm-8 col-md-8 col-lg-6">
                        <div class="container sewingMachineDatabase">
                            <div class="row">
                                <div class="col-12 col-sm-4 col-md-4 mt-2">
                                    Machine Type
                                </div>
                                <div class="col-12 col-sm-8 col-md-8">
                                    <asp:DropDownList ID="cboMachineType" CssClass="btn rounded-0 border-dark" runat="server" AutoPostBack="false"/>
                                </div>
                            </div>
                            <div class="row mt-2">
                                <div class="col-12 col-md-4 mt-2">
                                    Date
                                </div>
                                <div class="col-12 col-md-8">
                                    <asp:TextBox ID="txtCreatedDate" CssClass="form-control rounded-0" runat="server"></asp:TextBox>
                                </div>
                            </div>

                            <div class="row mt-2">
                                <div class="col-12 col-md-4 mt-2">
                                    Section
                                </div>
                                <div class="col-12 col-md-8">
                                    <asp:DropDownList ID="cboSectionName" CssClass="btn rounded-0 border-dark" runat="server" AutoPostBack="false"/>
                                </div>
                            </div>

                            <div class="row mt-2">
                                <div class="col-12 col-md-4 mt-2">
                                    Line
                                </div>
                                <div class="col-12 col-md-8">
                                    <asp:TextBox ID="txtLine" CssClass="form-control rounded-0" runat="server"></asp:TextBox>
                                </div>
                            </div>

                            <div class="row mt-2 d-none">
                                <div class="col-12 col-md-4 mt-2">
                                    ProductNo
                                </div>
                                <div class="col-12 col-md-8">
                                    <asp:TextBox ID="txtProductNo" CssClass="form-control rounded-0" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row mt-2">
                                <div class="col-12 col-md-4 mt-2">
                                    Style Name
                                </div>
                                <div class="col-12 col-md-8">
                                    <asp:TextBox ID="txtStyleName" CssClass="form-control rounded-0" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row mt-2">
                                <div class="col-12 col-md-4 mt-2">
                                    OutsoleCode
                                </div>
                                <div class="col-12 col-md-8">
                                    <asp:TextBox ID="txtOutsoleCode" CssClass="form-control rounded-0" runat="server"></asp:TextBox>
                                </div>
                            </div>                            

                            <div class="row mt-2">
                                <div class="col-12 col-sm-12 col-md-3 col-lg-4 mt-2 mb-2 mb-sm-0 text-wrap">
                                    Left Image
                                </div>
                                <div class="col-12 col-sm-12 col-md-9 col-lg-8 text-center">
                                    <div id="divLeftImage" runat="server"></div>
                                </div>
                            </div>

                            <div class="row mt-2">
                                <div class="col-12 col-sm-12 col-md-3 col-lg-4 mt-2 mb-2 mb-sm-0 text-wrap">
                                    Right Image
                                </div>
                                <div class="col-12 col-sm-12 col-md-9 col-lg-8 text-center">
                                    <%--style="width: 320px !important; height:240px !important;"--%>
                                    <div id="divRightImage" runat="server"></div>
                                </div>
                            </div>
                            
                            <div class="row mt-2 mb-2">
                                <div class="col text-center text-sm-left">
                                    <button id="btnOpenCamera" class="btn btn-danger rounded-2" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                                        Open Camera</button>
                                </div>
                            </div>

                            <div class="row mt-3">
                                <div class="col-12 col-md-4">
                                </div>
                                <div class="col-12 col-md-8">
                                    <div class="btn-sm-group">
                                        <%--<input type="button" id="" class="btn btn-info rounded-2" value="Save"/>--%>
                                        <button id="btnSave" type="button" class="btn btn-outline-success"><i class="fa fa-check-circle text-info mr-2" style="font-size:1rem !important;" aria-hidden="true"></i>Save</button>
                                        <button id="btnDelete" type="button" class="btn btn-outline-danger" data-bs-dismiss="modal"><i class="fa fa-times-circle text-warning mr-2" style="font-size:1rem !important;" aria-hidden="true"></i>Delete</button>
                                    </div>
                                    
                                </div>
                            </div>
                        </div>
                        
                        <!--client function-->
                        <script type="text/javascript">
                            // Open the camera
                            $("#btnOpenCamera").click(function () {
                                return false;
                            });

                            $("#btnSave").click(function () {
                                var updateWhat  = document.getElementById('contentPlaceHolder_lblId').innerHTML;
                                var lineName    = $('#<%=txtLine.ClientID %>').val();
                                //var productNo   = $('#<%=txtProductNo.ClientID %>').val();
                                var productNo   = '';
                                var style       = $('#<%=txtStyleName.ClientID %>').val();
                                var outsoleCode = $('#<%=txtOutsoleCode.ClientID %>').val();
                                var createdDate = $('#<%=txtCreatedDate.ClientID %>').val();

                                var value = document.getElementById('contentPlaceHolder_cboMachineType');
                                var machineType = value.options[value.selectedIndex].text;

                                var sectionFromCbo = document.getElementById('contentPlaceHolder_cboSectionName');
                                var sectionName = sectionFromCbo.options[sectionFromCbo.selectedIndex].text;

                                if (lineName === '')
                                {
                                    alert('Linename is emtpy !')
                                    return;
                                }

                                // Get image data to send to server for upload
                                //var leftImage = document.getElementById("canvasLeftImage").toDataURL("image/jpeg");
                                var leftImage = document.getElementById("contentPlaceHolder_divLeftImage").innerHTML;
                                //leftImage = leftImage.replace('<img src=\"data:image/jpeg;base64,', '');
                                //leftImage = leftImage.replace('\">', '');

                                //var rightImage = document.getElementById("canvasRightImage").toDataURL("image/jpeg");
                                var rightImage = document.getElementById("contentPlaceHolder_divRightImage").innerHTML;
                                //rightImage = rightImage.replace('<img src=\"data:image/jpeg;base64,', '');
                                //rightImage = rightImage.replace('\">', '');

                                var confirmUpdate = confirm('Confirm Update Machine Image ?');
                                if (confirmUpdate == true) {
                                    PageMethods.UploadImage(updateWhat, sectionName, lineName, productNo, style, outsoleCode, machineType, createdDate, leftImage, rightImage, onSuccess, onError);
                                    function onSuccess(result) {
                                        alert(result);
                                        window.location.href = 'OutsolePaperHome.aspx?';
                                    }
                                    function onError(result) {
                                        alert(result.d);
                                    }
                                    return false;
                                }
                                else {
                                    return;
                                }
                            });

                            $("#btnDelete").click(function () {
                                var deleteWhat = document.getElementById('contentPlaceHolder_lblId').innerHTML;
                                var confirmDelete = confirm('Confirm delete this record ?');
                                if (confirmDelete == true) {
                                    PageMethods.DeleteRecord(deleteWhat, onSuccess, onError);
                                    function onSuccess(result) {
                                        alert(result);
                                        window.location.href = 'OutsolePaperHome.aspx?';
                                    }
                                    function onError(result) {
                                        alert(result.d);
                                    }
                                    return false;
                                }
                                else {
                                    return;
                                }
                            });
                        </script>
                    </div>
                    <div class="col-12 d-none col-sm-2 col-md-2 col-lg-3 d-sm-block d-md-block d-lg-block"></div>
                </div>
            </div>

            <!-- Open Camera Modal -->
            <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title text-info" id="staticBackdropLabel">Take a picture <i class="fa fa-camera ml-2 text-danger fa-1x" aria-hidden="true"></i></h5>
                    <button type="button" id="btnCloseModal" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                      <div class="container" id="my_camera">
                      </div>
                  </div>
                    <!-- First, include the Webcam.js JavaScript Library -->
	                <script type="text/javascript" src="assets/webcam.min.js"></script>
	                <!-- Configure a few settings and attach camera -->
	                <script language="javascript">
                        Webcam.set({
                            width: 320,
                            height: 240,
                            image_format: 'png',
                            png_quality: 90
                        });
                        Webcam.attach('#my_camera');
                    </script>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="take_left_snapshot()">Snap Left</button>
                    <button type="button" class="btn btn-primary" onclick="take_right_snapshot()">Snap Right</button>
                  </div>
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

