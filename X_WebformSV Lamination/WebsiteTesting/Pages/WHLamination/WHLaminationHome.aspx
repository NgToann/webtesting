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
        
        <%--<link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">--%>
        <!-- Theme style -->
        <%--<link rel="stylesheet" href="dist/css/adminlte.min.css">--%>
        <script type="text/javascript">
            var rejectsWHLamination;
            class LaminationMaterialScore {
                constructor(OrderNoId, POQuantity, LabelQuantity, ActualQuantity, LabelWidth, ActualWidth, TotalScore, DefectType1, DefectType2, DefectType3, DefectType4, HoleType2, HoleType4, Reviser, NoOfDefects, RoundCheck, MaxRound) {
                    this.OrderNoId      = OrderNoId;
                    this.POQuantity     = POQuantity;
                    this.LabelQuantity  = LabelQuantity;
                    this.ActualQuantity = ActualQuantity;
                    this.LabelWidth     = LabelWidth;
                    this.ActualWidth    = ActualWidth;
                    this.DefectType1    = DefectType1;
                    this.DefectType2    = DefectType2;
                    this.DefectType3    = DefectType3;
                    this.DefectType4    = DefectType4;
                    this.HoleType2      = HoleType2;
                    this.HoleType4      = HoleType4;
                    this.Reviser        = Reviser;
                    this.NoOfDefects    = NoOfDefects;
                    this.RoundCheck     = RoundCheck;
                    this.MaxRound       = MaxRound;
                }
            };

            function CalculateNoOfDefects(currentLMScore) {
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
                    ActualQuantity = 1,
                    LabelWidth = 0,
                    ActualWidth = 1,
                    TotalScore = 0,
                    DefectType1 = 0,
                    DefectType2 = 0,
                    DefectType3 = 0,
                    DefectType4 = 0,
                    HoleType2 = 0,
                    HoleType4 = 0,
                    Reviser = reviser,
                    NoOfDefects = 0,
                    RoundCheck = 1
                );
                $.ajax({
                    url: '<%= ResolveUrl("~/Pages/WHLamination/WHLaminationHome.aspx/GetScoreByOrderNoId") %>',
                    data: { "orderNoId": '"' + buttonId + '"' },
                    type: "GET",
                    datatype: "json",
                    async: true,
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        // Clear RoundList
                        const divRoundList = document.getElementById("divRoundList");
                        divRoundList.innerHTML = '';

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
                            var roundCheckList = JSON.parse(data.d);
                            
                            if (roundCheckList != null || roundCheckList.length != 0) {
                                var nextRound = 0;

                                var pHistory = document.createElement("p");
                                pHistory.className = "mt-2 mb-0";
                                pHistory.innerText = 'Previous Scan';
                                divRoundList.append(pHistory);

                                roundCheckList.forEach(function (round) {
                                    var roundDivCol = document.createElement("div");
                                    roundDivCol.className = "col";
                                    var roundButton = document.createElement("button");
                                    roundButton.className = "btn btn-sm btn-info";
                                    roundButton.type = "button";
                                    roundButton.id = round.RoundCheck;
                                    roundButton.textContent = 'Round ' + round.RoundCheck;
                                    roundButton.onclick = function () { continueRoundCheck(round.OrderNoId, roundButton.id, lamiMatsSelected) };

                                    roundDivCol.appendChild(roundButton);
                                    divRoundList.append(roundDivCol);

                                    nextRound = round.MaxRound + 1;
                                });

                                DispayModalData(matsScoreFirst);
                                // Start New Round
                                matsScoreFirst.RoundCheck = nextRound;
                                document.getElementById("btnStart").onclick = function () { buttonStartClick(matsScoreFirst, lamiMatsSelected) };
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
                
                var labelWidth = document.getElementById('txtLabelWidth');
                labelWidth.classList.remove('is-invalid');

                var validateResult = true;
                if (!regexNumber.test(labelQty.value.toString())) {
                    labelQty.classList.add('is-invalid');
                    validateResult = false;
                }
                if (!regexNumber.test(labelWidth.value.toString())) {
                    labelWidth.classList.add('is-invalid');
                    validateResult = false;
                }

                if (!validateResult) {
                    return;
                }

                matsScore.LabelQuantity = labelQty.value;
                matsScore.LabelWidth = labelWidth.value;
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

            function continueRoundCheck(orderNoId, buttonId, lamiMatsSelected) {

                var regexNumber = /^\d+$/;
                // validate
                var labelQty = document.getElementById('txtLabelQuantity');
                labelQty.classList.remove('is-invalid');
                var labelWidth = document.getElementById('txtLabelWidth');
                labelWidth.classList.remove('is-invalid');
                var labelQtyRevise = 0, labelWidthRevise = 0;
                var validateResult = true;

                if (labelQty.value != "" && !regexNumber.test(labelQty.value.toString())) {
                    labelQty.classList.add('is-invalid');
                    validateResult = false;
                }
                else if (labelQty.value != "") {
                    labelQtyRevise = parseInt(labelQty.value);
                }

                if (labelWidth.value != "" && !regexNumber.test(labelWidth.value.toString())) {
                    labelWidth.classList.add('is-invalid');
                    validateResult = false;
                }
                else if (labelWidth.value != "") {
                    labelWidthRevise = parseInt(labelWidth.value);
                }

                if (!validateResult) {
                    return;
                }

                $.ajax({
                    url: '<%= ResolveUrl("~/Pages/WHLamination/WHLaminationHome.aspx/GetScoreByOrderNoIdByRound") %>',
                    data: { "orderNoId": '"' + orderNoId + '"', "btnRoundId": '"' + buttonId + '"' },
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
                            alert(data.d);
                        }
                        else {
                            var matsScore = JSON.parse(data.d);
                            if (labelWidthRevise > 0) {
                                matsScore.LabelWidth = labelWidthRevise;
                            }
                            if (labelQtyRevise > 0) {
                                matsScore.LabelQuantity = labelQtyRevise;
                            }

                            DisplayMatsInfor(matsScore, lamiMatsSelected);

                            // Display divScore
                            const divScore = document.getElementById('divScore');
                            const divScoreSave = document.getElementById('divScoreSave');
                            divScore.style.display = 'block';
                            divScoreSave.style.display = 'block';

                            currentLMScore = matsScore;
                            DisplayPoint(currentLMScore, '', true);

                            // Close Modal
                            $('#btnCloseModelInputMaterialDetail').click();
                            return false;
                        }
                    },
                    error: onError
                })
            }

            function DispayModalData(matsScore) {
                const txtLabelQuantity = document.getElementById('txtLabelQuantity');
                txtLabelQuantity.setAttribute('class', 'form-control');
                txtLabelQuantity.value = '';
                
                const txtLabelWidth = document.getElementById('txtLabelWidth');
                txtLabelWidth.setAttribute('class', 'form-control');
                txtLabelWidth.value = '';

                if (matsScore != null) {
                    if (matsScore.LabelQuantity != 0) {
                        txtLabelQuantity.value = matsScore.LabelQuantity;
                    }
                    
                    if (matsScore.LabelWidth != 0) {
                        txtLabelWidth.value = matsScore.LabelWidth;
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
                    pMatsName.innerText = lamiMatsSelected.MaterialName + ' Round: ' + matsScore.RoundCheck;
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
                    liPOQuantity.innerText      = 'Product Quantity: ' + lamiMatsSelected.POQuantity;
                    const liSendQuantity = document.createElement("li");
                    liSendQuantity.innerText    = 'Send Quantity: ' + lamiMatsSelected.SendQuantity;
                    divMatsInforColumn31.appendChild(liPOQuantity);
                    divMatsInforColumn31.appendChild(liSendQuantity);
                }
                if (matsScore != null) {
                    const liLabelQuantity = document.createElement("li");
                    liLabelQuantity.innerText   = 'Label Quantity: ' + matsScore.LabelQuantity;

                    const liLabelWidth = document.createElement("li");
                    liLabelWidth.innerText      = 'Label Width: ' + matsScore.LabelWidth;

                    divMatsInforColumn32.appendChild(liLabelQuantity);
                    divMatsInforColumn32.appendChild(liLabelWidth);
                }
            }

            function DisplayPoint(currentLMScore, buttonId, displayOldData) {

                document.getElementById('lblNoOfDefects').innerText = '';
                document.getElementById('lblTotalScore').innerText = '';

                document.getElementById('divCardScore').classList.remove('border-danger');
                document.getElementById('divCardScore').classList.remove('bg-danger');
                document.getElementById('lblNoOfDefects').classList.remove('text-danger');
                document.getElementById('lblTotalScore').classList.remove('text-danger');
                document.getElementById('btnSave').classList.remove('btn-danger');

                document.getElementById('divCardScore').classList.remove('border-success');
                document.getElementById('divCardScore').classList.remove('bg-success');
                document.getElementById('lblNoOfDefects').classList.remove('text-success');
                document.getElementById('lblTotalScore').classList.remove('text-success');
                document.getElementById('btnSave').classList.remove('btn-success');

                if (displayOldData) {
                    document.getElementById('spDefectType1').innerText = currentLMScore.DefectType1;
                    document.getElementById('spDefectType2').innerText = currentLMScore.DefectType2;
                    document.getElementById('spDefectType3').innerText = currentLMScore.DefectType3;
                    document.getElementById('spDefectType4').innerText = currentLMScore.DefectType4;
                    document.getElementById('spHoleType2').innerText = currentLMScore.HoleType2;
                    document.getElementById('spHoleType4').innerText = currentLMScore.HoleType4;

                    txtPlusActualQuantity.value = currentLMScore.ActualQuantity;
                    txtPlusActualWidth.value    = currentLMScore.ActualWidth;
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

                var totalPoint = CalculateNoOfDefects(currentLMScore);
                document.getElementById('lblNoOfDefects').innerText = totalPoint;
                var actualQty   = txtPlusActualQuantity.value;
                var actualWidth = txtPlusActualWidth.value;

                var totalScore = (totalPoint / actualQty) * (36 / actualWidth) * 100;
                document.getElementById('lblTotalScore').innerText = Math.round(totalScore);

                currentLMScore.NoOfDefects      = totalPoint;
                currentLMScore.TotalScore       = Math.round(totalScore);;
                currentLMScore.ActualWidth      = actualWidth;
                currentLMScore.ActualQuantity   = actualQty;

                // Material Fail
                if (totalScore > 0 && totalScore <= 20) {
                    document.getElementById('divCardScore').classList.add('border-success');
                    document.getElementById('divCardScore').classList.add('bg-success');
                    document.getElementById('lblNoOfDefects').classList.add('text-success');
                    document.getElementById('lblTotalScore').classList.add('text-success');
                    document.getElementById('btnSave').classList.add('btn-success');
                }
                // Material Pass
                else if (totalScore > 0 && totalScore > 20) {
                    document.getElementById('divCardScore').classList.add('border-danger');
                    document.getElementById('divCardScore').classList.add('bg-danger');
                    document.getElementById('lblNoOfDefects').classList.add('text-danger');
                    document.getElementById('lblTotalScore').classList.add('text-danger');
                    document.getElementById('btnSave').classList.add('btn-danger');
                }

                document.getElementById("btnDefectType1").onclick = function () { DisplayPoint(currentLMScore, 'btnDefectType1', false) };
                document.getElementById("btnDefectType2").onclick = function () { DisplayPoint(currentLMScore, 'btnDefectType2', false) };
                document.getElementById("btnDefectType3").onclick = function () { DisplayPoint(currentLMScore, 'btnDefectType3', false) };
                document.getElementById("btnDefectType4").onclick = function () { DisplayPoint(currentLMScore, 'btnDefectType4', false) };
                document.getElementById("btnHoleType2").onclick = function () { DisplayPoint(currentLMScore, 'btnHoleType2', false) };
                document.getElementById("btnHoleType4").onclick = function () { DisplayPoint(currentLMScore, 'btnHoleType4', false) };

                document.getElementById("btnReset").onclick = function () { ResetScoreArea(currentLMScore) };
                document.getElementById("btnSave").onclick = function () { ShowSavingData(currentLMScore) };
                document.getElementById("btnConfirmSave").onclick = function () { SaveScore(currentLMScore) };

                //
                //document.getElementById("btnPlusActualWidth").onclick = function () { plusActualWidth(currentLMScore) };
                //document.getElementById("btnPlusActualQuantity").onclick = function () { plusActualQuantity(currentLMScore) };

                document.getElementById("txtPlusActualQuantity").onkeyup = function () { UpdateScoreByQuantity(currentLMScore) };
                document.getElementById("txtPlusActualWidth").onkeyup = function () { UpdateScoreByWidth(currentLMScore) };

                return false;
            }

            function ShowSavingData(currentLMScore) {
                var divReject = document.getElementById("divRejectCheckbox");
                divReject.innerHTML = '';
                var pTitle = document.createElement('p');
                pTitle.innerText = 'Check Remarks';
                pTitle.className = 'pt-0 pb-0 mb-1';
                divReject.appendChild(pTitle);

                var divRejectContent = document.createElement('div');
                divRejectContent.className = 'col-auto';
                // Create Checkbox rejectlist
                var noOfReject = 1;
                rejectsWHLamination.forEach(function (item) {
                    var divByItem = document.createElement('div');
                    divByItem.className = 'form-check form-check-inline';
                    var checkBoxByItem = document.createElement('input');
                    checkBoxByItem.className = 'form-check-input mt-1';
                    checkBoxByItem.value = item.RejectName;
                    checkBoxByItem.type = 'checkbox';
                    checkBoxByItem.id = 'inlineCheckbox' + item.RejectId;

                    var labelByItem = document.createElement('label');
                    labelByItem.className = 'form-check-label';
                    //var forAttributes = document.createAttribute('for');
                    //forAttributes.value = 'inlineCheckbox' + item.RejectId;
                    //labelByItem.attributes.add(forAttributes);
                    var attValue = 'inlineCheckbox' + item.RejectId;
                    labelByItem.setAttribute("for", attValue);
                    labelByItem.innerText = noOfReject + '. ' + item.RejectName + item.RejectName_1;

                    divByItem.appendChild(checkBoxByItem);
                    divByItem.appendChild(labelByItem);
                    divRejectContent.appendChild(divByItem);
                    noOfReject++;
                });

                divReject.appendChild(divRejectContent);

                document.getElementById("pConfirmOrderNoId").textContent        = currentLMScore.OrderNoId;
                document.getElementById("pConfirmRound").textContent            = currentLMScore.RoundCheck;
                document.getElementById("pConfirmActualQuantity").textContent   = currentLMScore.ActualQuantity;
                document.getElementById("pConfirmActualWidth").textContent      = currentLMScore.ActualWidth;
                document.getElementById("pConfirmNoOfDefects").textContent      = currentLMScore.NoOfDefects;
                document.getElementById("pConfirmTotalScore").textContent       = currentLMScore.TotalScore;
                document.getElementById("pConfirmCreatedTime").textContent      = document.getElementById("MyClockDisplay").innerText;
                document.getElementById("pConfirmUser").textContent             = currentLMScore.Reviser;
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
                var noOfDefects     = currentLMScore.NoOfDefects;
                var roundCheck      = currentLMScore.RoundCheck;

                var listOfRemarks = new Array();
                rejectsWHLamination.forEach(function (item) {
                    var chkId =  'inlineCheckbox' + item.RejectId;
                    var checkBoxById = document.getElementById(chkId);
                    if (checkBoxById.checked)
                        listOfRemarks.push(checkBoxById.value);
                });
                var remarks = listOfRemarks.join('; ');
                //jQuery.ajax({
                //var contentUpload = JSON.stringify({ laminationScore: currentLMScore });
                $.ajax({
                    url: '<%= ResolveUrl("~/Pages/WHLamination/WHLaminationHome.aspx/SaveScore") %>',
                    data: {
                        "orderNoId": '"' + orderNoId + '"', "poQuantity": '"' + poQuantity + '"', "labelQuantity": '"' + labelQuantity + '"', "actualQuantity": '"' + actualQuantity + '"',
                        "labelWidth": '"' + labelWidth + '"', "actualWidth": '"' + actualWidth + '"', "defectType1": '"' + defectType1 + '"', "defectType2": '"' + defectType2 + '"',
                        "defectType3": '"' + defectType3 + '"', "defectType4": '"' + defectType4 + '"', "holeType2": '"' + holeType2 + '"', "holeType4": '"' + holeType4 + '"',
                        "totalScore": '"' + totalScore + '"', "reviser": '"' + reviser + '"', "roundCheck": '"' + roundCheck + '"', "noOfDefects": '"' + noOfDefects + '"',
                        "remarks": '"' + remarks + '"'
                    },
                    //data: contentUpload,
                    type: "GET",
                    datatype: "json",
                    async: true,
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d === 'Successful !') {
                            $('#btnConfirmSaveClose').click();
                            alert(data.d);
                            ToastReset(currentLMScore);
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

                document.getElementById('lblNoOfDefects').innerText = '0';
                document.getElementById('lblTotalScore').innerText = '0';
                document.getElementById('divCardScore').classList.remove('border-danger');
                document.getElementById('divCardScore').classList.remove('bg-danger');
                document.getElementById('lblNoOfDefects').classList.remove('text-danger');
                document.getElementById('lblTotalScore').classList.remove('text-danger');
                document.getElementById('btnSave').classList.remove('btn-danger');

                document.getElementById('divCardScore').classList.remove('border-success');
                document.getElementById('divCardScore').classList.remove('bg-success');
                document.getElementById('lblNoOfDefects').classList.remove('text-success');
                document.getElementById('lblTotalScore').classList.remove('text-success');
                document.getElementById('btnSave').classList.remove('btn-success');

                currentLMScore.DefectType1  = 0;
                currentLMScore.DefectType2  = 0;
                currentLMScore.DefectType3  = 0;
                currentLMScore.DefectType4  = 0;

                currentLMScore.HoleType2    = 0;
                currentLMScore.HoleType4    = 0;
                currentLMScore.TotalScore   = 0;
                currentLMScore.NoOfDefects  = 0;

                currentLMScore.ActualWidth  = 1;
                currentLMScore.ActualQuantity = 1;


                document.getElementById('spDefectType1').innerText = '0';
                document.getElementById('spDefectType2').innerText = '0';
                document.getElementById('spDefectType3').innerText = '0';
                document.getElementById('spDefectType4').innerText = '0';
                document.getElementById('spHoleType2').innerText = '0';
                document.getElementById('spHoleType4').innerText = '0';

                txtPlusActualWidth.value    = 1;
                txtPlusActualQuantity.value = 1;
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
                var sources = JSON.parse(data.d);
                var laminationMaterialList = sources[0];
                rejectsWHLamination = sources[1];

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

            function plusActualWidth(currentLMScore) {
                var currentValue = txtPlusActualWidth.value;
                txtPlusActualWidth.classList.remove('is-invalid');
                var regexNumber = /^\d+$/;
                if (!regexNumber.test(currentValue.toString())) {
                    $('#txtPlusActualWidth').select();
                    txtPlusActualWidth.classList.add('is-invalid');
                    return;
                }
                else {
                    var currentValueInt = parseInt(currentValue);
                    txtPlusActualWidth.value = currentValueInt + 1;
                    currentLMScore.ActualWidth = currentValueInt + 1;
                    DisplayPoint(currentLMScore, '', true);
                }
            }

            function plusActualQuantity(currentLMScore) {
                var currentValue = txtPlusActualQuantity.value;
                txtPlusActualQuantity.classList.remove('is-invalid');
                var regexNumber = /^\d+$/;
                if (!regexNumber.test(currentValue.toString())) {
                    $('#txtPlusActualQuantity').select();
                    txtPlusActualQuantity.classList.add('is-invalid');
                    return;
                }
                else {
                    var currentValueInt = parseInt(currentValue);
                    txtPlusActualQuantity.value = currentValueInt + 1;
                    currentLMScore.ActualQuantity = currentValueInt + 1;
                    DisplayPoint(currentLMScore, '', true);
                }
            }

            function UpdateScoreByQuantity(currentLMScore) {
                var currentValue = txtPlusActualQuantity.value;
                txtPlusActualQuantity.classList.remove('is-invalid');
                var regexNumber = /^\d+$/;
                if (!regexNumber.test(currentValue.toString())) {
                    $('#txtPlusActualQuantity').select();
                    txtPlusActualQuantity.classList.add('is-invalid');
                    return;
                }
                else {
                    var currentValueInt = parseInt(currentValue);
                    currentLMScore.ActualQuantity = currentValueInt;
                    DisplayPoint(currentLMScore, '', true);
                }
            }

            function UpdateScoreByWidth(currentLMScore) {
                var currentValue = txtPlusActualWidth.value;
                txtPlusActualWidth.classList.remove('is-invalid');
                var regexNumber = /^\d+$/;
                if (!regexNumber.test(currentValue.toString())) {
                    $('#txtPlusActualWidth').select();
                    txtPlusActualWidth.classList.add('is-invalid');
                    return;
                }
                else {
                    var currentValueInt = parseInt(currentValue);
                    currentLMScore.ActualWidth = currentValueInt;
                    DisplayPoint(currentLMScore, '', true);
                }
            }

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
                                            <i class="fa fa-clock-o text-info"></i><a class="ml-1 p-0 text-danger" id="MyClockDisplay"></a>
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
                            <div id="divScore" class="col-12 col-sm-12 col-md-8 h-100" style="display:none;">
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
                                        <%--<div class="col-3">
                                            <a class="btn btn-app bg-secondary btn-lg h-100 w-100" style="font-size: 1.5rem;">
                                                <span class="badge bg-success" style="font-size: 1.3rem;">1000</span>
                                                <i class="fas fa-barcode"></i> Products
                                            </a>
                                        </div>--%>
                                    </div>
                                </div>
                                
                                <div class="container p-0 m-0">
                                    <div class="row"><h6>Hole</h6></div>
                                    <div class="row">
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
                                        
                                        <div class="col-6">
                                            <div class="row h-100 align-items-end">
                                                <div class="col">
                                                    <p class="m-0 text-center">Actual Qty</p>
                                                    <div class="input-group input-group">
                                                        <%--<button type="button" class="input-group-text btn btn-outline-secondary rounded-0" id="btnPlusActualQuantity"><i class="fa fa-plus text-info"></i></button>--%>
                                                        <input type="text" id="txtPlusActualQuantity" class="form-control rounded-0 text-center" aria-label="Sizing example input">
                                                    </div>
                                                </div>
                                                <div class="col">
                                                    <p class="m-0 text-center">Actual Width</p>
                                                    <div class="input-group input-group">
                                                        <%--<button type="button" class="input-group-text btn btn-outline-secondary rounded-0" id="btnPlusActualWidth"><i class="fa fa-plus text-info"></i></button>aria-describedby="btnPlusActualWidth"--%>
                                                        <input type="text" class="form-control rounded-0 text-center" id="txtPlusActualWidth" aria-label="Sizing example input">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="divScoreSave" class="col-12 col-sm-12 col-md-4 mt-1 mt-md-0 h-100" style="display:none;">
                                <div id="divCardScore" class="card rounded-0 shadow-sm w-100">
                                    <div class="card-header rounded-0 text-center">
                                        <div class="row p-0 m-0 align-items-center">
                                            <div class="col text-left"><h4 class="p-0 m-0">Total</h4></div>
                                            <div class="col-auto p-0 m-0">
                                                <button id="btnReset" type="button" class="btn btn-sm rounded-2" data-bs-toggle="modal" data-bs-target="#modalDisplayToast">
                                                    <i class="fa fa-refresh fa-1x mr-2"></i>Reset</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body bg-white">
                                        <div class="row h-100 p-0">
                                            <div class="col">
                                                <p class="p-0 m-0 text-center">#Defect</p>
                                                <h1 id="lblNoOfDefects" class="card-title text-center" style="font-size:3.5rem;"></h1>
                                                
                                            </div>
                                            <div class="col">
                                                <p class="p-0 m-0 text-center">Score</p>
                                                <h1 id="lblTotalScore" data-bs-toggle="tooltip" data-bs-placement="bottom" title=" =(Defects/ActQty)*(36/ActWidth)*100" class="card-title text-center" style="font-size:3.5rem;"></h1>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-footer bg-transparent p-0 m-0">
                                        <button id="btnSave" class="btn btn-lg w-100 rounded-0 border-0" type="button" data-bs-toggle="modal" data-bs-target="#modalConfirmSave">SAVE</button>
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
                      <div class="row">
                          <div class="col">
                              <div class="form-floating">
                                  <input class="form-control" id="txtLabelQuantity" placeholder=" ">
                                  <label for="txtLabelQuantity">Label Quantity</label>
                              </div>
                          </div>
                          <div class="col">
                              <div class="form-floating">
                                  <input class="form-control" id="txtLabelWidth" placeholder=" ">
                                  <label for="txtLabelWidth">Label Width</label>
                              </div>
                          </div>
                      </div>
                      <div id="divRoundList" class="row mt-1 g-1 row-cols-auto">
                      </div>
                  </div>
                  <div class="modal-footer">
                    <button id="btnStart" type="button" class="btn btn-success">Start New Round</button>
                  </div>
                </div>
              </div>
            </div>
            
            <!-- Modal Toast Reset-->
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
            <!--
                <p class="pt-0 pb-0 mb-1">Check remarks</p>
                          <div class="col-auto">
                              <div class="form-check form-check-inline">
                                  <input class="form-check-input mt-1" type="checkbox" id="inlineCheckbox1" value="option1">
                                  <label class="form-check-label" for="inlineCheckbox1">Error 1</label>
                              </div>
                              <div class="form-check form-check-inline">
                                  <input class="form-check-input mt-1" type="checkbox" id="inlineCheckbox2" value="option2">
                                  <label class="form-check-label" for="inlineCheckbox2">Error 2</label>
                              </div>
                              <div class="form-check form-check-inline">
                                  <input class="form-check-input mt-1" type="checkbox" id="inlineCheckbox3" value="option3">
                                  <label class="form-check-label" for="inlineCheckbox3">Error 3Error 3Error 3Error 3</label>
                              </div>
                              <div class="form-check form-check-inline">
                                  <input class="form-check-input mt-1" type="checkbox" id="inlineCheckbox4" value="option4">
                                  <label class="form-check-label" for="inlineCheckbox4">Error 4Error 4Error 4Error 4Error 4Error 4Error 4Error 4</label>
                              </div>
                          </div>
            -->
            <!-- Modal Confirm Save-->
            <div class="modal fade rounded-0" id="modalConfirmSave" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title text-success" id="staticBackdropLabel">Confirm Save</h5>
                    <button id="btnConfirmSaveClose" type="button" class="btn-close text-danger" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body pt-0 pb-0 text-primary">
                      <div id="divRejectCheckbox" class="row mb-2 bg-light text-danger align-items-center">
                          
                      </div>
                      <div class="row">
                          <div class="col-auto">
                              <p class="mb-1">Order No Id:</p>
                              <p class="mb-1">Round:</p>
                              <p class="mb-1">Actual Quantity:</p>
                              <p class="mb-1">Actual Width:</p>
                              <p class="mb-1">No of Defects:</p>
                              <p class="mb-1">Total Score:</p>
                              <p class="mb-1">Created Time:</p>
                              <p class="mb-0">User:</p>
                          </div>
                          <div class="col-auto">
                              <p class="mb-1" id="pConfirmOrderNoId"></p>
                              <p class="mb-1" id="pConfirmRound"></p>
                              <p class="mb-1" id="pConfirmActualQuantity"></p>
                              <p class="mb-1" id="pConfirmActualWidth"></p>
                              <p class="mb-1" id="pConfirmNoOfDefects"></p>
                              <p class="mb-1" id="pConfirmTotalScore"></p>
                              <p class="mb-1" id="pConfirmCreatedTime"></p>
                              <p class="mb-0" id="pConfirmUser"></p>
                          </div>
                      </div>
                  </div>
                  <div class="modal-footer">
                      <div class="row w-100">
                          <div class="col">
                              <button id="btnConfirmSave" type="button" class="btn btn-outline-success float-left"><i class="fa fa-check-circle text-info mr-2" aria-hidden="true"></i>Save</button>
                          </div>
                          <div class="col">

                          </div>
                          <div class="col float">
                              <button type="button" class="btn btn-outline-danger float-right" data-bs-dismiss="modal"><i class="fa fa-times-circle text-warning mr-2" aria-hidden="true"></i>Cancel</button>
                          </div>
                      </div>
                  </div>
                </div>
              </div>
            </div>

            <script type="text/javascript" src="assets/zxing.js"></script>
            <script type="text/javascript" language="javascript">
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

                        //if (videoInputDevices.length >= 1) {
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
                                        //document.getElementById('result').textContent = result.text
                                        $(document).ready(function () {
                                            document.getElementById("txtOrderNoBarcode").value = result.text

                                            // Close Modal
                                            document.getElementById('btnCloseModal').click();
                                            // Click Search Button
                                            document.getElementById('btnSearchByOrderNo').click();
                                        });
                                    }
                                    if (err && !(err instanceof ZXing.NotFoundException)) {
                                        console.error(err)
                                        document.getElementById("txtOrderNoBarcode").value = err
                                    }
                                })
                                console.log(`Started continous decode from camera with id ${selectedDeviceId}`)
                            };                           
                        //}

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
                                        // Close Modal
                                        document.getElementById('btnCloseModal').click();
                                        // Click Search Button
                                        document.getElementById('btnSearchByOrderNo').click();
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
            </script>
        </body>
    </html>
</asp:Content>