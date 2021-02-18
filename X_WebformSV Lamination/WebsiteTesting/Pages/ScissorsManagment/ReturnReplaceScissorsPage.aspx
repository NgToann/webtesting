<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReturnReplaceScissorsPage.aspx.cs" Inherits="WebsiteTesting.Pages.ScissorsManagment.ReturnReplaceScissorsPage"  MasterPageFile="~/Main.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
    <!DOCTYPE html>
    <html>
        <head>
            <title>SM Return - Replace Scissors</title>
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
                            <span class="breadcrumb__point" aria-current="page">Return - Replace</span>
                        </li>
                    </ol>
                </nav>
                
                <h2 class="text-center font-weight-bold">Return - Replace Scissors</h2>
                
                <div class="row">
                    <div class="col-auto">
                        <div class="row">
                            <div class="col-auto">
                                <div class="input-group">
                                    <input id="txtWorkerId" type="text" class="form-control rounded-0" placeholder="Input WorkerID"/>
                                    <input id="btnSearch" type="button" class="btn rounded-0 btn-outline-primary" value="Search"/>
                                    <input id="btnScanScissorsBarcode" type="button" style="display: none !important;" data-bs-toggle="modal" data-bs-target="#modalBarcodeScan"/>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row mt-2">
                            <div class="col">
                                <p id="tblWorkerInfo" class="mb-2"></p>
                                <table id="tableReturnRelease" class="table table-sm table-bordered table-hover">
                                    <%--<thead>
                                        <tr>
                                            <th scope="col">No</th>
                                            <th scope="col">WorkerId</th>
                                            <th scope="col">Name</th>
                                            <th scope="col">Section</th>
                                            <th scope="col">Line</th>
                                            <th scope="col">Barcode</th>
                                            <th scope="col">Type</th>
                                            <th scope="col">Release Time</th>
                                            <th scope="col">Action</th>
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
                            <h5 class="modal-title text-primary" id="modelBarcodeTitle">Scan barcode scissors replace</h5>
                            <button type="button" id="btnCloseModal" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body bg-light">
                            <div class="row">
                                <div class="col">
                                    <div class="row align-items-center">
                                        <div class="col-sm-9 mb-1 mb-sm-0">
                                            <input type="text" id="txtScissorsBarcode" class="form-control rounded-0" placeholder="Scan Scissors Barcode"/>
                                        </div>
                                        <div class="col-3 text-right">
                                            <input type="button" id="btnConfirmReplace" class="btn btn-outline-danger rounded-1" value="Replace"/>
                                        </div>
                                    </div>
                                    <div class="row align-items-center">
                                        <div class="col col-sm-6">
                                            <p class="mb-1 mt-2 text-primary">Choose a reason</p>
                                            <div class="form-check form-check-inline">
                                              <input class="form-check-input mt-1" type="radio" name="reasonGroup" id="radBroken" checked="true" value="Broken">
                                              <label class="form-check-label" for="radBroken">Broken</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                              <input class="form-check-input mt-1" type="radio" name="reasonGroup" id="radLoss" value="Loss">
                                              <label class="form-check-label" for="radLoss">Loss</label>
                                            </div>
                                        </div>
                                        <div class="col col-sm-6">
                                            <p class="mb-1 mt-2 text-primary">Type Of Scissors</p>
                                            <div class="form-check form-check-inline">
                                              <input class="form-check-input mt-1" type="radio" name="scissorsType" id="radBig" checked="true" value="Big">
                                              <label class="form-check-label" for="radBig">Big</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                              <input class="form-check-input mt-1" type="radio" name="scissorsType" id="radSmall" value="Small">
                                              <label class="form-check-label" for="radSmall">Small</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
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
            
            <script type="text/javascript" src="assets/zxing.js"></script>
            <script type="text/javascript">
                var currentReleaseScissorsList;
                var releaseByWorkerList;
                var userLogin = '';
                window.addEventListener('load', function () {
                    // Load Data Release Scissors
                    $.ajax({
                        url: '<%= ResolveUrl("~/Pages/ScissorsManagment/ReturnReplaceScissorsPage.aspx/LoadReleaseScissors") %>',
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
                                currentReleaseScissorsList = sources[0];
                                userLogin = sources[1];
                                //alert(JSON.stringify(currentReleaseScissorsList));
                                btnSearch.onclick = function () { updateDataTable() };
                            }
                        },
                        error: onError
                    })
                });

                function onError() {
                    alert('An error occured at the backend !');
                };

                function updateDataTable() {
                    tblWorkerInfo.innerText = '';

                    var tableReturnRelease = document.getElementById("tableReturnRelease");
                    // Clear value
                    tableReturnRelease.innerHTML = "";

                    // Add Header
                    var thHeader = document.createElement('thead')
                    var trHeader = document.createElement('tr');
                    trHeader.className = 'text-center';

                    var thNoOf = document.createElement('th');
                    thNoOf.innerText = 'No';

                    var thWorkerId = document.createElement('th');
                    thWorkerId.innerText = '#ID';

                    var thBarcode = document.createElement('th');
                    thBarcode.innerText = 'Barcode';

                    var thScissorsType = document.createElement('th');
                    thScissorsType.innerText = 'Type';

                    var thStatus = document.createElement('th');
                    thStatus.innerText = 'Status';

                    var thReason = document.createElement('th');
                    thReason.innerText = 'Reason';

                    var thReleaseTime = document.createElement('th');
                    thReleaseTime.innerText = 'Release Time';

                    var thAction = document.createElement('th');
                    thAction.innerText = 'Action';

                    trHeader.appendChild(thNoOf);
                    trHeader.appendChild(thWorkerId);
                    trHeader.appendChild(thBarcode);
                    trHeader.appendChild(thScissorsType);
                    trHeader.appendChild(thStatus);
                    trHeader.appendChild(thReason);
                    trHeader.appendChild(thReleaseTime);
                    trHeader.appendChild(thAction);

                    thHeader.appendChild(trHeader);

                    tableReturnRelease.appendChild(thHeader);

                    // Searching data....
                    var workerIdInput = document.getElementById('txtWorkerId').value;
                    var scissorsReleaseByWorkerId = currentReleaseScissorsList.filter(f => f.WorkerId.toUpperCase() == workerIdInput.toUpperCase());
                    releaseByWorkerList = scissorsReleaseByWorkerId;
                    if (scissorsReleaseByWorkerId.length == 0) {
                        alert('WorkerId: ' + workerIdInput + ' has`not borrowed any Scissors !');
                        return;
                    }
                    var workerInfo = scissorsReleaseByWorkerId[0];
                    tblWorkerInfo.innerText = 'Worker: ' + workerInfo.WorkerId + ' / ' + workerInfo.WorkerName + ' / ' + workerInfo.Section + ' / ' + workerInfo.LineName;
                    
                    var i = 1;
                    var tbody = document.createElement('tbody');
                    scissorsReleaseByWorkerId.forEach(function (item) {
                        var tr = document.createElement('tr');

                        var tdBodyNo = document.createElement('td');
                        tdBodyNo.innerText = i;
                        tdBodyNo.classList.add('text-center');

                        var tdWorkerId = document.createElement('td');
                        tdWorkerId.classList.add('text-center');
                        tdWorkerId.classList.add('text-primary');
                        tdWorkerId.innerText = item.WorkerId;

                        var tdBarcode = document.createElement('td');
                        tdBarcode.innerText = item.Barcode;

                        var tdScissorsType = document.createElement('td');
                        tdScissorsType.innerText = item.ScissorsType;

                        var tdStatus = document.createElement('td');
                        tdStatus.innerText = item.Status;
                        if (item.Status == 'Returned') {
                            tdStatus.className = 'text-primary';
                        }
                        else if (item.Status == 'Replaced') {
                            tdStatus.className = 'text-danger';
                        }

                        var tdReason = document.createElement('td');
                        tdReason.innerText = item.Reason;

                        var tdReleaseTime = document.createElement('td');
                        tdReleaseTime.innerText = item.CreatedTime;

                        var tdAction = document.createElement('td');

                        var btnReturn = document.createElement('input');
                        btnReturn.type = 'button';
                        btnReturn.className = 'btn btn-sm btn-outline-primary rounded-1 mr-1';
                        btnReturn.value = 'Return';
                        btnReturn.id = item.Barcode;
                        tdAction.appendChild(btnReturn);

                        btnReturn.onclick = function () { returnScissors(item) };

                        var btnReplace = document.createElement('input');
                        btnReplace.type = 'button';
                        btnReplace.className = 'btn btn-sm btn-outline-danger rounded-1';
                        btnReplace.value = 'Replace';
                        btnReplace.id = item.Barcode;
                        tdAction.appendChild(btnReplace);
                        btnReplace.onclick = function () { scanScissorsReplace(item) };

                        tr.appendChild(tdBodyNo);
                        tr.appendChild(tdWorkerId);
                        tr.appendChild(tdBarcode);
                        tr.appendChild(tdScissorsType);
                        tr.appendChild(tdStatus);
                        tr.appendChild(tdReason);
                        tr.appendChild(tdReleaseTime);
                        tr.appendChild(tdAction);

                        tbody.appendChild(tr);
                        i++;
                    });
                    tableReturnRelease.appendChild(tbody);
                };

                function returnScissors(item) {
                    if (item.Status != 'Borrowed') {
                        alert('This scissors cannot be return !');
                        return;
                    }

                    // Excute Return Process
                    var r = confirm('Confirm return ' + item.ScissorsType + ' scissors barcode: ' + item.Barcode + '?');
                    if (r == true) {
                        $.ajax({
                            url: '<%= ResolveUrl("~/Pages/ScissorsManagment/ReturnReplaceScissorsPage.aspx/ReturnScissors") %>',
                            data: {
                                "releaseId": '"' + item.ReleaseId + '"'
                            },
                            type: "GET",
                            datatype: "json",
                            async: true,
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                if (data.d.toString().includes('Exception:')) {
                                    alert(data.d);
                                }
                                else if (data.d != 'Successful !') {
                                    alert(data.d);
                                }
                                else {
                                    alert('Returned ' + data.d);
                                    releaseByWorkerList.forEach(function (releaseItem) {
                                        if (releaseItem.ReleaseId == item.ReleaseId) {
                                            releaseItem.Status = "Returned";
                                        }
                                    });
                                    updateDataTable();
                                }
                            },
                            error: onError
                        })
                    }
                    else { }
                };

                function scanScissorsReplace(item) {
                    if (item.Status != 'Borrowed') {
                        alert('This scissors cannot be replace !');
                        return;
                    }
                    btnScanScissorsBarcode.click();
                    btnConfirmReplace.onclick = function () { replaceScissors(item) };
                };

                function replaceScissors(item) {
                    var barcodeNew = document.getElementById('txtScissorsBarcode').value;
                    if (barcodeNew == '') {
                        alert('Barcode is empty !');
                        return;
                    }

                    var scissorsType = '';
                    if (radBig.checked == true) {
                        scissorsType = radBig.value;
                    }
                    else {
                        scissorsType = radSmall.value;
                    }

                    if (item.ScissorsType != scissorsType) {
                        alert('Can not replace a ' + item.ScissorsType + ' scissors by a ' + scissorsType + ' scissors !');
                        return;
                    }

                    item.BarcodeReplace = barcodeNew;
                    item.Reason         = radLoss.checked == true ? radLoss.value : radBroken.value;
                    item.ReleaseBy      = userLogin;

                    var updateContent = JSON.stringify({ replaceModel: item });

                    // Excute Replacement Process
                    $.ajax({
                        url: '<%= ResolveUrl("~/Pages/ScissorsManagment/ReturnReplaceScissorsPage.aspx/ReplaceScissors") %>',
                        data: updateContent,
                        type: "POST",
                        datatype: "json",
                        async: true,
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            if (data.d.toString().includes('Exception:')) {
                                alert(data.d);
                            }
                            else if (data.d.toString().includes('Successful')) {
                                alert('Replace ' + data.d);
                                // Update the Scissors has been replaced
                                currentReleaseScissorsList = currentReleaseScissorsList.filter(f => f.ReleaseId !== item.ReleaseId);
                                currentReleaseScissorsList.push(item);

                                //releaseByWorkerList.forEach(function (releaseItem) {
                                //    if (releaseItem.ReleaseId == item.ReleaseId) {
                                //        releaseItem.Status = "Replaced";
                                //        releaseItem.Reason = item.Reason;
                                //        releaseItem.ReleaseBy = item.ReleaseBy;
                                //    }
                                //});

                                // Add New Release Scissors
                                var releaseNew = item;
                                releaseNew.barcodeNew = item.BarcodeReplace;
                                releaseNew.Status = 'Borrowed';
                                releaseNew.BarcodeReplace = '';

                                currentReleaseScissorsList.push(releaseNew);
                                updateDataTable();
                            }
                            else {
                                alert(data.d);
                            }
                        },
                        error: onError
                    })
                };

                //class ReleaseScissorsModel {
                //    constructor(ReleaseId, WorkerId, WorkerName, Section, LineName, Barcode, ScissorsType, Status, BrcodeReplace, Reason, ReleaseBy) {
                //        this.ReleaseId = ReleaseId;
                //        this.WorkerId = WorkerId;
                //        this.WorkerName = WorkerName;
                //        this.Section = Section;
                //        this.LineName = LineName;
                //        this.Barcode = Barcode;
                //        this.ScissorsType = ScissorsType;
                //        this.Status = Status;
                //        this.BarcodeReplace = BarcodeReplace;
                //        this.Reason = Reason;
                //        this.ReleaseBy = ReleaseBy;
                //    }
                //}

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
                                        document.getElementById('btnCloseModal').click();
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
                                        document.getElementById('btnCloseModal').click();
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
