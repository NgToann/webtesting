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
                <%--//$('#<%=txtCreatedDate.ClientID %>').datepicker();--%>
                $('#txtDate').datepicker();
            });
        </script>
        <script type="text/javascript" language="JavaScript">
            
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
                <div>
                    <h4 id="lblHeader" class="font-weight-bold"></h4>
                </div>

                <div class="row g-2">
                    <div class="col-12 col-md-4">
                        <form class="small">
                            <div class="row">
                                <div class="col-12 col-sm-6">
                                    <div class="form-group mb-1">
                                        <label class="m-0" for="cboMachineType">Machine Type</label>
                                        <select class="form-select" id="cboMachineType">
                                          <option selected value="Universal">Universal</option>
                                          <option value="TopDown">TopDown</option>
                                          <option value="Air Bag">Air Bag</option>
                                          <option value="GTM">GTM</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-12 col-sm-6">
                                    <div class="form-group mb-1">
                                        <label class="m-0" for="cboSection">Section</label>
                                        <select class="form-select" id="cboSection">
                                          <option selected value="Assembly">Assembly</option>
                                          <option value="Outsole">Outsole</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group mb-1">
                                <label class="m-0">Date</label>
                                <input id="txtDate" class="form-control" placeholder="-- select a date --">
                            </div>
                            <div class="form-group mb-1">
                                <label class="m-0">Line</label>
                                <input id="txtLine" class="form-control">
                            </div>
                            <div class="form-group mb-1">
                                <label class="m-0">Product No</label>
                                <input id="txtProductNo" class="form-control">
                            </div>
                            <div class="form-group mb-1">
                                <label class="m-0">Style Name</label>
                                <input id="txtStyleName" class="form-control">
                            </div>
                            <div class="form-group">
                                <label class="m-0">Outsole Code</label>
                                <input id="txtOutsoleCode" class="form-control">
                            </div>
                            <div class="row">
                                <div class="col-12 col-md-auto mb-2">
                                    <button type="button" id="btnSubmit" class="btn rounded-1 btn-primary float-left">Submit</button>
                                </div>
                                <div class="col-12 col-md-auto mb-2">
                                    <button type="button" id="btnDelete" class="btn rounded-1 btn-danger float-left">Delete</button>
                                </div>
                                <div class="col-12 col-md-auto">
                                    <!-- Button trigger modal -->
                                    <button type="button" class="btn rounded-1 btn-info float-left float-md-right" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                                        Open Camera
                                    </button>
                                </div>
                            </div>

                            <!--Camera Modal-->
                            <!-- Modal -->
                            <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title text-info">Take a picture <i class="fa fa-camera ml-2 text-danger fa-1x" aria-hidden="true"></i></h5>
                                        <button type="button" id="btnCloseModal" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body text-center bg-light">
                                        <div class="col ml-auto mr-auto mt-2 mb-2" id="my_camera"></div>
                                        <%--<div class="form-check form-check-inline">
                                            <button id="btnImgSize1" type="button" class="btn btn-sm btn-outline-info">350 x 250</button>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <button id="btnImgSize2" type="button" class="btn btn-sm btn-outline-info">480 x 320</button>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <button id="btnImgSize3" type="button" class="btn btn-sm btn-outline-info">640 x 480</button>
                                        </div>--%>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" onclick="take_left_snapshot()">Snap Left</button>
                                        <button type="button" class="btn btn-primary" onclick="take_right_snapshot()">Snap Right</button>
                                    </div>
                                </div>
                                </div>
                            </div>
                            
                        </form>
                    </div>
                    <div class="col-12 col-md-4">
                        <figure id="divLeftImage" class="figure mb-1 mb-sm-0">
                        </figure>
                        <figcaption id="fgCaptionLeft" class="figure-caption text-danger d-none">Left Image</figcaption>
                        <figure id="divLeftImageDisplay" class="figure d-none">
                            <img id="imgLeftDisplay" class="figure-img img-fluid rounded" alt="Left Image">
                            <figcaption class="figure-caption text-danger">Left Image</figcaption>
                        </figure>
                    </div>
                    <div class="col-12 col-md-4">
                        <figure id="divRightImage" class="figure mb-1 mb-sm-0">
                        </figure>
                        <figcaption id="fgCaptionRight" class="figure-caption text-danger d-none">Right Image</figcaption>
                        <figure id="divRightImageDisplay" class="figure d-none">
                            <img id="imgRightDisplay" class="figure-img img-fluid rounded" alt="Right Image">
                            <figcaption class="figure-caption text-danger">Right Image</figcaption>
                        </figure>
                    </div>
                </div>
            </div>

            <script type="text/javascript" src="assets/webcam.min.js"></script>
	        <!-- Configure a few settings and attach camera -->
	        <script type="text/javascript">
                var currentOsPaperId = 0;
                window.addEventListener('load', function () {
                    // Load Data Release Scissors
                    $.ajax({
                        url: '<%= ResolveUrl("~/Pages/SewingMachines/AddUpdateOutsoleMachineImage.aspx/LoadPage") %>',
                        data: {},
                        type: "GET",
                        datatype: "json",
                        async: true,
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            if (data.d.toString().includes('Exception:')) {
                                alert(data.d);
                            }
                            else {
                                var sources = JSON.parse(data.d);
                                var osPaperById = sources[2];
                                var machineTypeList = sources[0];
                                var sectionList = sources[1];

                                if (osPaperById == null) {
                                    loadCombobox(null, machineTypeList, sectionList);
                                    lblHeader.innerText = 'Add new outsole paper image';
                                }
                                else {
                                    loadCombobox(osPaperById, machineTypeList, sectionList);
                                    var date = new Date(osPaperById.CreatedDate);
                                    txtLine.value = osPaperById.LineName;
                                    txtDate.value = date.toLocaleDateString();
                                    txtProductNo.value = osPaperById.ProductNo;
                                    txtStyleName.value = osPaperById.StyleName;
                                    txtOutsoleCode.value = osPaperById.OutsoleCode;

                                    divLeftImageDisplay.className = 'figure';
                                    divRightImageDisplay.className = 'figure';
                                    lblHeader.innerText = 'Update outsole paper image';

                                    var baseUrl = window.location.origin;
                                    if (osPaperById.LeftImageDisplay != null)
                                        imgLeftDisplay.src = baseUrl + osPaperById.LeftImageDisplay;
                                    if (osPaperById.RightImageDisplay != null)
                                        imgRightDisplay.src = baseUrl + osPaperById.RightImageDisplay;

                                    currentOsPaperId = osPaperById.OutsolePaperImageId;
                                }
                                document.getElementById("btnSubmit").onclick = function () { summit() };
                            }
                        },
                        error: onError
                    })
                });

                function onError() {
                    alert('An error occured at the backend !');
                };

                function loadCombobox(osPaperById, machineTypeList, sectionList) {
                    var selectMachineType = document.getElementById('cboMachineType');
                    selectMachineType.innerHTML = '';
                    var selectSection = document.getElementById('cboSection');
                    selectSection.innerHTML = '';
                    machineTypeList.forEach(function (item) {
                        var opt = document.createElement('option');
                        opt.value = item.MachineType;
                        opt.innerText = item.MachineType;
                        if (osPaperById != null && osPaperById.MachineType == item.MachineType) {
                            opt.selected = true;
                        }
                        selectMachineType.appendChild(opt);
                    });
                    sectionList.forEach(function (item) {
                        var opt = document.createElement('option');
                        opt.value = item;
                        opt.innerText = item;
                        if (osPaperById != null && osPaperById.SectionName == item) {
                            opt.selected = true;
                        }
                        selectSection.appendChild(opt);
                    });
                }

                function summit() {
                    var machineType = document.getElementById('cboMachineType').value;
                    var section = document.getElementById('cboSection').value;
                    var date = document.getElementById('txtDate').value;
                    var line = document.getElementById('txtLine').value;
                    var poNo = document.getElementById('txtProductNo').value;
                    var styleName = document.getElementById('txtStyleName').value;
                    var osCode = document.getElementById('txtOutsoleCode').value;
                    var leftImageContent = document.getElementById('divLeftImage').innerHTML;
                    var rightImageContent = document.getElementById('divRightImage').innerHTML;

                    var submitModel = new UploadOSPaperModel(
                        OutsolePaperImageId = currentOsPaperId,
                        SectionName = section,
                        LineName = line,
                        ProductNo = poNo,
                        OutsoleCode = osCode,
                        MachineType = machineType,
                        CreatedDateString = date,
                        LeftImageContent = leftImageContent,
                        RightImageContent = rightImageContent,
                        StyleName = styleName
                    );

                    if (date == '') {
                        alert('Date is empty !')
                        return;
                    }

                    var submitContent = JSON.stringify({ osPaperInsert: submitModel });
                    $.ajax({
                        url: '<%= ResolveUrl("~/Pages/SewingMachines/AddUpdateOutsoleMachineImage.aspx/Upload") %>',
                        data: submitContent,
                        type: "POST",
                        datatype: "json",
                        async: true,
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            alert(data.d);
                        },
                        error: onError
                    })

                }

                $("#btnDelete").click(function () {
                    var deleteWhat = currentOsPaperId.toString();
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

                Webcam.set({
                    width: 400,
                    height: 300,
                    dest_width: 640,
                    dest_height: 480,
                    image_format: 'png',
                    png_quality: 90,
                    constraints: {
                        facingMode: "environment",
                        frameRate: 30
                    }
                });
                Webcam.attach('#my_camera');

                //document.getElementById("btnImgSize1").onclick = function () { selectImageSize(320, 240) };
                //document.getElementById("btnImgSize2").onclick = function () { selectImageSize(480, 320) };
                //document.getElementById("btnImgSize3").onclick = function () { selectImageSize(640, 480) };
                function selectImageSize(width, height) {
                    //Webcam.reset()
                    Webcam.set({
                        width: width,
                        height: height,
                        dest_width: width,
                        dest_height: height,
                        image_format: 'png',
                        png_quality: 90,
                        constraints: {
                            facingMode: "environment",
                            frameRate: 30
                        }
                    });
                    Webcam.attach('#my_camera');
                }

                function take_left_snapshot() {
                    // take snapshot and get image data
                    Webcam.snap(function (data_uri) {
                        // display results in page
                        //document.getElementById('contentPlaceHolder_divLeftImage').innerHTML =
                        document.getElementById('divLeftImage').innerHTML =
                            '<img class="figure-img img-fluid rounded" src="' + data_uri + '"/>';
                        document.getElementById('btnCloseModal').click();
                    });
                    var fgCaptionLeft = document.getElementById('fgCaptionLeft');
                    fgCaptionLeft.className = 'figure-caption text-danger';

                    divLeftImageDisplay.className = 'figure d-none';
                }
                function take_right_snapshot() {
                    // take snapshot and get image data
                    Webcam.snap(function (data_uri) {
                        // display results in page
                        //document.getElementById('contentPlaceHolder_divRightImage').innerHTML =
                        document.getElementById('divRightImage').innerHTML =
                            '<img class="figure-img img-fluid rounded" src="' + data_uri + '"/>';
                        document.getElementById('btnCloseModal').click();
                    });
                    var fgCaptionRight = document.getElementById('fgCaptionRight');
                    fgCaptionRight.className = 'figure-caption text-danger';
                    divRightImageDisplay.className = 'figure d-none';
                }                          

                class UploadOSPaperModel {
                    constructor(OutsolePaperImageId, SectionName, LineName, ProductNo, OutsoleCode, MachineType, CreatedDateString, LeftImageContent, RightImageContent, StyleName) {
                        this.OutsolePaperImageId = OutsolePaperImageId;
                        this.SectionName = SectionName;
                        this.LineName = LineName;
                        this.ProductNo = ProductNo;
                        this.OutsoleCode = OutsoleCode;
                        this.MachineType = MachineType;
                        this.CreatedDateString = CreatedDateString;
                        this.LeftImageContent = LeftImageContent;
                        this.RightImageContent = RightImageContent;
                        this.StyleName = StyleName
                    }
                }

            </script>
        </body>
    </html>
</asp:Content>

