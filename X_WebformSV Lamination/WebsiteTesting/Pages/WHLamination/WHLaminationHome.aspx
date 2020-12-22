<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WHLaminationHome.aspx.cs" Inherits="WebsiteTesting.Pages.WHLamination.WHLaminationHome" MasterPageFile="~/Main.Master"  %>
<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
<!DOCTYPE html>
    <head>
        <title>WH Lamination</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
        
        <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
        
        <script type="text/javascript">
            // Get
            function Search() {
                var orderNoFromClient = document.getElementById('txtOrderNoBarcode').value;
                $.ajax({
                    url: '<%= ResolveUrl("~/Pages/WHLamination/WHLaminationHome.aspx/GetByOrderNo") %>',
                    data: { orderNo: orderNoFromClient },
                    //data: '{"orderNo":"' + orderNoFromClient + '"}',
                    type: "GET",
                    contentType: "application/json; charset=utf-8",
                    success: OnSuccess,
                    error: onError
                });
            }
            function OnSuccess(data) {
                document.getElementById('btnXModal').click();
                alert(data.d);
            }
            function onError() {
                alert('Failed!');
            }
        </script>
    </head>
    <html lang="en">
        <body>
            <%--<asp:ScriptManager ID="scriptManagerWHLamination" runat="server" EnablePageMethods="true"/>--%>
            <div class="container-fluid" style="min-height: 100vh;">
                <div class="row text-center align-content-center">
                    <h3>WH Lamination</h3>
                </div>
                <div class="row">
                    <div class="col-4">
                        <!-- Button trigger modal -->
                        <div class="input-group-append">
                            <button class="btn btn-lg rounded-0 border" type="button" id="btnScanBarcode"  data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                                <a><i class="fa fa-barcode"></i></a>
				            </button>
                            <%--<asp:TextBox ID="txtOrderNoBarcode" CssClass="form-control rounded-0" runat="server" ClientIDMode="Static" placeholder="Scan Barcode"></asp:TextBox>--%>
                            <input id="txtOrderNoBarcode" class="form-control rounded-0" placeholder="Scan Barcode"></input>
                            <%--<asp:Button CssClass="btn btn-primary rounded-0" ID="btnSearchByOrderNo" runat="server" OnClientClick="btnSearchByOrderNoClick()" Text="OK"/>--%>
                            <button class="btn btn-primary rounded-0" id="btnSearchByOrderNo" onclick="Search(); return false;" >Search</button>
                        </div>
                        <!-- Modal -->
                        <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                          <div class="modal-dialog">
                            <div class="modal-content">
                              <div class="modal-header">
                                <h5 class="modal-title" id="staticBackdropLabel">Scan barcode</h5>
                                <button type="button" id="btnXModal" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                              </div>
                              <div class="modal-body">
                                <div class="container text-center">
                                    <video id="video" width="320" height="320"></video>
                                </div>
                              </div>
                              <div class="modal-footer">
                                <div class="row" id="sourceSelectPanel" style="display:none">
                                    <div class="input-group">
                                        <label for="sourceSelect" class="mt-1">Select Camera:</label>
                                        <div class="input-group-append ml-2">
                                            <select id="sourceSelect" style="max-width:400px">
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                              </div>
                            </div>
                          </div>
                        </div>

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
                                    
                                    if (videoInputDevices.length >= 1) {
                                        videoInputDevices.forEach((element) => {
                                            const sourceOption = document.createElement('option')
                                            sourceOption.text = element.label
                                            sourceOption.value = element.deviceId
                                            sourceSelect.appendChild(sourceOption)
                                        })

                                        sourceSelect.onchange = () => {
                                            selectedDeviceId = sourceSelect.value;
                                            codeReader.reset()
                                            console.log('Reset.')
                                            document.getElementById("txtOrderNoBarcode").value = ''
                                            codeReader.decodeFromVideoDevice(selectedDeviceId, 'video', (result, err) => {
                                                if (result) {
                                                    console.log(result)
                                                    $(document).ready(function () {
                                                        document.getElementById("txtOrderNoBarcode").value = result.text
                                                        // Click OK Button
                                                        <%--document.getElementById('<%= btnSearchByOrderNo.ClientID %>').click();--%>
                                                        document.getElementById('btnSearchByOrderNo').click();
                                                        codeReader.reset();
                                                    });
                                                }
                                                if (err && !(err instanceof ZXing.NotFoundException)) {
                                                    console.error(err)
                                                    document.getElementById("txtOrderNoBarcode").value = err
                                                }
                                            })
                                            console.log(`Started continous decode from camera with id ${selectedDeviceId}`)
                                        };

                                        const sourceSelectPanel = document.getElementById('sourceSelectPanel')
                                        sourceSelectPanel.style.display = 'block'
                                    }

                                    // Barcode Button Click
                                    document.getElementById("btnScanBarcode").addEventListener("click", function () {
                                        codeReader.reset()
                                        console.log('Reset.')
                                        document.getElementById("txtOrderNoBarcode").value = ''
                                        codeReader.decodeFromVideoDevice(selectedDeviceId, 'video', (result, err) => {
                                            if (result) {
                                                console.log(result)
                                                $(document).ready(function () {
                                                    document.getElementById("txtOrderNoBarcode").value = result.text
                                                    // Click OK Button
                                                    document.getElementById('btnSearchByOrderNo').click();
                                                    codeReader.reset();
                                                });
                                            }
                                            if (err && !(err instanceof ZXing.NotFoundException)) {
                                                console.error(err)
                                                document.getElementById("txtOrderNoBarcode").value = err
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

                    </div>

                    <div class="col-8">
                        <%--<div class="panel panel-default">
                          <div class="panel-heading bg-danger">Panel heading without title</div>
                          <div class="panel-body border-success p-2">
                            Panel content blah <br/>blah <br/>blah <br/>blah <br/>blah <br/>blah <br/>blah <br/>blah <br/>blah <br/>blahblah <br/>blah <br/>blah <br/>blah <br/>blah <br/>blah <br/>blah <br/>blah <br/>blah <br/>blah
                          </div>
                        </div>--%>
                    </div>
                </div>
            </div>
        </body>
    </html>
</asp:Content>

