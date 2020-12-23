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
            class MaterialCheckModel {
                constructor (orderNoId, poQuantity, labelQuantity, actualQuantity, labelWidth, actualWidth) {
                    this.orderNoId = orderNoId;
                    this.poQuantity = poQuantity;
                    this.labelQuantity = labelQuantity;
                    this.actualQuantity = actualQuantity;
                    this.actualWidth = actualWidth;
                }
            };
            //var toastItemEl = document.querySelector('#myToast');
            //var toast = new bootstrap.Toast(toastItemEl);
            //toast.show();
            function buttonMaterialClick(buttonId, laminationMaterialList, laminationMaterial) {
                // Clear Highlight
                laminationMaterialList.forEach(function (laminationMaterial) {
                    document.getElementById(laminationMaterial.OrderNoId).setAttribute("class", "btn btn-outline-success btn-sm text-dark");
                });
                // highlight button click
                document.getElementById(buttonId).setAttribute("class", "btn btn-danger btn-sm");
                document.getElementById("materialDetailTitle").innerText = laminationMaterial.MaterialName;
                document.getElementById("spPosition").innerText = laminationMaterial.Position;

                const materialCurrentCheck = new MaterialCheckModel(
                    orderNoId       = laminationMaterial.OrderNoId,
                    poQuantity      = laminationMaterial.POQuantity,
                    labelQuantity   = 0,
                    actualQuantity  = 0,
                    labelWidth      = 0,
                    actualWidth     = 0
                );
                document.getElementById("btnStart").onclick = function () { buttonStartClick(materialCurrentCheck) };
                return false;
            }

            function buttonStartClick(materialCurrentCheck) {
                alert(materialCurrentCheck.poQuantity);
                $('#btnCloseModelInputMaterialDetail').click();
                return false;
            }

            // Get
            function Search() {
                $.ajax({
                    url: '<%= ResolveUrl("~/Pages/WHLamination/WHLaminationHome.aspx/GetByOrderNo") %>',
                    data: { "orderNo": '"' + $('#txtOrderNoBarcode').val() + '"' },
                    type: "GET",
                    datatype: "json",
                    async: true,
                    contentType: "application/json; charset=utf-8",
                    success: OnSuccess,
                    error: onError
                });
            }

            function OnSuccess(data) {
                $('#btnCloseModel').click();
                const divMatsList = document.getElementById("divMatsList");
                divMatsList.innerHTML = '';

                //alert(data.d);
                if (data.d === "This PO does not exist in system !")
                {
                    $('#txtOrderNoBarcode').focus();
                    $('#txtOrderNoBarcode').select();
                    return;
                }                

                // Clear lamination material list
                var laminationMaterialList = JSON.parse(data.d);
                laminationMaterialList.forEach(function (laminationMaterial) {
                    const matDiv = document.createElement("div");
                    matDiv.className = "col";

                    const matButton = document.createElement("button");
                    matButton.type = "button";
                    matButton.className = "btn btn-outline-success btn-sm text-dark";
                    matButton.setAttribute("role", "group");
                    matButton.setAttribute("data-bs-toggle", "modal");
                    matButton.setAttribute("data-bs-target", "#modalInputMaterialDetail");
                    matButton.id = laminationMaterial.OrderNoId;
                    matButton.textContent = laminationMaterial.MaterialName;
                    matButton.onclick = function () { buttonMaterialClick(matButton.id, laminationMaterialList, laminationMaterial) };

                    const matSpan = document.createElement("span");
                    matSpan.className = "badge bg-info text-dark ml-1";
                    matSpan.textContent = laminationMaterial.Position;

                    matDiv.appendChild(matButton);
                    matButton.appendChild(matSpan);

                    divMatsList.appendChild(matDiv);
                //}
                });
                
            }
            function onError() {
                alert('Failed !');
            }
        </script>
    </head>
    <html lang="en">
        <body>
            <%--<asp:ScriptManager ID="scriptManagerWHLamination" runat="server" EnablePageMethods="true"/>--%>
            <div class="container-fluid" style="min-height: 100vh;">
                <div class="row text-center align-content-center">
                    <h2>WH Lamination</h2>
                </div>
                <div class="row">
                    <div class="col-12 col-sm-4">
                        <div class="input-group-append">
                            <button class="btn btn-lg rounded-0 border" type="button" id="btnScanBarcode"  data-bs-toggle="modal" data-bs-target="#modalBarcodeScan">
                                <a><i class="fa fa-barcode"></i></a>
				            </button>
                            <%--<asp:TextBox ID="txtOrderNoBarcode" CssClass="form-control rounded-0" runat="server" ClientIDMode="Static" placeholder="Scan Barcode"></asp:TextBox>--%>
                            <input id="txtOrderNoBarcode" class="form-control rounded-0" placeholder="Scan Barcode"></input>
                            <%--<asp:Button CssClass="btn btn-primary rounded-0" ID="btnSearchByOrderNo" runat="server" OnClientClick="btnSearchByOrderNoClick()" Text="OK"/>--%>
                            <button class="btn btn-primary rounded-0" id="btnSearchByOrderNo" onclick="Search(); return false;">Search</button>
                        </div>
                        
                        <div id="divMatsList" class="row row-cols-auto g-1 mt-1">
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
                                    //document.getElementById("btnCloseModel").addEventListener("click", function () {
                                    //    codeReader.reset()
                                    //    console.log('Reset.')
                                    //    document.getElementById("txtOrderNoBarcode").value = ''
                                    //})
                                })
                                .catch((err) => {
                                    console.error(err)
                                })
                            //})
                        </script>

                    </div>

                    <div class="col-12 col-sm-8">
                        
                    </div>
                </div>
            </div>
            
            <!-- Modal Scan Barcode -->
            <div class="modal fade" id="modalBarcodeScan" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modelBarcodeTitle" aria-hidden="true">
                <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                    <h5 class="modal-title" id="modelBarcodeTitle">Scan barcode</h5>
                    <button type="button" id="btnCloseModel" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
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
            <!-- Modal Input Material Quantity-->
            <div class="modal fade" id="modalInputMaterialDetail" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="materialDetailTitle" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="mr-2"><span id="spPosition" class="badge bg-info text-dark"></span></h5>
                    <h6 class="modal-title" id="materialDetailTitle">Input Quantity</h6>
                    <button id="btnCloseModelInputMaterialDetail" type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body pt-0">
                      <form>
                          <div class="mb-1">
                            <label for="txtLabelQuantity" class="col-form-label">Label Quantity</label>
                            <input type="text" class="form-control" id="txtLabelQuantity">
                          </div>
                          <div class="mb-1">
                            <label for="txtActualQuantity" class="col-form-label">Actual Quantity</label>
                            <input type="text" class="form-control" id="txtActualQuantity">
                          </div>
                          <div class="mb-1">
                            <label for="txtLabelWidth" class="col-form-label">Label Width</label>
                            <input type="text" class="form-control" id="txtLabelWidth">
                          </div>
                          <div>
                            <label for="txtActualWidth" class="col-form-label">Actual Width</label>
                            <input type="text" class="form-control" id="txtActualWidth">
                          </div>
                        </form>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button id="btnStart" type="button" class="btn btn-success">Start</button>
                  </div>
                </div>
              </div>
            </div>

        </body>
    </html>
</asp:Content>

