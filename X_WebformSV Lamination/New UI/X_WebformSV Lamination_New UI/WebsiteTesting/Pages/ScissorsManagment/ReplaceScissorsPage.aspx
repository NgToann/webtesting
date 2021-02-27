﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReplaceScissorsPage.aspx.cs" Inherits="WebsiteTesting.Pages.ScissorsManagment.ReplaceScissorsPage" MasterPageFile="~/Main.Master" %>


<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
    <!DOCTYPE html>
    <html>
    <head>
        <title>REPLACE SCISSORS</title>
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
                    <span class="breadcrumb__point" aria-current="page">Replace Scissors</span>
                </li>
                </ol>
            </nav>

            <section class="sectionHeader">
                <h1 class="text-center"><asp:Label ID="lblTitle" runat="server">REPLACE SCISSORS</asp:Label></h1>
            </section>

            <div class="col-12 col-md-6">
                <div class="row mt-3 mt-md-0 mt-md-sm-0 mt-lg-0 mb-1 mb-md-0 mb-lg-0">
                    <div class="col-3 col-md-3 mt-1"><p>Reason:</p></div>
                    <div class="col-9 col-md-9">
                        <div class="row">
                            <div class="col-6">
                                <asp:RadioButton ID="radReasonBroken" CssClass="form-check-input" runat="server" Text="Broken" GroupName="Reason" Checked="true"/>
                            </div>
                            <div class="col-6">
                                <asp:RadioButton ID="radReasonLoss" CssClass="form-check-input" runat="server" Text="Loss" GroupName="Reason"/>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col" id="cameraArea" style="display:none;" >
                    <div class="row">
                        <div class="col-12 text-center">
                            <video id="video" width="320" height="320"></video>
                        </div>
                    </div>

                    <div class="row mt-2" id="sourceSelectPanel" style="display:none">
                        <div class="input-group">
                            <label for="sourceSelect" class="mt-1">Select Camera:</label>
                            <div class="input-group-append ml-2">
                                <select id="sourceSelect"  style="max-width:400px">
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row mt-3">
                    <div class="col-12">
                        <div class="input-group">
                            <asp:TextBox ID="txtScissorsReplaceBarcode" CssClass="form-control rounded-0" runat="server" ClientIDMode="Static" placeholder="Scan Replace Scissors Barcode"></asp:TextBox>
                            <div class="input-group-append">
                                <button class="btn btn-lg rounded-0 border" type="button" id="btnScanBarcodeReplaceScissors">
                                    <a><i class="fa fa-barcode fa-barcode-big"></i></a>
				                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row mt-3 mt-md-0 mt-md-sm-0 mt-lg-0">
                    <div class="col-3">
                        <asp:Button CssClass="btn btn-primary mt-3 rounded-0" ID="btnSave" runat="server" OnClientClick="Confirm()" Text="Save" onclick="btnSave_Click"/>
                    </div>
                </div>
            </div>
        </div>
        <footer class="page-footer font-small">
            <div class="footer-copyright text-center py-3">© 2020 Created by:<a runat="server" href="../../Default.aspx"> IT Saoviet</a></div>
        </footer>
        <script src="assets/zxing.js"></script>
        <script type="text/javascript" language="javascript">
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

                    // Replace Barcode Button Click
                    document.getElementById("btnScanBarcodeReplaceScissors").addEventListener("click", function () {
                        cameraArea.style.display = 'block'
                        codeReader.reset()
                        console.log('Reset.')
                        document.getElementById("txtScissorsReplaceBarcode").value = ''
                        codeReader.decodeFromVideoDevice(selectedDeviceId, 'video', (result, err) => {
                            if (result) {
                                console.log(result)
                                //document.getElementById('result').textContent = result.text
                                $(document).ready(function () {
                                    document.getElementById("txtScissorsReplaceBarcode").value = result.text
                                });
                            }
                            if (err && !(err instanceof ZXing.NotFoundException)) {
                                console.error(err)
                                document.getElementById("txtScissorsReplaceBarcode").value = err
                            }
                        })
                        console.log(`Started continous decode from camera with id ${selectedDeviceId}`)
                    })
                })

                .catch((err) => {
                    console.error(err)
                })

            function Confirm() {
                var confirm_value = document.createElement("INPUT");
                confirm_value.type = "hidden";
                confirm_value.name = "confirm_value";
                if (confirm("Confirm replace the Scissors ?")) {
                    confirm_value.value = "Yes";
                } else {
                    confirm_value.value = "No";
                }
                document.forms[0].appendChild(confirm_value);
            }
        </script>
    </body>
    </html>
</asp:Content>

