<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InspectionPage.aspx.cs" Inherits="WebsiteTesting.Pages.ScissorsManagment.InspectionPage" MasterPageFile="~/Main.Master" %>


<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
    <!DOCTYPE html>
    <html>
    <head>
        <title>Scissors Managment - Inspection</title>
        <link href="assets/style.css" rel="Stylesheet"/>
        <link href="../../assets/css/styleForPage.css" rel="Stylesheet"/>
        <meta name="viewport" content="width=device-width, initial-scale=1">
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
                    <span class="breadcrumb__point" aria-current="page">Inspection</span>
                </li>
                </ol>
            </nav>
            
            <section class="sectionHeader">
                <h1><asp:Label ID="lblTitle" runat="server">INSPECTION</asp:Label></h1>
            </section>
            
            <div class="row">
                <div class="col-12 col-md-6">
                    <div class="row mt-3 mt-md-0 mt-md-sm-0 mt-lg-0 mb-1 mb-md-0 mb-lg-0">
                        <div class="col-12 col-md-6 col-lg-6 col-xl-6">
                            <div class="input-group-append">
                                <button class="btn btn-lg rounded-0 border" type="button" id="btnScanScissorsBarcode">
                                    <a><i class="fa fa-barcode"></i></a>
				                </button>
                                <asp:TextBox ID="txtScissorsBarcode" CssClass="form-control rounded-0" runat="server" ClientIDMode="Static" placeholder="Scan Barcode"></asp:TextBox>
                                <asp:Button CssClass="btn btn-primary rounded-0" ID="btnSave" runat="server" Text="OK" onclick="btnSave_Click"/>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-1">
                        <div class="col-12 col-md-6 col-lg-6 col-xl-6">
                            <div class="input-group-append">
                                <asp:TextBox ID="txtWorkerId" CssClass="form-control rounded-0" runat="server" placeholder="Worker Id"></asp:TextBox>
                                <asp:Button CssClass="btn btn-info rounded-0" ID="btnWorkerSearch" runat="server" Text="Search" onclick="btnWorkerSearch_Click"/>
                            </div>
                        </div>
                    </div>

                    <div class="col" id="cameraArea" style="display:none;" >
                        <div class="row text-center">
                            <div class="col-12 text-center">
                                <video id="video" width="320" height="320"></video>
                            </div>
                        </div>

                        <div class="row" id="sourceSelectPanel" style="display:none">
                            <div class="input-group mt-2">
                                <label for="sourceSelect" class="mt-1">Select Camera:</label>
                                <div class="input-group-append ml-2">
                                    <select id="sourceSelect" style="max-width:400px">
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-3">
                        <div class="col">
                            <asp:Table ID="tableInspection" CssClass="table table-hover table-bordered" runat="server">
                            </asp:Table>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <footer class="page-footer font-small">
            <div class="footer-copyright text-center py-3">© 2020 Created by:<a runat="server" href="../../Default.aspx"> IT Saoviet</a></div>
        </footer>

        <script src="assets/zxing.js"></script>
        <script type="text/javascript" language="javascript">
            //window.addEventListener('load', function () {
            let selectedDeviceId;
            const codeReader = new ZXing.BrowserMultiFormatReader()
            console.log('ZXing code reader initialized')
            codeReader.getVideoInputDevices()
                .then((videoInputDevices) => {
                    const sourceSelect = document.getElementById('sourceSelect')
                    selectedDeviceId = videoInputDevices[0].deviceId
                    if (videoInputDevices[videoInputDevices.length - 1] != null) {
                        selectedDeviceId = videoInputDevices[videoInputDevices.length - 1].deviceId
                    }
                    //if (videoInputDevices[1] != null) {
                    //    selectedDeviceId = videoInputDevices[1].deviceId
                    //}
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

                        const sourceSelectPanel = document.getElementById('sourceSelectPanel')
                        sourceSelectPanel.style.display = 'block'
                    }
                    // Barcode Button Click
                    document.getElementById("btnScanScissorsBarcode").addEventListener("click", function () {
                        cameraArea.style.display = 'block'
                        codeReader.reset()
                        console.log('Reset.')
                        document.getElementById("txtScissorsBarcode").value = ''
                        codeReader.decodeFromVideoDevice(selectedDeviceId, 'video', (result, err) => {
                            if (result) {
                                console.log(result)
                                //document.getElementById('result').textContent = result.text
                                $(document).ready(function () {
                                    document.getElementById("txtScissorsBarcode").value = result.text
                                    // Click OK Button
                                    document.getElementById('<%= btnSave.ClientID %>').click();
                                });                                    
                            }
                            if (err && !(err instanceof ZXing.NotFoundException)) {
                                console.error(err)
                                document.getElementById("txtScissorsBarcode").value = err
                            }
                        })
                        console.log(`Started continous decode from camera with id ${selectedDeviceId}`)
                    })
                })
                .catch((err) => {
                    console.error(err)
                })
            //})
        </script>
    </body>
    </html>
</asp:Content>
