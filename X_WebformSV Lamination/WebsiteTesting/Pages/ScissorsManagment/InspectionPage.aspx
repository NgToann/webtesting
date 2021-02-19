<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InspectionPage.aspx.cs" Inherits="WebsiteTesting.Pages.ScissorsManagment.InspectionPage" MasterPageFile="~/Main.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
    <!DOCTYPE html>
    <html>
    <head>
        <title>Scissors Managment - Inspection</title>
        <link href="../../assets/css/styleForPage.css" rel="Stylesheet"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>        
        <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script> 
    </head>
    <body>
        <div class="container SVContent">
            <nav class="breadcrumb breadcrumb_type5" aria-label="Breadcrumb" style="padding: 12px 16px !important;">
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
                                <button class="btn btn-lg rounded-0 border" type="button" id="btnScanScissorsBarcode" data-bs-toggle="modal" data-bs-target="#modalBarcodeScan">
                                    <a><i class="fa fa-barcode"></i></a>
				                </button>
                                <%--<asp:TextBox ID="txtScissorsBarcode" CssClass="form-control rounded-0" runat="server" ClientIDMode="Static" placeholder="Scan Barcode"></asp:TextBox>--%>
                                <input id="txtScissorsBarcode" onkeyup="searchByWorkerId()" type="text" class="form-control rounded-0">
                                <input type="button" class="btn btn-primary rounded-0" id="btnSave" value="Save"/>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-3">
                        <div class="col">
                            <input id="myInput" onkeyup="searchByWorkerId()" type="text" class="form-control rounded-0 mb-1 text-primary" placeholder="Input Worker Id or Barcode" >
                            <table id="tableInspection" class="table table-hover table-bordered">
                                <%--<thead>
                                    <tr>
                                      <th class="bg-success" scope="col">#</th>
                                      <th scope="col">First</th>
                                      <th class="bg-danger" scope="col">Last</th>
                                      <th scope="col">Handle</th>
                                    </tr>
                                </thead>--%>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <!-- Modal Scan Barcode -->
        <div class="modal fade m-auto" id="modalBarcodeScan" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modelBarcodeTitle" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-primary" id="modelBarcodeTitle">Scan barcode or qrcode</h5>
                        <button type="button" id="btnCloseModel" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center">
                            <video id="video" width="320" height="320"></video>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="row w-100 text-left align-items-center">
                            <div class="input-group">
                                <label for="sourceSelect" class="mt-1 mr-2">Camera:  </label>
                                <select id="sourceSelect" class="form-select custom-select-sm rounded-0" style="max-width:400px; font-size: 0.85rem;"></select>
                            </div>
                        </div>                        
                    </div>                        
                </div>
            </div>
        </div>

        <script src="assets/zxing.js"></script>
        <script type="text/javascript" language="javascript">
            function searchByWorkerId() {
                var barcodeScanning = document.getElementById('txtScissorsBarcode').value;
                var input, filter, table, tr, td, tdBig, tdSmall, i, txtValue;
                input = document.getElementById("myInput");
                filter = input.value.toUpperCase();
                if (barcodeScanning != '')
                    filter = barcodeScanning;
                table = document.getElementById("tableInspection");
                tr = table.getElementsByTagName("tr");
                for (i = 1; i < tr.length; i++) {
                    td      = tr[i].getElementsByTagName("td")[1];
                    tdBig   = tr[i].getElementsByTagName("td")[3];
                    tdSmall = tr[i].getElementsByTagName("td")[4];

                    if (td) {
                        txtValue = td.textContent || td.innerText;
                        if (txtValue.toUpperCase().indexOf(filter) > -1) {
                            tr[i].style.display = "";
                        }
                        else {
                            if (tdBig) {
                                txtValue = tdBig.textContent || tdBig.innerText;
                                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                                    tr[i].style.display = "";
                                }
                                else {
                                    if (tdSmall) {
                                        txtValue = tdSmall.textContent || tdSmall.innerText;
                                        if (txtValue.toUpperCase().indexOf(filter) > -1) {
                                            tr[i].style.display = "";
                                        }
                                        else
                                            tr[i].style.display = "none";
                                    }
                                }
                            }
                        }
                    }
                }
            }
            var releaseScissorsList;
            var userLogin;
            window.addEventListener('load', function () {
                // Load Data Inspection ToDay
                $.ajax({
                    url: '<%= ResolveUrl("~/Pages/ScissorsManagment/InspectionPage.aspx/LoadInspectionToDay") %>',
                    data: {},
                    type: "GET",
                    datatype: "json",
                    async: true,
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d.toString().includes('Exception:')) {
                            alert(data.d);
                        }
                        else if (data.d === '[]') {
                            alert(data.d);
                        }
                        else {
                            //alert(data.d);
                            var sources = JSON.parse(data.d);
                            releaseScissorsList = sources[2];
                            userLogin = sources[3];
                            updateDataTable(sources[0], releaseScissorsList);
                        }
                    },
                    error: onError
                })
            });
            function onError() {
                alert('An error occured at the backend !');
            };

            class InspectionModel {
                constructor(WorkerId, WorkerName, Barcode, InspectionDate, Section, Line, Inspector) {
                    this.WorkerId       = WorkerId;
                    this.WorkerName     = WorkerName;
                    this.Barcode        = Barcode;
                    this.InspectionDate = InspectionDate;
                    this.Section        = Section;
                    this.Line           = Line;
                    this.Inspector      = Inspector;
                }
            }

            function scanScissors(inspectionListToDay, releaseScissorsList) {
                var barcodeScanned = document.getElementById('txtScissorsBarcode').value;
                if (barcodeScanned === '') {
                    alert('Scissors barcode is empty !');
                    return;
                }
                var checkExist = inspectionListToDay.filter(f => f.Barcode == barcodeScanned);
                if (checkExist.length > 0) {
                    alert('This scissors has been scanned !');
                    return;
                }

                var releaseByBarcode = releaseScissorsList.filter(f => f.Barcode == barcodeScanned);
                if (releaseByBarcode.length == 0) {
                    alert('This scissors does not exist in release list !');
                    return;
                }

                var inspectionScann = new InspectionModel(
                    WorkerId    = releaseByBarcode[0].WorkerId,
                    WorkerName  = releaseByBarcode[0].WorkerName,
                    Barcode     = releaseByBarcode[0].Barcode,
                    InspectionDate = '',
                    Section     = '',
                    Line        = '',
                    Inspector   = userLogin
                );
                var uploadContent = JSON.stringify({ uploadModel: inspectionScann });
                $.ajax({
                    url: '<%= ResolveUrl("~/Pages/ScissorsManagment/InspectionPage.aspx/ScanScissors") %>',
                    data: {
                        "workerId": '"' + inspectionScann.WorkerId + '"',
                        "workerName": '"' + inspectionScann.WorkerName + '"',
                        "barcode": '"' + inspectionScann.Barcode + '"',
                        "inspector": '"' + inspectionScann.Inspector + '"'
                    },
                    //data: uploadContent,
                    type: "GET",
                    datatype: "json",
                    async: true,
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d.toString().includes('Exception:')) {
                            alert(data.d);
                        }
                        else {
                            inspectionListToDay.push(inspectionScann);
                            updateDataTable(inspectionListToDay, releaseScissorsList);
                            alert(data.d);
                            searchByWorkerId();
                        }
                    },
                    error: onError
                })
            }

            function updateDataTable(inspectionListToDay, releaseScissorsList) {
                
                const workerIdList = [];
                const map = new Map();
                var tableInspection = document.getElementById("tableInspection");
                // Clear value
                tableInspection.innerHTML = "";
                // Add Header
                var thHeader = document.createElement('thead')
                var trHeader = document.createElement('tr');
                trHeader.className = 'border-bottom-color';

                var thNoOf = document.createElement('th');
                thNoOf.innerHTML = 'No';
                thNoOf.classList.add('text-center');

                var thWorkerId = document.createElement('th');
                thWorkerId.innerHTML = 'Worker ID';

                var thWorkerName = document.createElement('th');
                thWorkerName.innerHTML = 'Worker Name';

                var thBig = document.createElement('th');
                thBig.innerHTML = 'Big';
                thBig.classList.add('text-center');

                var thSmall = document.createElement('th');
                thSmall.innerHTML = 'Small';
                thSmall.classList.add('text-center');

                trHeader.appendChild(thNoOf);
                trHeader.appendChild(thWorkerId);
                trHeader.appendChild(thWorkerName);
                trHeader.appendChild(thSmall);
                trHeader.appendChild(thBig);

                thHeader.appendChild(trHeader);

                tableInspection.appendChild(thHeader);

                inspectionListToDay.forEach(function (item) {
                    if (!map.has(item.WorkerId)) {
                        map.set(item.WorkerId, true);    // set any value to Map
                        workerIdList.push({
                            WorkerId: item.WorkerId,
                            WorkerName: item.WorkerName
                        });
                    }
                });

                var tbody = document.createElement('tbody');
                var i = 1;
                workerIdList.forEach(function (item) {

                    var tr = document.createElement('tr');

                    var tdBodyNo = document.createElement('td');
                    tdBodyNo.innerText = i;
                    tdBodyNo.classList.add('text-center');

                    var tdWorkerId = document.createElement('td');
                    tdWorkerId.innerText = item.WorkerId;

                    var tdWorkerName = document.createElement('td');
                    tdWorkerName.innerText = item.WorkerName;

                    var tdBig = document.createElement('td');
                    tdBig.innerText = '';
                    tdBig.classList.add('text-center');

                    var tdSmall = document.createElement('td');
                    tdSmall.innerText = '';
                    tdSmall.classList.add('text-center');

                    var scissorsWorkerBorrow = releaseScissorsList.filter(f => f.WorkerId == item.WorkerId);
                    if (scissorsWorkerBorrow.length > 0) {
                        var bigScissors     = scissorsWorkerBorrow.filter(f => f.ScissorsType == 'Big');
                        var smallScissors   = scissorsWorkerBorrow.filter(f => f.ScissorsType == 'Small');

                        if (bigScissors.length > 0) {
                            tdBig.innerText = bigScissors[0].Barcode;
                            var checkInspected = inspectionListToDay.filter(f => f.Barcode == bigScissors[0].Barcode);
                            if (checkInspected.length == 0)
                                tdBig.classList.add('bg-danger');
                            else
                                tdBig.classList.add('bg-success');
                        }
                        if (smallScissors.length > 0) {
                            tdSmall.innerText = smallScissors[0].Barcode;
                            var checkInspected = inspectionListToDay.filter(f => f.Barcode == smallScissors[0].Barcode);
                            if (checkInspected.length == 0)
                                tdSmall.classList.add('bg-danger');
                            else
                                tdSmall.classList.add('bg-success');
                        }
                    }

                    tr.appendChild(tdBodyNo);
                    tr.appendChild(tdWorkerId);
                    tr.appendChild(tdWorkerName);
                    tr.appendChild(tdSmall);
                    tr.appendChild(tdBig);

                    tbody.appendChild(tr);
                    i++;
                });

                tableInspection.appendChild(tbody);

                document.getElementById('btnSave').onclick = function () { scanScissors(inspectionListToDay, releaseScissorsList) };
            }

            // New Update 2021/02/19
            // ZXing Libary
            let selectedDeviceId;
            const codeReader = new ZXing.BrowserMultiFormatReader()
            console.log('ZXing code reader initialized')
            codeReader.getVideoInputDevices()
                .then((videoInputDevices) => {
                    const sourceSelect = document.getElementById('sourceSelect')
                    selectedDeviceId = videoInputDevices[0].deviceId
                    if (videoInputDevices.length > 1) {
                        selectedDeviceId = videoInputDevices[videoInputDevices.length - 1].deviceId
                    }

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
                        document.getElementById("txtScissorsBarcode").value = ''
                        codeReader.decodeFromVideoDevice(selectedDeviceId, 'video', (result, err) => {
                            if (result) {
                                console.log(result)
                                //document.getElementById('result').textContent = result.text
                                $(document).ready(function () {
                                    document.getElementById("txtScissorsBarcode").value = result.text
                                    // Click OK Button
                                    document.getElementById('btnSave').click();
                                });
                            }
                            if (err && !(err instanceof ZXing.NotFoundException)) {
                                console.error(err)
                                document.getElementById("txtScissorsBarcode").value = err
                            }
                        })
                        console.log(`Started continous decode from camera with id ${selectedDeviceId}`)
                    };

                    // Barcode Button Click
                    document.getElementById("btnScanScissorsBarcode").addEventListener("click", function () {
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
                                    document.getElementById('btnSave').click();
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

        </script>        
    </body>
    </html>
</asp:Content>
