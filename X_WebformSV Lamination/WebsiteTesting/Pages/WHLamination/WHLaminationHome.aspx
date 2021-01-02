<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WHLaminationHome.aspx.cs" Inherits="WebsiteTesting.Pages.WHLamination.WHLaminationHome" MasterPageFile="~/Main.Master"  %>
<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
<!DOCTYPE html>
    <head>
        <title>WH Lamination</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <%--<link rel="Stylesheet" href="assets/font-awesome.min.css" />--%>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>        
        <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>        
        
        <script type="text/javascript">
            class LaminationMaterialScore {
                constructor(OrderNoId, POQuantity, LabelQuantity, ActualQuantity, LabelWidth, ActualWidth, TotalScore, DefectType1, DefectType2, DefectType3, DefectType4, HoleType2, HoleType4, Reviser) {
                    this.OrderNoId = OrderNoId;
                    this.POQuantity = POQuantity;
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
            };

            function CalculatePoint(currentLMScore) {
                var totalPoint = 0, totalPointDefect1 = 0, totalPointDefect2 = 0, totalPointDefect3 = 0, totalPointDefect4 = 0, totalPointHole2 = 0, totalPointHole4 = 0;
                if (currentLMScore.DefectType1 != null) {
                    totalPointDefect1 = currentLMScore.DefectType1;
                }
                if (currentLMScore.DefectType2 != null) {
                    totalPointDefect2 = currentLMScore.DefectType2 * 2;
                }
                if (currentLMScore.DefectType3 != null) {
                    totalPointDefect3 = currentLMScore.DefectType3 * 3;
                }
                if (currentLMScore.DefectType4 != null) {
                    totalPointDefect4 = currentLMScore.DefectType4 * 4;
                }
                if (currentLMScore.HoleType2 != null) {
                    totalPointHole2 = currentLMScore.HoleType2 * 2;
                }
                if (currentLMScore.HoleType4 != null) {
                    totalPointHole4 = currentLMScore.HoleType4 * 4;
                }

                totalPoint = totalPointDefect1 + totalPointDefect2 + totalPointDefect3 + totalPointDefect4 + totalPointHole2 + totalPointHole4;
                return totalPoint;
            }

            var currentLMScore = new LaminationMaterialScore();

            function buttonMaterialClick(buttonId, laminationMaterialList, lamiMatsSelected) {
                var reviser = document.getElementById('contentPlaceHolder_lblUser').innerText;
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
                    LabelQuantity = 0,
                    ActualQuantity = 0,
                    LabelWidth = 0,
                    ActualWidth = 0,
                    TotalScore = 0,
                    DefectType1 = 0,
                    DefectType2 = 0,
                    DefectType3 = 0,
                    DefectType4 = 0,
                    HoleType2 = 0,
                    HoleType4 = 0,
                    Reviser = reviser,
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
                        // matsScore already check
                        else {
                            var matsScoreCurrentCheck = JSON.parse(data.d);
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
                const divScoreSave = document.getElementById('divScoreSave');
                divScore.style.display = 'block';
                divScoreSave.style.display = 'block';

                currentLMScore = matsScore;
                // Display old data
                DisplayPoint(currentLMScore, '', true);

                // Close Modal
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
                const divScoreSave = document.getElementById('divScoreSave');
                //const divScore = document.querySelectorAll('divScore');
                divScore.style.display = 'none';
                divScoreSave.style.display = 'none';
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

            function DisplayPoint(currentLMScore, buttonId, displayOldData) {

                document.getElementById('lblTotalScore').innerText = '';
                document.getElementById('divCardScore').classList.remove('border-danger');
                document.getElementById('divCardScore').classList.remove('bg-danger');
                document.getElementById('lblTotalScore').classList.remove('text-danger');
                document.getElementById('btnSave').classList.remove('btn-danger');

                document.getElementById('divCardScore').classList.remove('border-success');
                document.getElementById('divCardScore').classList.remove('bg-success');
                document.getElementById('lblTotalScore').classList.remove('text-success');
                document.getElementById('btnSave').classList.remove('btn-success');

                if (displayOldData) {
                    document.getElementById('spDefectType1').innerText = currentLMScore.DefectType1;
                    document.getElementById('spDefectType2').innerText = currentLMScore.DefectType2;
                    document.getElementById('spDefectType3').innerText = currentLMScore.DefectType3;
                    document.getElementById('spDefectType4').innerText = currentLMScore.DefectType4;
                    document.getElementById('spHoleType2').innerText = currentLMScore.HoleType2;
                    document.getElementById('spHoleType4').innerText = currentLMScore.HoleType4;
                }
                else if (currentLMScore != null) {
                    if (buttonId === 'btnDefectType1') {
                        currentLMScore.DefectType1 = currentLMScore.DefectType1 + 1;
                        document.getElementById('spDefectType1').innerText = currentLMScore.DefectType1;
                    }
                    else if (buttonId === 'btnDefectType2') {
                        currentLMScore.DefectType2 = currentLMScore.DefectType2 + 1;
                        document.getElementById('spDefectType2').innerText = currentLMScore.DefectType2;
                    }
                    else if (buttonId === 'btnDefectType3') {
                        currentLMScore.DefectType3 = currentLMScore.DefectType3 + 1;
                        document.getElementById('spDefectType3').innerText = currentLMScore.DefectType3;
                    }
                    else if (buttonId === 'btnDefectType4') {
                        currentLMScore.DefectType4 = currentLMScore.DefectType4 + 1;
                        document.getElementById('spDefectType4').innerText = currentLMScore.DefectType4;
                    }
                    else if (buttonId === 'btnHoleType2') {
                        currentLMScore.HoleType2 = currentLMScore.HoleType2 + 1;
                        document.getElementById('spHoleType2').innerText = currentLMScore.HoleType2;
                    }
                    else if (buttonId === 'btnHoleType4') {
                        currentLMScore.HoleType4 = currentLMScore.HoleType4 + 1;
                        document.getElementById('spHoleType4').innerText = currentLMScore.HoleType4;
                    }
                }

                var totalPoint = CalculatePoint(currentLMScore);
                document.getElementById('lblTotalScore').innerText = totalPoint;
                currentLMScore.TotalScore = totalPoint;
                // Material Fail
                if (totalPoint > 0 && totalPoint < 80) {
                    document.getElementById('divCardScore').classList.add('border-danger');
                    document.getElementById('divCardScore').classList.add('bg-danger');
                    document.getElementById('lblTotalScore').classList.add('text-danger');
                    document.getElementById('btnSave').classList.add('btn-danger');
                }
                // Material Pass
                else if (totalPoint > 0 && totalPoint >= 80){
                    document.getElementById('divCardScore').classList.add('border-success');
                    document.getElementById('divCardScore').classList.add('bg-success');
                    document.getElementById('lblTotalScore').classList.add('text-success');
                    document.getElementById('btnSave').classList.add('btn-success');
                }

                document.getElementById("btnDefectType1").onclick = function () { DisplayPoint(currentLMScore, 'btnDefectType1', false) };
                document.getElementById("btnDefectType2").onclick = function () { DisplayPoint(currentLMScore, 'btnDefectType2', false) };
                document.getElementById("btnDefectType3").onclick = function () { DisplayPoint(currentLMScore, 'btnDefectType3', false) };
                document.getElementById("btnDefectType4").onclick = function () { DisplayPoint(currentLMScore, 'btnDefectType4', false) };
                document.getElementById("btnHoleType2").onclick = function () { DisplayPoint(currentLMScore, 'btnHoleType2', false) };
                document.getElementById("btnHoleType4").onclick = function () { DisplayPoint(currentLMScore, 'btnHoleType4', false) };

                document.getElementById("btnReset").onclick = function () { ResetScoreArea(currentLMScore) };
                document.getElementById("btnSave").onclick = function () { SaveScore(currentLMScore) };

                return false;
            }

            function SaveScore(currentLMScore) {
                var reviser = document.getElementById('contentPlaceHolder_lblUser').innerText;
                var orderNoId       = currentLMScore.OrderNoId;
                var poQuantity      = currentLMScore.POQuantity;
                var labelQuantity   = currentLMScore.LabelQuantity;
                var actualQuantity  = currentLMScore.ActualQuantity;
                var labelWidth      = currentLMScore.LabelWidth;
                var actualWidth     = currentLMScore.ActualWidth;
                var defectType1     = currentLMScore.DefectType1;
                var defectType2     = currentLMScore.DefectType2;
                var defectType3     = currentLMScore.DefectType3;
                var defectType4     = currentLMScore.DefectType4;
                var holeType2       = currentLMScore.HoleType2;
                var holeType4       = currentLMScore.HoleType4;
                var totalScore      = currentLMScore.TotalScore;
                var reviser         = reviser; 
                //jQuery.ajax({
                $.ajax({
                    url: '<%= ResolveUrl("~/Pages/WHLamination/WHLaminationHome.aspx/SaveScore") %>',
                    data: {
                        "orderNoId": '"' + orderNoId + '"', "poQuantity": '"' + poQuantity + '"', "labelQuantity": '"' + labelQuantity + '"', "actualQuantity": '"' + actualQuantity + '"',
                        "labelWidth": '"' + labelWidth + '"', "actualWidth": '"' + actualWidth + '"', "defectType1": '"' + defectType1 + '"', "defectType2": '"' + defectType2 + '"',
                        "defectType3": '"' + defectType3 + '"', "defectType4": '"' + defectType4 + '"', "holeType2": '"' + holeType2 + '"', "holeType4": '"' + holeType4 + '"',
                        "totalScore": '"' + totalScore + '"', "reviser": '"' + reviser + '"'
                    },
                    type: "GET",
                    datatype: "json",
                    async: true,
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d === 'Successful !') {
                            alert(data.d);
                            //ResetScoreArea(currentLMScore);
                        }
                        else {
                            alert(data.d + ' Please Try Again !');
                        }
                    },
                    error: onError
                });
                return false;
            }

            function ToastReset(currentLMScore) {

                document.getElementById('lblTotalScore').innerText = '0';
                document.getElementById('divCardScore').classList.remove('border-danger');
                document.getElementById('divCardScore').classList.remove('bg-danger');
                document.getElementById('lblTotalScore').classList.remove('text-danger');
                document.getElementById('btnSave').classList.remove('btn-danger');

                document.getElementById('divCardScore').classList.remove('border-success');
                document.getElementById('divCardScore').classList.remove('bg-success');
                document.getElementById('lblTotalScore').classList.remove('text-success');
                document.getElementById('btnSave').classList.remove('btn-success');

                currentLMScore.DefectType1 = 0;
                currentLMScore.DefectType2 = 0;
                currentLMScore.DefectType3 = 0;
                currentLMScore.DefectType4 = 0;

                currentLMScore.HoleType2 = 0;
                currentLMScore.HoleType4 = 0;
                currentLMScore.TotalScore = 0;

                document.getElementById('spDefectType1').innerText = '0';
                document.getElementById('spDefectType2').innerText = '0';
                document.getElementById('spDefectType3').innerText = '0';
                document.getElementById('spDefectType4').innerText = '0';
                document.getElementById('spHoleType2').innerText = '0';
                document.getElementById('spHoleType4').innerText = '0';

                $('.toast').toast('hide');
            }
            function ToastCancel() {
                $('.toast').toast('hide');
            }
            function ResetScoreArea(currentLMScore) {
                $('.toast').toast('show');
                document.getElementById('toastTitle').textContent = 'Confirm Reset: ' + currentLMScore.OrderNoId + ' ?';
                document.getElementById("btnResetToast").onclick = function () { ToastReset(currentLMScore) };
                document.getElementById("btnCancelToast").onclick = function () { ToastCancel() };
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
                if (data.d === "This PO does not exist in system !") {
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

            window.addEventListener('load', function () {
                showTime();
                //$('.dropdown-toggle').dropdown();
            });
            // Clock
            function showTime() {
                var date = new Date();
                var h = date.getHours(); // 0 - 23
                var m = date.getMinutes(); // 0 - 59
                var s = date.getSeconds(); // 0 - 59
                var session = "AM";

                if (h == 0) {
                    h = 12;
                }

                if (h > 12) {
                    h = h - 12;
                    session = "PM";
                }

                h = (h < 10) ? "0" + h : h;
                m = (m < 10) ? "0" + m : m;
                s = (s < 10) ? "0" + s : s;

                var time = h + ":" + m + ":" + s + " " + session;
                var pClock = document.getElementById('MyClockDisplay').innerText = time;
                setTimeout(showTime, 1000);
            }
        </script>
    </head>
    <html lang="en">
        <body>
            <%--<asp:ScriptManager ID="scriptManagerWHLamination" runat="server" EnablePageMethods="true"/>--%>
            
            <div class="container-fluid" style="min-height:100vh;">
                <div class="row align-items-start" style="min-height:10vh;">
                    <div class="col">
                        <h2 class="text-center text-dark">WH Lamination</h2>
                    </div>
                    <div id="divUser" class="col-auto" runat="server">
                        <div class="dropdown dropleft mt-1">
                            <a class="btn bg-white shadow-sm rounded-0 dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fa fa-user text-primary mr-1"></i><asp:Label ID="lblUser" runat="server"></asp:Label>
                            </a>
                            <div class="dropdown-menu fade" aria-labelledby="dropdownMenuLink" >
                                <a class="dropdown-item text-danger text-center" href="../LoginPage.aspx">Logout !</a>
                                <a class="dropdown-item text-primary text-center" href="Report.aspx">Report</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row" style="min-height:90vh;">
                    <div class="col-12 h-100 w-100">
                        <div class="row" style="min-height: 45vh;">
                            <div class="col-12 col-sm-4">
                                <div class="row">
                                    <div class="col input-group-append">
                                        <button class="btn btn-lg rounded-0 border" type="button" id="btnScanBarcode" data-bs-toggle="modal" data-bs-target="#modalBarcodeScan">
                                            <a><i class="fa fa-barcode"></i></a>
				                        </button>
                                        <input id="txtOrderNoBarcode" class="form-control rounded-0" placeholder="Scan Barcode"></input>
                                        <button class="btn btn-primary rounded-0" id="btnSearchByOrderNo" onclick="Search(); return false;">Search</button>
                                    </div>
                                </div>
                                <div id="divMatsList" class="row row-cols-auto g-1 mt-1 overflow-auto" style="max-height:240px;">
                                </div>
                            </div>
                            <div id="divMatsInfor" class="col-12 col-sm-8 mt-1 mt-sm-0 overflow-auto" style="display:none;">
                            <div class="card">
                                <div class="card-header small">
                                    <div class="row g-0">
                                        <div class="col">
                                            <p id="pMatsName" class="m-0 p-0 text-danger">Material Description</p>
                                        </div>
                                        <div class="col-auto text-center">
                                            <i class="fa fa-clock-o"></i><a class="ml-1 p-0 text-danger" id="MyClockDisplay"></a>
                                        </div>
                                    </div>
                                </div>

                                <div class="card-body small h-auto">
                                    <div class="row g-1">
                                        <div id="divMatsInforColumn1" class="col-12 col-sm-4">
                                        </div>
                                        <div id="divMatsInforColumn2" class="col-12 col-sm-4">
                                        </div>
                                        <div id="divMatsInforColumn3" class="col-12 col-sm-4">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div id="divMatsInforRow2" class="col-12"></div>
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
                    </div>
                    
                    <div class="col-12 mt-1 mt-sm-0 h-100 w-100">
                        <div class="row pt-1 pb-1 align-items-end" style="min-height: 45vh;">
                            <div id="divScore" class="col-12 col-sm-8 h-100" style="display:none;">
                                <div class="container p-0 m-0">
                                    <div class="row"><h6>Defects</h6></div>
                                    <div class="row">
                                        <div class="col-3">
                                            <button id="btnDefectType1" type="button" class="btn btn-outline-danger pt-0 pr-0 pl-0 pb-4 rounded-2 shadow-sm h-100 w-100">
                                                <div class="container p-0 m-0 w-100 h-100 g-0">
                                                    <div class="row p-0 m-0 w-100 text-right"><h5 class="p-0 m-0"><span id="spDefectType1" class="badge bg-danger rounded-2">0</span></h5></div>
                                                    <div class="row p-0 m-0 w-100 text-center"><h2 class="p-0 m-0">1</h2></div>
                                                </div>
                                            </button>
                                        </div>
                                        <div class="col-3">
                                            <button id="btnDefectType2" type="button" class="btn btn-outline-danger pt-0 pr-0 pl-0 pb-4 rounded-2 shadow-sm h-100 w-100">
                                                <div class="container p-0 m-0 w-100 h-100 g-0">
                                                    <div class="row p-0 m-0 w-100 text-right"><h5 class="p-0 m-0"><span id="spDefectType2" class="badge bg-danger rounded-2">0</span></h5></div>
                                                    <div class="row p-0 m-0 w-100 text-center"><h2 class="p-0 m-0">2</h2></div>
                                                </div>
                                            </button>
                                        </div>
                                        <div class="col-3">
                                            <button id="btnDefectType3" type="button" class="btn btn-outline-danger pt-0 pr-0 pl-0 pb-4 rounded-2 shadow-sm h-100 w-100">
                                                <div class="container p-0 m-0 w-100 h-100 g-0">
                                                    <div class="row p-0 m-0 w-100 text-right"><h5 class="p-0 m-0"><span id="spDefectType3" class="badge bg-danger rounded-2">0</span></h5></div>
                                                    <div class="row p-0 m-0 w-100 text-center"><h2 class="p-0 m-0">3</h2></div>
                                                </div>
                                            </button>
                                        </div>
                                        <div class="col-3">
                                            <button id="btnDefectType4" type="button" class="btn btn-outline-danger pt-0 pr-0 pl-0 pb-4 rounded-2 shadow-sm h-100 w-100">
                                                <div class="container p-0 m-0 w-100 h-100 g-0">
                                                    <div class="row p-0 m-0 w-100 text-right"><h5 class="p-0 m-0"><span id="spDefectType4" class="badge bg-danger rounded-2">0</span></h5></div>
                                                    <div class="row p-0 m-0 w-100 text-center"><h2 class="p-0 m-0">4</h2></div>
                                                </div>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="container p-0 m-0">
                                    <div class="row"><h6>Hole</h6></div>
                                    <div class="row">
                                        <div class="col-3">
                                        </div>
                                        <div class="col-3">
                                            <button id="btnHoleType2" type="button" class="btn btn-outline-info pt-0 pr-0 pl-0 pb-4 rounded-2 shadow-lg h-100 w-100">
                                                <div class="container p-0 m-0 w-100 h-100 g-0">
                                                    <div class="row p-0 m-0 w-100 text-right"><h5 class="p-0 m-0"><span id="spHoleType2" class="badge bg-info rounded-2">0</span></h5></div>
                                                    <div class="row p-0 m-0 w-100 text-center"><h2 class="p-0 m-0">2</h2></div>
                                                </div>
                                            </button>
                                        </div>
                                        <div class="col-3">
                                            <button id="btnHoleType4" type="button" class="btn btn-outline-info pt-0 pr-0 pl-0 pb-4 rounded-2 shadow-lg h-100 w-100">
                                                <div class="container p-0 m-0 w-100 h-100 g-0">
                                                    <div class="row p-0 m-0 w-100 text-right"><h5 class="p-0 m-0"><span id="spHoleType4" class="badge bg-info rounded-2">0</span></h5></div>
                                                    <div class="row p-0 m-0 w-100 text-center"><h2 class="p-0 m-0">4</h2></div>
                                                </div>
                                            </button>
                                        </div>
                                        <div class="col-3 float-right">
                                            
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="divScoreSave" class="col-12 col-sm-4 mt-1 mt-sm-0 h-100" style="display:none;">
                                <div id="divCardScore" class="card rounded-0 shadow-sm w-100">
                                    <div class="card-header rounded-0 text-center">
                                        <div class="row p-0 m-0 align-items-center">
                                            <div class="col text-left"><h4 class="p-0 m-0">SCORE</h4></div>
                                            <div class="col-auto p-0 m-0">
                                                <button id="btnReset" type="button" class="btn btn-warning shadow-sm btn-sm rounded-2" data-bs-toggle="modal" data-bs-target="#modalDisplayToast">
                                                    <i class="fa fa-refresh fa-1x mr-2"></i>
                                                    Reset</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body bg-white">
                                    <h1 id="lblTotalScore" class="card-title text-center w-100 h-100" style="font-size:5rem;"></h1>
                                    </div>
                                    <div class="card-footer bg-transparent p-0 m-0">
                                        <button id="btnSave" class="btn btn-lg w-100 rounded-0 border-0" type="button">SAVE</button>
                                    </div>
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
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <div class="row" id="sourceSelectPanel" style="display:none">
                                    <div class="input-group">
                                        <label for="sourceSelect" class="mt-1">Camera:</label>
                                        <div class="input-group-append ml-2">
                                            <select id="sourceSelect" style="max-width:400px">
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-auto float-right">
                                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                            </div>
                        </div>                        
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
            
            <div class="modal fade w-auto rounded-0" id="modalDisplayToast" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                    <div class="toast w-100 text-dark border-0" role="alert" aria-live="assertive" aria-atomic="true" data-bs-autohide="false">
                      <div class="toast-body">
                        <h6 class="font-italic" id="toastTitle">Confirm Reset ?</h6>
                        <div class="mt-2 pt-2 border-top">
                            <div class="row">
                                <div class="col-auto">
                                    <button id="btnResetToast" type="button" class="btn btn-danger shadow-sm btn-sm" data-bs-dismiss="modal"> Reset </button>
                                </div>
                                <div class="col-auto">
                                    <button id="btnCancelToast" type="button" class="btn btn-warning shadow-sm btn-sm" data-bs-dismiss="modal"> Cancel </button>
                                </div>
                            </div>
                        </div>
                      </div>
                    </div>
                </div>
              </div>
            </div>

            <script type="text/javascript" src="assets/zxing.js"></script>
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
                    })
                    .catch((err) => {
                        console.error(err)
                    })
                //})
            </script>
        </body>
    </html>
</asp:Content>