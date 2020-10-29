<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MachineDatabase.aspx.cs" Inherits="WebsiteTesting.Pages.SewingMachines.MachineDatabase" MasterPageFile="~/Main.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
<!DOCTYPE html>
    <head>
        <title>Sewing Machines Database</title>
        <link href="../../assets/css/styleForPage.css" rel="Stylesheet"/>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script type="text/javascript">
            function Confirm() {
                var confirm_value = document.createElement("INPUT");
                confirm_value.type = "hidden";
                confirm_value.name = "confirm_value";
                if (confirm("Confirm update machine barcode ?")) {
                    confirm_value.value = "Yes";
                } else {
                    confirm_value.value = "No";
                }
                document.forms[0].appendChild(confirm_value);
            }
        </script>
    </head>
    <html>
        <body>
            <!--Main layout-->
            <div class="container SVContent">
                
                <!--Navigator-->
                <nav class="breadcrumb breadcrumb_type5" aria-label="Breadcrumb">
                    <ol class="breadcrumb__list r-list">
                        <li class="breadcrumb__group">
                            <a href="HomePage.aspx" class="breadcrumb__point r-link"><i class="fa fa-home"></i>Sewing Machine</a>
                            <span class="breadcrumb__divider" aria-hidden="true">›</span>
                        </li>
                        <li class="breadcrumb__group">
                            <span class="breadcrumb__point" aria-current="page">Update Barcode</span>
                        </li>
                    </ol>
                </nav>
                
                <!--Header-->
                <div class="text-center">
                    <h3 class="font-weight-bold">MACHINE BARCODE</h3>
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
                                <div class="col-12 col-sm-8 col-md-8"> <%-- DataTextField="MachineType" DataValueField="MachineType"--%>
                                    <asp:DropDownList ID="cboMachineType" CssClass="btn rounded-0 border-dark" runat="server"
                                        AutoPostBack="true" OnSelectedIndexChanged="cboMachineType_SelectedIndexChanged"/>
                                </div>
                            </div>

                            <div class="row mt-2">
                                <div class="col-12 col-sm-4 col-md-4 mt-2">
                                    Machine Number
                                </div>
                                <div class="col-12 col-sm-8 col-md-8">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtMachineNumber" CssClass="form-control rounded-0" runat="server" placeholder="Input number of machine"></asp:TextBox>
                                        <div class="input-group-append">
                                            <asp:Button CssClass="input-group-text btn btn-primary rounded-0" ID="btnMachineNumberOK" runat="server" Text="OK" OnClick="btnMachineNumberOK_Click"/>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row mt-2">
                                <div class="col-12 col-sm-4 col-md-4 mt-2">
                                    Machine Code
                                </div>
                                <div class="col-12 col-sm-8 col-md-8">
                                    <asp:TextBox ID="txtMachineCode" Enabled="false" CssClass="form-control rounded-0" runat="server"></asp:TextBox>
                                </div>
                            </div>

                            <div class="row mt-2">
                                <div class="col-12 col-sm-4 col-md-4 mt-2">
                                    Barcode
                                </div>
                                <div class="col-12 col-sm-8 col-md-8">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtMachineBarcode" CssClass="form-control rounded-0" runat="server" ClientIDMode="Static" placeholder="barcode"></asp:TextBox>
                                        <div class="input-group-append">
                                            <button class="btn btn-lg rounded-0 border" type="button" id="btnScanMachineBarcode">
                                                <a><i class="fa fa-barcode"></i></a>
				                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col" id="cameraArea" style="display:none;" >
                                <div class="row">
                                    <div class="col-12 text-center">
                                        <video id="video" width="300" height="300"></video>
                                    </div>
                                </div>

                                <div class="row" id="sourceSelectPanel" style="display:none">
                                    <div class="input-group mt-2">
                                        <label for="sourceSelect" class="mt-1">Select Camera:</label>
                                        <div class="input-group-append ml-2">
                                            <select id="sourceSelect"  style="max-width:400px">
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row mt-3 ">
                                <div class="col-12 col-sm-4 col-md-4">
                                </div>
                                <div class="col-12 col-sm-8 col-md-8">
                                    <asp:Button CssClass="btn btn-primary rounded-0" ID="btnSave" Enabled="false" runat="server" Text="Save" OnClientClick="Confirm()" onclick="btnSave_Click"/>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-12 d-none col-sm-2 col-md-2 col-lg-3 d-sm-block d-md-block d-lg-block"></div>
                </div>
            </div>

            <!--Footer-->
            <footer class="page-footer font-small">
                <div class="footer-copyright text-center py-3">© 2020 Created by:<a runat="server" href="../../Default.aspx"> IT Saoviet</a></div>
            </footer>
            <script type="text/javascript" src="assets/zxing.js"></script>
            <script type="text/javascript">
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

                        // Machine Barcode Click
                        document.getElementById("btnScanMachineBarcode").addEventListener("click", function () {
                            cameraArea.style.display = 'block'
                            codeReader.reset()
                            console.log('Reset.')
                            document.getElementById("txtMachineBarcode").value = ''
                            codeReader.decodeFromVideoDevice(selectedDeviceId, 'video', (result, err) => {
                                if (result) {
                                    console.log(result)
                                    //document.getElementById('result').textContent = result.text
                                    $(document).ready(function () {
                                        document.getElementById("txtMachineBarcode").value = result.text
                                    });
                                }
                                if (err && !(err instanceof ZXing.NotFoundException)) {
                                    console.error(err)
                                    document.getElementById("txtMachineBarcode").value = err
                                }
                            })
                            console.log(`Started continous decode from camera with id ${selectedDeviceId}`)
                        })
                    })
                    .catch((err) => {
                        console.error(err)
                    })
            </script>
        </body>
    </html>
</asp:Content>
