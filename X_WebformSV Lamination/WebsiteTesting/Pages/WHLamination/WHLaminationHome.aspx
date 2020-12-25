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
            class LaminationMaterialScore {
                constructor(OrderNoId, POQuantity, LabelQuantity, ActualQuantity, LabelWidth, ActualWidth, TotalScore, DefectType1, DefectType2, DefectType3, DefectType4, HoleType2, HoleType4, Reviser) {
                    this.OrderNoId = OrderNoId;
                    this.PoQuantity = POQuantity;
                    this.LabelQuantity = LabelQuantity;
                    this.ActualQuantity = ActualQuantity;
                    this.LabelWidth = LabelWidth;
                    this.ActualWidth = ActualWidth;
                    this.DefectType1 = DefectType1;
                    this.DefectType2 = DefectType2;
                    this.DefectType3 = DefectType3;
                    this.DefectType4 = DefectType4;

                    this.HoleType2 = HoleType2;
                    this.HoleType4 = HoleType4;
                    this.Reviser = Reviser;
                }
                // function cal score.
                calScore() {
                    this.TotalScore = this.DefectType1 + this.DefectType2 * 2 + this.DefectType3 * 3 + this.DefectType4 * 4 + this.HoleType2 * 2 + this.HoleType4 * 4;
                }
            };

            function buttonMaterialClick(buttonId, laminationMaterialList, lamiMatsSelected) {
                DisplayMatsInfor(null, null);
                // Clear Highlight
                laminationMaterialList.forEach(function (lamiMats) {
                    document.getElementById(lamiMats.OrderNoId).setAttribute("class", "btn btn-outline-success btn-sm text-dark text-wrap text-left");
                });
                // highlight button click
                document.getElementById(buttonId).setAttribute("class", "btn btn-danger btn-sm text-wrap text-left");
                document.getElementById("materialDetailTitle").innerText = lamiMatsSelected.MaterialName;
                document.getElementById("spPosition").innerText = lamiMatsSelected.Position;

                const matsScoreFirst = new LaminationMaterialScore(
                    OrderNoId = lamiMatsSelected.OrderNoId,
                    POQuantity = lamiMatsSelected.POQuantity,
                    LabelQuantity   = 0,
                    ActualQuantity  = 0,
                    LabelWidth      = 0,
                    ActualWidth = 0,
                    DefectType1 = 0,
                    DefectType2 = 0,
                    DefectType3 = 0,
                    DefectType4 = 0,
                    HoleType2 = 0,
                    HoleType4 = 0,
                    Reviser = "it02"
                );

                $.ajax({
                    url: '<%= ResolveUrl("~/Pages/WHLamination/WHLaminationHome.aspx/GetScoreByOrderNoId") %>',
                    data: { "orderNoId": '"' + buttonId + '"' },
                    type: "GET",
                    datatype: "json",
                    async: true,
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d.toString().includes('Exception:')) {
                            alert(data.d);
                        }
                        // matsScore is first time
                        else if (data.d === '[]') {
                            DispayModalData(matsScoreFirst);
                            document.getElementById("btnStart").onclick = function () { buttonStartClick(matsScoreFirst, lamiMatsSelected) };
                        }
                        // already matsScore already check
                        else {
                            const matsScoreCurrentCheck = JSON.parse(data.d);
                            if (matsScoreCurrentCheck != null) {
                                DispayModalData(matsScoreCurrentCheck);
                                document.getElementById("btnStart").onclick = function () { buttonStartClick(matsScoreCurrentCheck, lamiMatsSelected) };
                            }
                        }
                    },
                    error: onError
                });

                return false;
            }

            function buttonStartClick(matsScore, lamiMatsSelected) {
                var regexNumber = /^\d+$/;

                // validate
                var labelQty = document.getElementById('txtLabelQuantity');
                labelQty.classList.remove('is-invalid');
                var actualQty = document.getElementById('txtActualQuantity');
                actualQty.classList.remove('is-invalid');
                var labelWidth = document.getElementById('txtLabelWidth');
                labelWidth.classList.remove('is-invalid');
                var actualWidth = document.getElementById('txtActualWidth');
                actualWidth.classList.remove('is-invalid');

                var validateResult = true;
                if (!regexNumber.test(labelQty.value.toString())) {
                    labelQty.classList.add('is-invalid');
                    validateResult = false;
                }

                if (actualQty.value <= 0 || actualQty.value > lamiMatsSelected.POQuantity || !regexNumber.test(actualQty.value.toString())) {
                    actualQty.classList.add('is-invalid');
                    validateResult = false;
                }
                if (!regexNumber.test(labelWidth.value.toString())) {
                    labelWidth.classList.add('is-invalid');
                    validateResult = false;
                }
                if (!regexNumber.test(actualWidth.value.toString())) {
                    actualWidth.classList.add('is-invalid');
                    validateResult = false;
                }
                if (!validateResult) {
                    return;
                }

                matsScore.LabelQuantity = labelQty.value;
                matsScore.ActualQuantity = actualQty.value;
                matsScore.LabelWidth = labelWidth.value;
                matsScore.ActualWidth = actualWidth.value;

                DisplayMatsInfor(matsScore, lamiMatsSelected);
                // Display divScore
                const divScore = document.getElementById('divScore');
                divScore.style.display = 'block';

                // Clode Modal
                $('#btnCloseModelInputMaterialDetail').click();
                return false;
            }

            function DispayModalData(matsScore) {
                const txtLabelQuantity = document.getElementById('txtLabelQuantity');
                txtLabelQuantity.setAttribute('class', 'form-control');
                txtLabelQuantity.value = '';

                const txtActualQuantity = document.getElementById('txtActualQuantity');
                txtActualQuantity.setAttribute('class', 'form-control');
                txtActualQuantity.value = '';

                const txtLabelWidth = document.getElementById('txtLabelWidth');
                txtLabelWidth.setAttribute('class', 'form-control');
                txtLabelWidth.value = '';

                const txtActualWidth = document.getElementById('txtActualWidth');
                txtActualWidth.setAttribute('class', 'form-control');
                txtActualWidth.value = '';

                if (matsScore != null) {
                    if (matsScore.LabelQuantity != 0) {
                        txtLabelQuantity.value = matsScore.LabelQuantity;
                    }
                    if (matsScore.ActualQuantity != 0) {
                        txtActualQuantity.value = matsScore.ActualQuantity;
                    }
                    if (matsScore.LabelWidth != 0) {
                        txtLabelWidth.value = matsScore.LabelWidth;
                    }
                    if (matsScore.ActualWidth != 0) {
                        txtActualWidth.value = matsScore.ActualWidth;
                    }
                }
            }

            function DisplayMatsInfor(matsScore, lamiMatsSelected) {
                const divMatsInfor = document.getElementById('divMatsInfor');
                divMatsInfor.style.display = 'none';
                const divScore = document.getElementById('divScore');
                divScore.style.display = 'none';

                // Reset Value
                const pMatsName = document.getElementById('pMatsName');
                pMatsName.innerHTML = '';
                const divMatsInforColumn1 = document.getElementById('divMatsInforColumn1');
                divMatsInforColumn1.innerHTML = '';
                const divMatsInforColumn2 = document.getElementById('divMatsInforColumn2');
                divMatsInforColumn2.innerHTML = '';
                const divMatsInforColumn3 = document.getElementById('divMatsInforColumn3');
                divMatsInforColumn3.innerHTML = '';
                const divMatsInforRow2 = document.getElementById('divMatsInforRow2');
                divMatsInforRow2.innerHTML = '';
                const divMatsInforColumn31 = document.getElementById('divMatsInforColumn31');
                divMatsInforColumn31.innerHTML = '';
                const divMatsInforColumn32 = document.getElementById('divMatsInforColumn32');
                divMatsInforColumn32.innerHTML = '';
                const divMatsInforColumn33 = document.getElementById('divMatsInforColumn33');
                divMatsInforColumn33.innerHTML = '';

                // Binding data
                if (lamiMatsSelected != null) {
                    const divMatsInfor = document.getElementById('divMatsInfor');
                    divMatsInfor.style.display = 'block';

                    pMatsName.innerText = lamiMatsSelected.MaterialName;

                    const liOrderNo = document.createElement("li");
                    liOrderNo.innerText = 'OrderNo: ' + lamiMatsSelected.OrderNo;
                    const liArticle = document.createElement("li");
                    liArticle.innerText = 'ArticleNo: ' + lamiMatsSelected.ArticleNo;

                    divMatsInforColumn1.appendChild(liOrderNo);
                    divMatsInforColumn1.appendChild(liArticle);

                    const liPatternNo = document.createElement("li");
                    liPatternNo.innerText = 'PatternNo: ' + lamiMatsSelected.PatternNo;
                    const liPosition = document.createElement("li");
                    liPosition.innerText = 'Positon: ' + lamiMatsSelected.Position;

                    divMatsInforColumn2.appendChild(liPatternNo);
                    divMatsInforColumn2.appendChild(liPosition);

                    const liPart = document.createElement("li");
                    liPart.innerText = 'Part: ' + lamiMatsSelected.MaterialPart;

                    const liUnit = document.createElement("li");
                    liUnit.innerText = 'Unit: ' + lamiMatsSelected.Unit;

                    divMatsInforColumn3.appendChild(liPart);
                    divMatsInforColumn3.appendChild(liUnit);

                    const liShoeName = document.createElement("li");
                    liShoeName.innerText = 'ShoeName: ' + lamiMatsSelected.ShoeName;

                    const liPOList = document.createElement("li");
                    liPOList.innerText = 'ProductNoList: ' + lamiMatsSelected.ProductNoList;

                    divMatsInforRow2.appendChild(liShoeName);
                    divMatsInforRow2.appendChild(liPOList);

                    const liPOQuantity = document.createElement("li");
                    liPOQuantity.innerText = 'Product Quantity: ' + lamiMatsSelected.POQuantity;

                    const liSendQuantity = document.createElement("li");
                    liSendQuantity.innerText = 'Send Quantity: ' + lamiMatsSelected.SendQuantity;

                    divMatsInforColumn31.appendChild(liPOQuantity);
                    divMatsInforColumn31.appendChild(liSendQuantity);
                }
                if (matsScore != null) {
                    const liLabelQuantity = document.createElement("li");
                    liLabelQuantity.innerText = 'Label Quantity: ' + matsScore.LabelQuantity;

                    const liActualQuantity = document.createElement("li");
                    liActualQuantity.innerText = 'Actual Quantity: ' + matsScore.ActualQuantity;

                    divMatsInforColumn32.appendChild(liLabelQuantity);
                    divMatsInforColumn32.appendChild(liActualQuantity);

                    const liLabelWidth = document.createElement("li");
                    liLabelWidth.innerText = 'Label Width: ' + matsScore.LabelWidth;

                    const liActualWidth = document.createElement("li");
                    liActualWidth.innerText = 'Actual Width: ' + matsScore.ActualWidth;

                    divMatsInforColumn33.appendChild(liLabelWidth);
                    divMatsInforColumn33.appendChild(liActualWidth);
                }
            }
            
            // Get
            function Search() {
                DisplayMatsInfor(null, null);

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

                if (data.d === "This PO does not exist in system !")
                {
                    $('#txtOrderNoBarcode').focus();
                    $('#txtOrderNoBarcode').select();
                    return;
                }
                else if (data.d.toString().includes('Exception:')) {
                    alert(data.d);
                    return;
                }

                // Clear lamination material list
                var laminationMaterialList = JSON.parse(data.d);
                laminationMaterialList.forEach(function (laminationMaterial) {
                    const matDiv = document.createElement("div");
                    matDiv.className = "col";

                    const matButton = document.createElement("button");
                    matButton.type = "button";
                    matButton.className = "btn btn-outline-success btn-sm text-dark text-wrap text-left";
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
                alert('An error occured at the backend !');
            }
        </script>
    </head>
    <html lang="en">
        <body>
            <%--<asp:ScriptManager ID="scriptManagerWHLamination" runat="server" EnablePageMethods="true"/>--%>
            <div class="container-fluid" style="min-height: 100vh;">
                <div class="row text-center align-content-center" style="min-height: 10vh;">
                    <h2>WH Lamination</h2>
                </div>

                <div class="row g-1">
                    <div class="col-12 col-sm-4">
                        <div class="input-group-append">
                            <button class="btn btn-lg rounded-0 border" type="button" id="btnScanBarcode"  data-bs-toggle="modal" data-bs-target="#modalBarcodeScan">
                                <a><i class="fa fa-barcode"></i></a>
				            </button>
                            <input id="txtOrderNoBarcode" class="form-control rounded-0" placeholder="Scan Barcode"></input>
                            <button class="btn btn-primary rounded-0" id="btnSearchByOrderNo" onclick="Search(); return false;">Search</button>
                        </div>
                        
                        <div id="divMatsList" class="row row-cols-auto g-1 mt-1 overflow-auto"style="min-height:35vh; max-height:35vh;">
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

                    <div id="divMatsInfor" class="col-12 col-sm-8" style="display:none;">
                        <div class="card" >
                          <div class="card-header small">
                              <div class="row g-0">
                                  <div class="col">
                                      <p id="pMatsName" class="m-0 p-0 text-danger">Material Description</p>
                                  </div>
                                  <div class="col-auto">
                                      Toast Area
                                  </div>
                              </div>

                          </div>
                          <div class="card-body overflow-auto small" style="min-height:35vh; max-height:35vh;">
                              <div class="row g-1">
                                  <div id="divMatsInforColumn1" class="col-12 col-sm-4">
                                  </div>
                                  <div id="divMatsInforColumn2" class="col-12 col-sm-4">
                                  </div>
                                  <div id="divMatsInforColumn3" class="col-12 col-sm-4">
                                  </div>
                              </div>
                              <div id="divMatsInforRow2" class="row">
                                  
                              </div>
                              <hr>
                              <div class="row g-1">
                                  <div id="divMatsInforColumn31" class="col-12 col-sm-4">
                                  </div>
                                  <div id="divMatsInforColumn32" class="col-12 col-sm-4">
                                  </div>
                                  <div id="divMatsInforColumn33" class="col-12 col-sm-4">
                                  </div>
                              </div>
                          </div>
                        </div>
                    </div>
                </div>

                <div id="divScore" class="row mt-1" style="display:none;">
                    <div class="col">
                        <div class="card" >
                            <div class="card-body overflow-auto " style="min-height:45vh; max-height:45vh;">
                                <div class="row g-0">
                                    <div class="col-12 col-sm-8">
                                        <div class="row g-2">
                                            <div class="col-3">
                                                <button id="btnDefectType1" type="button" class="btn btn-outline-danger btn-lg rounded-2 shadow-lg p-4 w-100">1</button>
                                            </div>
                                            <div class="col-3">
                                                <button type="button" class="btn btn-outline-danger btn-lg rounded-2 shadow-lg p-4 w-100">2</button>
                                            </div>
                                            <div class="col-3">
                                                <button type="button" class="btn btn-outline-danger btn-lg rounded-0 shadow-lg p-4 w-100">3</button>
                                            </div>
                                            <div class="col-3">
                                                <button type="button" class="btn btn-outline-danger btn-lg rounded-0 shadow-lg p-4 w-100">4</button>
                                            </div>
                                        </div>

                                        <div class="row g-2 mt-1">
                                            <div class="col-3">
                                            </div>
                                            <div class="col-3">
                                                <button type="button" class="btn btn-outline-info btn-lg rounded-2 shadow-lg p-4 w-100">2</button>
                                            </div>
                                            <div class="col-3">
                                                <button type="button" class="btn btn-outline-info btn-lg rounded-2 shadow-lg p-4 w-100">3</button>
                                            </div>
                                            <div class="col-3">
                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-12 col-sm-4"></div>
                                </div>
                            </div>
                        </div>
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
                  <div class="modal-body">
                      <div class="form-floating mb-1">
                          <input class="form-control" id="txtLabelQuantity" placeholder=" ">
                          <label for="txtLabelQuantity">Label Quantity</label>
                      </div>
                      <div class="form-floating mb-1">
                          <input class="form-control" id="txtActualQuantity" placeholder=" ">
                          <label for="txtActualQuantity">Actual Quantity</label>
                      </div>
                      <div class="form-floating mb-1">
                          <input class="form-control" id="txtLabelWidth" placeholder=" ">
                          <label for="txtLabelWidth">Label Width</label>
                      </div>
                      <div class="form-floating mb-1">
                          <input class="form-control" id="txtActualWidth" placeholder=" ">
                          <label for="txtActualWidth">Actual Width</label>
                      </div>
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

