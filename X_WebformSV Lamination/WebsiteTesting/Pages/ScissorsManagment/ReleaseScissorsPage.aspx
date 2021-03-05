<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReleaseScissorsPage.aspx.cs" Inherits="WebsiteTesting.Pages.ScissorsManagment.ReleaseScissorsPage" MasterPageFile="~/Main.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
    <!DOCTYPE html>
    <html>
        <head>
            <title>Scissors Managment - Release Scissors</title>
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
                            <span class="breadcrumb__point" aria-current="page">Release Scissors</span>
                        </li>
                    </ol>
                </nav>
                <!--Title-->
                <h2 class="text-center font-weight-bold">Release Scissors</h2>

                <div class="container p-0">
                    <div class="row g-1">
                        <div class="col-md-4">
                            <div class="row mb-1">
                                <div class="input-group input-group-sm">
                                    <label class="input-group-text rounded-0" style="width:100px;" for="slSection">Section</label>
                                    <select id="slSection" class="form-select custom-select-sm rounded-0">
                                    </select>
                                </div>
                            </div>
                    
                            <div class="row mb-1">
                                <div class="input-group input-group-sm">
                                    <label class="input-group-text rounded-0" style="width:100px;" for="slLine">Line</label>
                                    <select id="slLine" class="form-select custom-select-sm rounded-0">
                                    </select>
                                </div>
                            </div>
                    
                            <div class="row mb-3">
                                <div class="input-group">
                                    <%--<span class="input-group-text rounded-0" style="width:100px;">Worker ID</span>--%>
                                    <input id="txtWorkerId" type="text" class="form-control rounded-0" placeholder="Input WorkerID"/>
                                    <input id="btnSearch" type="button" class="btn rounded-0 btn-outline-primary" value="Search"/>
                                </div>  
                            </div>

                            <div class="row mb-1">
                                <div class="col">
                                    <h6 id="tblReleaseTilte">Release</h6>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input mt-1" type="radio" name="typeOfScissors" id="radBig" value="Big"/>
                                        <label class="form-check-label" for="radBig">Big Scissors</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input mt-1" type="radio" name="typeOfScissors" id="radSmall" value="Small"/>
                                        <label class="form-check-label" for="radSmall">Small Scissors</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input mt-1" type="radio" name="typeOfScissors" id="radOthers" value="Others" disabled/>
                                        <label class="form-check-label" for="radOthers">Others</label>
                                    </div>
                                </div>
                            </div>

                            <div class ="row">
                                <div class="input-group">
                                    <input type="text" id="txtScissorsBarcode" class="form-control rounded-0" placeholder="Scan Scissors Barcode"/>
                                    <div class="input-group-append">
                                        <button class="btn btn-lg rounded-0 border" type="button" id="btnScanScissorsBarcode" data-bs-toggle="modal" data-bs-target="#modalBarcodeScan">
                                            <a><i class="fa fa-barcode"></i></a>
				                        </button>
                                    </div>
                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col-auto float-left">
                                    <%--<input id="btnSubmit" class="btn rounded-1 btn-outline-success" type="button" value="Submit" data-bs-toggle="modal" data-bs-target="#modalConfirmSubmit"/>--%>
                                    <input id="btnSubmit" class="btn rounded-1 btn-outline-success" type="button" value="Submit"/>
                                    <input id="btnOpenModalConfirm" style="display:none !important;" type="button" data-bs-toggle="modal" data-bs-target="#modalConfirmSubmit"/>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <input type="text" id="myInput" style="width:120px !important;" class="form-control float-right rounded-0 mb-1 text-primary" placeholder="input WorkerId or Barcode"/>
                            <table id="tableRelease" class="table table-bordered table-hover">
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
            <!-- Modal Scan Barcode -->
            <div class="modal fade m-auto" id="modalBarcodeScan" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modelBarcodeTitle" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title text-primary" id="modelBarcodeTitle">Scan barcode or qrcode</h5>
                            <button type="button" id="btnCloseModal" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
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

            <!-- Modal Confirm Submit -->
            <div class="modal fade m-auto" id="modalConfirmSubmit" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modalConfirmSubmitTitle" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title text-primary" id="modalConfirmSubmitTitle">Release Scissors</h5>
                            <button type="button" id="btnCloseModalConfirmSubmit" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div id="divContentSubmit" class="row modal-body">
                            <div id="divContentTitle" class="col-auto">
                              <p class="m-1">Worker :</p>
                              <p class="m-1">Section:</p>
                              <p class="m-1">LineName:</p>
                              <p class="m-1">Type:</p>
                              <p class="m-1">Barcode:</p>
                              <p class="m-1">Status:</p>
                              <p class="m-1">Release By:</p>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <div class="row w-100">
                              <div class="col">
                                  <button id="btnConfirmSave" type="button" class="btn btn-sm btn-outline-success float-left"><i class="fa fa-check-circle text-info mr-2" style="font-size:1rem !important;" aria-hidden="true"></i>Save</button>
                              </div>
                              <div class="col">

                              </div>
                              <div class="col float-right">
                                  <button type="button" class="btn btn-sm btn-outline-danger float-right" data-bs-dismiss="modal"><i class="fa fa-times-circle text-warning mr-2" style="font-size:1rem !important;" aria-hidden="true"></i>Cancel</button>
                              </div>
                          </div>
                        </div>                        
                    </div>
                </div>
            </div>

            <script type="text/javascript" src="assets/zxing.js"></script>
            <script type="text/javascript" language="javascript">
                var configSystem;
                var sectionList;
                function searchByWorkerId() {
                    //var barcodeScanning = document.getElementById('txtScissorsBarcode').value;
                    var input, filter, table, tr, td, tdBig, tdSmall, i, txtValue;
                    input = document.getElementById("myInput");
                    filter = input.value.toUpperCase();
                    //if (barcodeScanning != '')
                    //    filter = barcodeScanning;
                    table = document.getElementById("tableRelease");
                    tr = table.getElementsByTagName("tr");
                    for (i = 1; i < tr.length; i++) {
                        td = tr[i].getElementsByTagName("td")[1];
                        tdBig = tr[i].getElementsByTagName("td")[3];
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

                class ReleaseScissorsModel {
                    constructor(ReleaseId, WorkerId, WorkerName, Section, LineName, Barcode, ScissorsType, Status, BrcodeReplace, Reason, ReleaseBy) {
                        this.ReleaseId = ReleaseId;
                        this.WorkerId = WorkerId;
                        this.WorkerName = WorkerName;
                        this.Section = Section;
                        this.LineName = LineName;
                        this.Barcode = Barcode;
                        this.ScissorsType = ScissorsType;
                        this.Status = Status;
                        this.BarcodeReplace = BarcodeReplace;
                        this.Reason = Reason;
                        this.ReleaseBy = ReleaseBy;
                    }
                }

                var releaseCurrentList;

                function selectSection(sectionList, lineList, personalList) {
                    var cboSectionSelected = document.getElementById('slSection').value;
                    var sectionListById = sectionList.filter(f => f.SectionId == cboSectionSelected);

                    var cboSourceLine = document.getElementById('slLine');
                    cboSourceLine.innerHTML = '';
                    var lineListBySectionId = lineList.filter(f => f.SectionId == cboSectionSelected);

                    var optionDefault = document.createElement('option');
                    optionDefault.value = 'Default';
                    optionDefault.text = '--- Select a line ---';
                    optionDefault.className = 'text-primary';
                    cboSourceLine.appendChild(optionDefault);

                    lineListBySectionId.forEach(function (item) {
                        const lineOption = document.createElement('option');
                        lineOption.text = item.LineName;
                        lineOption.value = item.LineName;
                        cboSourceLine.appendChild(lineOption)
                    });

                    var personalListBySection = personalList.filter(f => f.SectionId == cboSectionSelected);
                    btnSearch.onclick = function () { searchClick(personalListBySection) };

                    var sectionNameSelected = sectionList.filter(f => f.SectionId == cboSectionSelected);
                    var releaseCurrentBySectionList = releaseCurrentList.filter(f => f.Section == sectionNameSelected[0].Name);
                    
                    cboSourceLine.onchange = function () { selectLine(releaseCurrentBySectionList) };
                    updateDataTable(releaseCurrentBySectionList);

                    myInput.onkeyup = function () { searchByWorkerId() };
                };

                function selectLine(releaseCurrentBySectionList) {
                    var cboLineSelected = document.getElementById('slLine').value;
                    var releaseCurrentBySectionByLineList = releaseCurrentBySectionList.filter(f => f.LineName == cboLineSelected);
                    updateDataTable(releaseCurrentBySectionByLineList);
                }

                function searchClick(personalListBySection, releaseList) {
                    // Validate Combobox
                    var cboSectionSelected = document.getElementById('slSection').value;
                    if (cboSectionSelected == 'Default') {
                        alert('Select a section !');
                        return;
                    }

                    var cboLineSelected = document.getElementById('slLine').value;
                    if (cboLineSelected == 'Default') {
                        alert('Select a line !');
                        return;
                    }

                    var workerId = document.getElementById('txtWorkerId').value;
                    if (workerId == '') {
                        alert('Worker ID is empty !');
                        return;
                    }
                    var personalByLineByWorkerId = personalListBySection.filter(f => f.WorkerId.toString().toUpperCase() == workerId.toString().toUpperCase());
                    if (personalByLineByWorkerId.length == 0) {
                        alert('WorkerID: ' + workerId + ' doest not exist in current section !');
                        return;
                    }
                    tblReleaseTilte.innerHTML = 'Release to : ' + personalByLineByWorkerId[0].Name;
                    btnSubmit.onclick = function () { submitReleaseScissors(personalByLineByWorkerId) };
                }

                function submitReleaseScissors(personalByLineByWorkerId) {
                    var cboLineSelected = document.getElementById('slLine').value;
                    var workerModel = personalByLineByWorkerId[0];
                    var barcodeScanned = document.getElementById('txtScissorsBarcode').value;
                    if (barcodeScanned == '') {
                        alert('Scissors barcode is empty !');
                        return;
                    }

                    var scissorsType = '';
                    var radBig = document.getElementById('radBig');
                    var radSmall = document.getElementById('radSmall');
                    var radOthers = document.getElementById('radOthers');

                    if (radBig.checked == true)
                        scissorsType = radBig.value;
                    else if (radSmall.checked == true)
                        scissorsType = radSmall.value;
                    else if (radOthers.checked == true)
                        scissorsType = radOthers.value;
                    else {
                        alert('Please select a type of Scissors !');
                        return;
                    }
                    // Check Scissors Replaced
                    var scissorsReplaced = releaseCurrentList.filter(f => f.Barcode == barcodeScanned && f.Status == 'Replaced');
                    if (scissorsReplaced.length > 0) {
                        alert(scissorsReplaced[0].ScissorsType + ' Scissors: ' + scissorsReplaced[0].Barcode + 'was ' + scissorsReplaced[0].Reason);
                        return;
                    }
                    
                    var releaseByScissors = releaseCurrentList.filter(f => f.Barcode == barcodeScanned);
                    if (releaseByScissors.length > 0) {
                        alert('Scissors: ' + releaseByScissors[0].Barcode + ' released to : ' + releaseByScissors[0].WorkerId + ' - ' + releaseByScissors[0].WorkerName + ' !');
                        return;
                    }

                    var releaseByWorker = releaseCurrentList.filter(f => f.WorkerId == workerModel.WorkerId);
                    if (radBig.checked == true) {
                        var releaseBig = releaseByWorker.filter(f => f.ScissorsType == radBig.value);
                        if (releaseBig.length >= configSystem[0].NoOfMaxBigScissors) {
                            alert('Worker: ' + workerModel.WorkerId + ' already borrowed ' + configSystem[0].NoOfMaxBigScissors + ' Big Scissors !');
                            return;
                        }
                    }
                    else if (radSmall.checked == true) {
                        var releaseSmall = releaseByWorker.filter(f => f.ScissorsType == radSmall.value);
                        if (releaseSmall.length >= configSystem[0].NoOfMaxSmallScissors) {
                            alert('Worker: ' + workerModel.WorkerId + ' already borrowed ' + configSystem[0].NoOfMaxSmallScissors +' Small Scissors !');
                            return;
                        }
                    }
                    // releaseId default 1611
                    var releaseInsertModel = new ReleaseScissorsModel (
                        ReleaseId   = 1611,
                        WorkerId = workerModel.WorkerId,
                        WorkerName = workerModel.Name,
                        Section = workerModel.Section,
                        LineName = cboLineSelected,
                        Barcode = barcodeScanned,
                        ScissorsType = scissorsType,
                        Status = 'Borrowed',
                        BarcodeReplace = '',
                        Reason = '',
                        ReleaseBy = workerModel.ReleaseBy
                    );
                    //var modalConfirm = new bootstrap.Modal(document.getElementById('modalConfirmSubmit'));
                    //modalConfirm.show();
                    btnOpenModalConfirm.click();

                    // Show confirm content
                    var divContentSubmit = document.getElementById('divContentSubmit');
                    var divContentTitle = document.getElementById('divContentTitle');
                    divContentSubmit.innerHTML = '';

                    var divColContentData = document.createElement('div');
                    divColContentData.className = 'col-auto p-0';                    
                    
                    var pWorker = document.createElement('p');
                    pWorker.className = 'm-1';
                    pWorker.innerText = releaseInsertModel.WorkerId + '  ' + releaseInsertModel.WorkerName;

                    var pSection = document.createElement('p');
                    pSection.className = 'm-1';
                    pSection.innerText = releaseInsertModel.Section;

                    var pLineName = document.createElement('p');
                    pLineName.className = 'm-1';
                    pLineName.innerText = releaseInsertModel.LineName;

                    var pScissors = document.createElement('p');
                    pScissors.className = 'm-1';
                    pScissors.innerText = releaseInsertModel.ScissorsType + ' Scissors';

                    var pBarcode = document.createElement('p');
                    pBarcode.className = 'm-1';
                    pBarcode.innerText = releaseInsertModel.Barcode;

                    var pStatus = document.createElement('p');
                    pStatus.className = 'm-1';
                    pStatus.innerText    = releaseInsertModel.Status;

                    var pReleaseBy = document.createElement('p');
                    pReleaseBy.className = 'm-1 text-danger';
                    pReleaseBy.innerText = releaseInsertModel.ReleaseBy;

                    divColContentData.appendChild(pWorker);
                    divColContentData.appendChild(pSection);
                    divColContentData.appendChild(pLineName);
                    divColContentData.appendChild(pScissors);
                    divColContentData.appendChild(pBarcode);
                    divColContentData.appendChild(pStatus);
                    divColContentData.appendChild(pReleaseBy);

                    divContentSubmit.appendChild(divContentTitle);
                    divContentSubmit.appendChild(divColContentData);

                    btnConfirmSave.onclick = function () { confirmSave(releaseInsertModel) };
                };

                function confirmSave(releaseInsertModel) {
                    // Insert Data
                    var saveContent = JSON.stringify({ insertModel: releaseInsertModel });
                    $.ajax({
                        url: '<%= ResolveUrl("~/Pages/ScissorsManagment/ReleaseScissorsPage.aspx/SubmitReleaseScissors") %>',
                        data: saveContent,
                        type: "POST",
                        datatype: "json",
                        async: true,
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            if (data.d.toString().includes('Exception:')) {
                                alert(data.d);
                            }
                            else if (data.d.toString().includes('Successful')) {
                                // Update Data table
                                releaseCurrentList.push(releaseInsertModel);
                                btnCloseModalConfirmSubmit.click();
                                updateDataTable(releaseCurrentList);
                            }
                            else {
                                alert(data.d);
                            }
                        },
                        error: onError
                    })
                };

                window.addEventListener('load', function () {
                    // Load Data Release Scissors
                    $.ajax({
                        url: '<%= ResolveUrl("~/Pages/ScissorsManagment/ReleaseScissorsPage.aspx/LoadReleaseScissors") %>',
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
                                var cboSection = document.getElementById('slSection');
                                var sources = JSON.parse(data.d);

                                sectionList     = sources[0];
                                var lineList        = sources[1];
                                var personalList    = sources[2];
                                var releaseList     = sources[3];
                                configSystem        = sources[4];
                                releaseCurrentList  = releaseList;

                                var optionDefault = document.createElement('option');
                                optionDefault.value = 'Default';
                                optionDefault.text = '--- Select a section ---';
                                optionDefault.className = 'text-primary';

                                cboSection.appendChild(optionDefault);

                                sectionList.forEach(function (item) {
                                    const sourceOption  = document.createElement('option')
                                    sourceOption.text   = item.Name;
                                    sourceOption.value  = item.SectionId;
                                    cboSection.appendChild(sourceOption)
                                });
                                cboSection.onchange = function () { selectSection(sectionList, lineList, personalList) };
                                updateDataTable(releaseCurrentList);
                            }
                        },
                        error: onError
                    })
                });

                function onError() {
                    alert('An error occured at the backend !');
                };

                function updateDataTable(releaseCurrentList) {
                    var tableRelease = document.getElementById("tableRelease");
                    // Clear value
                    tableRelease.innerHTML = "";
                    tableRelease.className = 'table table-bordered table-hover table-sm';

                    // Add Header
                    var thHeader = document.createElement('thead')
                    var trHeader = document.createElement('tr');
                    trHeader.className = 'text-center';

                    var thNoOf = document.createElement('th');
                    thNoOf.innerHTML = 'No';
                    thNoOf.width = 80;
                    //thNoOf.classList.add('text-center');

                    var thWorkerId = document.createElement('th');
                    thWorkerId.innerHTML = '#ID';

                    var thWorkerName = document.createElement('th');
                    thWorkerName.innerHTML = 'Name';

                    var thSmall = document.createElement('th');
                    thSmall.innerHTML = 'Small';
                    thSmall.width = 80;
                    //thSmall.classList.add('text-center');

                    var thBig = document.createElement('th');
                    thBig.innerHTML = 'Big';
                    thBig.width = 80;
                    //thBig.classList.add('text-center');

                    trHeader.appendChild(thNoOf);
                    trHeader.appendChild(thWorkerId);
                    trHeader.appendChild(thWorkerName);
                    trHeader.appendChild(thSmall);
                    trHeader.appendChild(thBig);

                    thHeader.appendChild(trHeader);

                    tableRelease.appendChild(thHeader);

                    const workerIdList = [];
                    const map = new Map();
                    releaseCurrentList.forEach(function (item) {
                        if (!map.has(item.WorkerId)) {
                            map.set(item.WorkerId, true);    // set any value to Map
                            workerIdList.push({
                                WorkerId: item.WorkerId,
                                WorkerName: item.WorkerName
                            });
                        }
                    });

                    var i = 1;
                    var tbody = document.createElement('tbody');
                    workerIdList.forEach(function (item) {
                        var releaseByWorker = releaseCurrentList.filter(f => f.WorkerId == item.WorkerId && f.Status == 'Borrowed');

                        var tr = document.createElement('tr');

                        var tdBodyNo = document.createElement('td');
                        tdBodyNo.innerText = i;
                        tdBodyNo.classList.add('text-center');

                        var tdWorkerId = document.createElement('td');
                        tdWorkerId.classList.add('text-center');
                        tdWorkerId.innerText = item.WorkerId;

                        var tdWorkerName = document.createElement('td');
                        tdWorkerName.innerText = item.WorkerName;

                        var tdBig = document.createElement('td');
                        tdBig.innerText = '';
                        tdBig.classList.add('text-center');

                        var tdSmall = document.createElement('td');
                        tdSmall.innerText = '';
                        tdSmall.classList.add('text-center');

                        var releaseBigScissorByWorker   = releaseByWorker.filter(f => f.ScissorsType == 'Big');
                        var releaseSmallScissorByWorker = releaseByWorker.filter(f => f.ScissorsType == 'Small');

                        if (releaseSmallScissorByWorker.length > 0) {
                            const smallScissorsBorrowedList = [];
                            releaseSmallScissorByWorker.forEach(function (smallItem) {
                                smallScissorsBorrowedList.push(smallItem.Barcode);
                            });
                            tdSmall.innerText = smallScissorsBorrowedList.join('\n');
                            tdSmall.classList.add('bg-success');
                        }
                        if (releaseBigScissorByWorker.length > 0) {
                            const bigScissorsBorrowedList = [];
                            releaseBigScissorByWorker.forEach(function (bigItem) {
                                bigScissorsBorrowedList.push(bigItem.Barcode);
                            });
                            tdBig.innerText = bigScissorsBorrowedList.join('\n');
                            tdBig.classList.add('bg-success');
                        }
                        
                        tr.appendChild(tdBodyNo);
                        tr.appendChild(tdWorkerId);
                        tr.appendChild(tdWorkerName);
                        tr.appendChild(tdSmall);
                        tr.appendChild(tdBig);

                        tbody.appendChild(tr);
                        i++;
                    });
                    tableRelease.appendChild(tbody);
                };

                
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
