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
        
        <script type="text/javascript" language="javascript">
            $(function () {
                $('#<%=txtCreatedDate.ClientID %>').datepicker();
            });
        </script>
    </head>
    <html>
        <body>
            <asp:ScriptManager ID="scriptManagerUpdateMachineImage" runat="server" EnablePageMethods="true" />
            <!--Main layout-->
            <div class="container SVContent">
                
                <!--Navigator-->
                <nav class="breadcrumb breadcrumb_type5" aria-label="Breadcrumb">
                    <ol class="breadcrumb__list r-list">
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
                                    <asp:TextBox ID="txtSection" CssClass="form-control rounded-0" runat="server"></asp:TextBox>
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

                            <div class="row mt-2">
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
                                <div class="col-12 col-md-4 mt-2 mb-2 mb-sm-0">
                                    Left Image
                                </div>
                                <div class="col-12 col-md-8 text-center">
                                    <asp:Image runat="server" ID="imgLeftDisplay" width="280" height="280" Visible="false"/>
                                    <canvas id="canvasLeftImage" style="display:none;background-color:lightgrey; margin:0 auto;" width="280" height="280"></canvas>
                                </div>
                            </div>

                            <div class="row mt-2">
                                <div class="col-12 col-md-4 mt-2 mb-2 mb-sm-0">
                                    Right Image
                                </div>
                                <div class="col-12 col-md-8 text-center">
                                    <asp:Image runat="server" ID="imgRightDisplay" width="280" height="280" Visible="false"/>
                                    <canvas id="canvasRightImage" style="display:none;background-color:lightgrey; margin:0 auto;" width="280" height="280"></canvas>
                                </div>
                            </div>

                            <div class="row mt-2">
                                <div class="col-12 col-md-4 mt-2">
                                </div>
                                <div class="col-12 col-md-8 mt-2 mt-sm-0 text-center" id="cameraArea" style="display:none;">
                                    <video id="video" playsinline autoplay width="280" height="280"></video>
                                </div>
                            </div>
                            <div class="row mt-2" id="sourceSelectPanel" style="display:none">
                                <div class="col">
                                    <div class="input-group">
                                        <label for="sourceSelect" class="mt-1">Select Camera:</label>
                                        <div class="input-group-append ml-2">
                                            <select id="sourceSelect" class="rounded-0" style="max-width:350px"></select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row mt-2 mb-2">
                                <div class="col text-center text-sm-left">
                                    <div class="btn-group">
                                        <button id="btnOpenCamera" class="btn btn-primary rounded-0  mr-1">Open</button>
                                        <button id="btnSnapLeft" style="display:none;" class="btn btn-success rounded-0 mr-1">Snap Left</button>
                                        <button id="btnSnapRight" style="display:none;" class="btn btn-info rounded-0 mr-1">Snap Right</button>
                                        <button id="btnCloseCamera" style="display:none;" class="btn btn-warning rounded-0">Close</button>
                                    </div>
                                </div>
                            </div>

                            <div class="row mt-3">
                                <div class="col-12 col-md-4">
                                </div>
                                <div class="col-12 col-md-8">
                                    <div class="btn-sm-group">
                                        <input type="button" id="btnSave" class="btn btn-info rounded-0" value="Save"/>
                                        <input type="button" id="btnDelete" class="btn btn-danger rounded-0 ml-2" value="Delete"/>
                                    </div>
                                    
                                </div>
                            </div>
                        </div>

                        <!--initial camera envirorment-->
                        <script type="text/javascript" src="assets/zxing.js"></script>
                        <script type="text/javascript">
                            let selectedDeviceId;
                            const codeReader = new ZXing.BrowserMultiFormatReader()
                            codeReader.getVideoInputDevices()
                            .then((videoInputDevices) => {
                                const sourceSelect = document.getElementById('sourceSelect')
                                selectedDeviceId = videoInputDevices[0].deviceId
                                if (videoInputDevices[videoInputDevices.length - 1] != null) {
                                    selectedDeviceId = videoInputDevices[videoInputDevices.length - 1].deviceId
                                }
                                if (videoInputDevices.length >= 1) {
                                    videoInputDevices.forEach((element) => {
                                        const sourceOption = document.createElement('option')
                                        sourceOption.text = element.label
                                        sourceOption.value = element.deviceId
                                        sourceSelect.appendChild(sourceOption)
                                    })

                                    sourceSelect.onchange = () => {
                                        selectedDeviceId = sourceSelect.value;
                                    };
                                }

                                var video = document.querySelector("#video");
                                // Basic settings for the video to get from Webcam
                                const constraints = {
                                    audio: false,
                                    video: {
                                        width: 280, height: 280
                                    },
                                    deviceId: { exact: selectedDeviceId }
                                    //facingMode: {
                                    //    exact: 'environment'
                                    //}
                                };
                                // This condition will ask permission to user for Webcam access  
                                if (navigator.mediaDevices.getUserMedia) {
                                    navigator.mediaDevices.getUserMedia(constraints)
                                        .then(function (stream) {
                                            video.srcObject = stream;
                                        })
                                        .catch(function (err0r) {
                                            console.log("svqc can not access camera device!");
                                        });
                                }
                                function stop(e) {
                                    var stream = video.srcObject;
                                    var tracks = stream.getTracks();

                                    for (var i = 0; i < tracks.length; i++) {
                                        var track = tracks[i];
                                        track.stop();
                                    }
                                    video.srcObject = null;
                                }
                                
                            })
                            .catch((err) => {
                                console.error(err)
                            })
                        </script>
                        
                        <!--client function-->
                        <script type="text/javascript">
                            // Show the camera
                            $("#btnOpenCamera").click(function () {
                                cameraArea.style.display = 'block';
                                const sourceSelectPanel = document.getElementById('sourceSelectPanel');
                                sourceSelectPanel.style.display = 'block';

                                // Show buttons
                                btnSnapLeft.style.display = 'block';
                                btnSnapRight.style.display = 'block';
                                btnCloseCamera.style.display = 'block';

                                return false;
                            });
                            // Below code to capture image from Video tag (Webcam streaming)
                            $("#btnSnapLeft").click(function () {
                                var canvas = document.getElementById('canvasLeftImage');
                                var leftImage = document.getElementById('contentPlaceHolder_imgLeftDisplay');
                                if (leftImage != null)
                                    leftImage.style.display = 'none';

                                canvasLeftImage.style.display = 'block';
                                var context = canvas.getContext('2d');
                                context.drawImage(video, 0, 0);
                                return false;
                            });

                            $("#btnSnapRight").click(function () {
                                var canvas = document.getElementById('canvasRightImage');
                                var rightImage = document.getElementById('contentPlaceHolder_imgRightDisplay');
                                if (rightImage != null)
                                    rightImage.style.display = 'none';
                                canvasRightImage.style.display = 'block';
                                var context = canvas.getContext('2d');
                                context.drawImage(video, 0, 0);
                                return false;
                            });

                            $("#btnCloseCamera").click(function () {
                                cameraArea.style.display = 'none';
                                // Show buttons
                                btnSnapLeft.style.display = 'none';
                                btnSnapRight.style.display = 'none';
                                btnCloseCamera.style.display = 'none';
                                const sourceSelectPanel = document.getElementById('sourceSelectPanel');
                                sourceSelectPanel.style.display = 'none'
                                return false;
                            });

                            $("#btnSave").click(function () {
                                var updateWhat  = document.getElementById('contentPlaceHolder_lblId').innerHTML;
                                var sectionName = $('#<%=txtSection.ClientID %>').val();
                                var lineName    = $('#<%=txtLine.ClientID %>').val();
                                var productNo   = $('#<%=txtProductNo.ClientID %>').val();
                                var style       = $('#<%=txtStyleName.ClientID %>').val();
                                var outsoleCode = $('#<%=txtOutsoleCode.ClientID %>').val();
                                var createdDate = $('#<%=txtCreatedDate.ClientID %>').val();

                                var value = document.getElementById('contentPlaceHolder_cboMachineType');
                                var machineType = value.options[value.selectedIndex].text;

                                if (sectionName === '' || lineName === '')
                                {
                                    alert('section or linename is emtpy !')
                                    return;
                                }

                                // Get image data to send to server for upload
                                var leftImage = document.getElementById("canvasLeftImage").toDataURL("image/png");
                                leftImage = leftImage.replace('data:image/png;base64,', '');

                                var rightImage = document.getElementById("canvasRightImage").toDataURL("image/png");
                                rightImage = rightImage.replace('data:image/png;base64,', '');

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

            <!--Footer-->
            <footer class="page-footer font-small">
                <div class="footer-copyright text-center py-3">© 2020 Created by:<a runat="server" href="../../Default.aspx"> IT Saoviet</a></div>
            </footer>
        </body>
    </html>
</asp:Content>

