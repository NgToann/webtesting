<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IssuancePage.aspx.cs" Inherits="WebsiteTesting.Pages.ScissorsManagment.IssuancePage"  MasterPageFile="~/Main.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
    <!DOCTYPE html>
    <html>
    <head>
        <title>Scissors Managment - Issuance</title>
        <link href="assets/style.css" rel="Stylesheet"/>
        <link href="../../assets/css/styleForPage.css" rel="Stylesheet"/>
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--Bootstrap 5-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>        
        <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>

        <script type="text/javascript">
            function searchByWorkerId() {
                var input, filter, table, tr, td, i, txtValue;
                input = document.getElementById("myInput");
                filter = input.value.toUpperCase();
                table = document.getElementById("contentPlaceHolder_tableIssuance");
                tr = table.getElementsByTagName("tr");
                for (i = 1; i < tr.length; i++) {
                    td = tr[i].getElementsByTagName("td")[1];
                    if (td) {
                        txtValue = td.textContent || td.innerText;
                        if (txtValue.toUpperCase().indexOf(filter) > -1) {
                            tr[i].style.display = "";
                        } else {
                            tr[i].style.display = "none";
                        }
                    }
                }
            }
        </script>
    </head>
    <body>
        <div class="container">
            <nav class="breadcrumb breadcrumb_type5" aria-label="Breadcrumb" style="padding: 12px 16px;">
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
                    <span class="breadcrumb__point" aria-current="page">Issuance</span>
                </li>
                </ol>
            </nav>

            <section class="sectionHeader">
                <h1>ISSUANCE</h1>
            </section>

            <div class="row">
                <div class="col-12 col-md-6">

                    <div class="row mt-3 mt-md-0 mt-md-sm-0 mt-lg-0">
                        <div class="col-3 col-md-3 mt-2"><p>Section:</p></div>
                        <div class="col-9 col-md-9">
                            <asp:DropDownList ID="cboSection" CssClass="btn rounded-0 border-dark" runat="server" DataTextField="Name" DataValueField="SectionId"
                                AutoPostBack="true" OnSelectedIndexChanged="cboSection_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                    </div>

                    <div class="row mt-3 mt-md-0 mt-md-sm-0 mt-lg-0">
                        <div class="col-3 col-md-3 mt-2"><p>Line:</p></div>
                        <div class="col-9 col-md-9">
                            <asp:DropDownList ID="cboLine" CssClass="btn rounded-0 border-dark" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboLine_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                    </div>

                    <div class="row mt-3 mt-md-0 mt-md-sm-0 mt-lg-0">
                        <div class="col-3 col-md-3 mt-2"><p>ID No:</p></div>
                        <div class="col-9 col-md-9">
                            <div class="input-group">
                                <asp:TextBox ID="txtWorkerID" CssClass="form-control rounded-0" runat="server" placeholder="Worker Id"></asp:TextBox>
                                <div class="input-group-append">
                                    <asp:Button CssClass="input-group-text btn btn-primary rounded-0" ID="btnWorkerIdOK" runat="server" Text="OK" OnClick="btnWorkerIdOK_Click"/>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-3 mt-md-0 mt-md-sm-0 mt-lg-0 mb-1 mb-md-0 mb-lg-0">
                        <div class="col-3 col-md-3 mt-2"><p>Name:</p></div>
                        <div class="col-9 col-md-9">
                            <asp:TextBox ID="txtWorkerName" CssClass="form-control rounded-0" runat="server" Enabled="false" placeholder="Name"></asp:TextBox>
                        </div>
                    </div>

                    <div class="col" id="cameraArea" style="display:none;" >
                        <div class="row">
                            <div class="col-12 text-center">
                                <video id="video" width="320" height="320"></video>
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

                    <div class="row mt-3">
                        <div class="col-12">
                            <div class="input-group">
                                <asp:TextBox ID="txtSmallScissorsBarcode" CssClass="form-control rounded-0" runat="server" ClientIDMode="Static" placeholder="Scan Small Scissors Barcode"></asp:TextBox>
                                <div class="input-group-append">
                                    <button class="btn btn-lg rounded-0 border" type="button" id="btnScanBarcodeSmallScissors">
                                        <a><i class="fa fa-barcode"></i></a>
				                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-3">
                        <div class="col-12">
                            <div class="input-group">
                                <asp:TextBox ID="txtBigScissorsBarcode" CssClass="form-control rounded-0" runat="server" ClientIDMode="Static" placeholder="Scan Big Scissors Barcode"></asp:TextBox>
                                <div class="input-group-append">
                                    <button class="btn btn-lg rounded-0 border" type="button" id="btnScanBarcodeBigScissors">
                                        <a><i class="fa fa-barcode fa-barcode-big"></i></a>
				                    </button>
                                </div>
                            </div>
                        </div>
                    </div>            

                    <div class="row mt-3 mt-md-0 mt-md-sm-0 mt-lg-0">
                        <div class="col-3">
                            <asp:Button CssClass="btn btn-primary mt-3 rounded-0" ID="btnSave" Enabled="false" runat="server" Text="Save" onclick="btnSave_Click"/>
                        </div>
                    </div>

                </div>
                <div class="col-12 col-md-6 mt-2">
                    <input id="myInput" onkeyup="searchByWorkerId()" type="text" class="form-control rounded-0 mb-1 text-primary" placeholder="Input Worker Id"/>
                    <asp:Table ID="tableIssuance" CssClass="table table-hover table-bordered" runat="server">
                    </asp:Table>
                </div>
            </div>
        </div>

        <script type="text/javascript" src="assets/zxing.js"></script>
        <script type="text/javascript">
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

                    // Big Barcode Click
                    document.getElementById("btnScanBarcodeBigScissors").addEventListener("click", function () {
                        cameraArea.style.display = 'block'
                        codeReader.reset()
                        console.log('Reset.')
                        document.getElementById("txtBigScissorsBarcode").value = ''
                        codeReader.decodeFromVideoDevice(selectedDeviceId, 'video', (result, err) => {
                            if (result) {
                                console.log(result)
                                //document.getElementById('result').textContent = result.text
                                $(document).ready(function () {
                                    document.getElementById("txtBigScissorsBarcode").value = result.text
                                });
                            }
                            if (err && !(err instanceof ZXing.NotFoundException)) {
                                console.error(err)
                                document.getElementById("txtBigScissorsBarcode").value = err
                            }
                        })
                        console.log(`Started continous decode from camera with id ${selectedDeviceId}`)
                    })

                    // Small Barcode Click
                    document.getElementById("btnScanBarcodeSmallScissors").addEventListener("click", function () {
                        cameraArea.style.display = 'block'
                        codeReader.reset()
                        console.log('Reset.')
                        document.getElementById("txtSmallScissorsBarcode").value = ''
                        codeReader.decodeFromVideoDevice(selectedDeviceId, 'video', (result, err) => {
                            if (result) {
                                console.log(result)
                                //document.getElementById('result').textContent = result.text
                                $(document).ready(function () {
                                    document.getElementById("txtSmallScissorsBarcode").value = result.text
                                });
                            }
                            if (err && !(err instanceof ZXing.NotFoundException)) {
                                console.error(err)
                                document.getElementById("txtSmallScissorsBarcode").value = err
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
