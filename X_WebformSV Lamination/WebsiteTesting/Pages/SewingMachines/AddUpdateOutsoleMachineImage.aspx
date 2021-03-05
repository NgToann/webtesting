﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddUpdateOutsoleMachineImage.aspx.cs" Inherits="WebsiteTesting.Pages.SewingMachines.AddUpdateOutsoleMachineImage" MasterPageFile="~/Main.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
<!DOCTYPE html>
    <head>
        <title>Sewing Machines Database</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="../../assets/css/styleForPage.css" rel="Stylesheet"/>
        <link rel="stylesheet" href="assets/jquery-ui.css">
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="assets/jquery-1-12.4.js"></script>
        <script src="assets/jquery-ui.js"></script>
        <script src="//code.jquery.com/jquery-1.12.4.js"></script>
        <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
        
	    <script type="text/javascript" language="javascript">
            $(function () {
                <%--//$('#<%=txtCreatedDate.ClientID %>').datepicker();--%>
                $('#txtDate').datepicker();
            });
        </script>
        <script type="text/javascript" language="JavaScript">
            
        </script>
    </head>
    <html>
        <body>
            <asp:ScriptManager ID="scriptManagerUpdateMachineImage" runat="server" EnablePageMethods="true" />
            <!--Main layout-->
            <div class="container SVContent">

                <!--Navigator-->
                <nav class="breadcrumb breadcrumb_type5" aria-label="Breadcrumb" style="padding: 12px 16px;">
                    <ol class="breadcrumb__list r-list align-content-center">
                        <li class="breadcrumb__group">
                            <a href="../../Default.aspx" class="breadcrumb__point r-link"><i class="fa fa-home"></i>Home</a>
                            <span class="breadcrumb__divider" aria-hidden="true">›</span>
                        </li>
                        <li class="breadcrumb__group">
                            <a href="OutsolePaperHome.aspx" class="breadcrumb__point r-link">Outsole Paper Pressing</a>
                            <span class="breadcrumb__divider" aria-hidden="true">›</span>
                        </li>
                        <li class="breadcrumb__group">
                            <span class="breadcrumb__point" aria-current="page">Update Machine Image</span>
                        </li>
                    </ol>
                </nav>
                
                <!--Header-->
                <div>
                    <h3 class="font-weight-bold"><asp:Label ID="lblTitle" Text="Add New Image" runat="server"></asp:Label></h3>
                    <asp:Label ID="lblId" CssClass="d-none" runat="server"></asp:Label>
                </div>

                <div class="row g-2">
                    <div class="col-12 col-md-4">
                        <form class="small">
                            <div class="row">
                                <div class="col-12 col-sm-6">
                                    <div class="form-group mb-1">
                                        <label class="m-0" for="cboMachineType">Machine Type</label>
                                        <select class="form-select" id="cboMachineType">
                                          <option selected value="Universal">Universal</option>
                                          <option value="TopDown">TopDown</option>
                                          <option value="Air Bag">Air Bag</option>
                                          <option value="GTM">GTM</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-12 col-sm-6">
                                    <div class="form-group mb-1">
                                        <label class="m-0" for="cboSection">Section</label>
                                        <select class="form-select" id="cboSection">
                                          <option selected value="Assembly">Assembly</option>
                                          <option value="Outsole">Outsole</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group mb-1">
                                <label class="m-0">Date</label>
                                <input id="txtDate" class="form-control" placeholder="-- select a date --">
                            </div>
                            <div class="form-group mb-1">
                                <label class="m-0">Line</label>
                                <input class="form-control">
                            </div>
                            <div class="form-group mb-1">
                                <label class="m-0">Product No</label>
                                <input class="form-control">
                            </div>
                            <div class="form-group mb-1">
                                <label class="m-0">Style Name</label>
                                <input class="form-control">
                            </div>
                            <div class="form-group">
                                <label class="m-0">Outsole Code</label>
                                <input class="form-control">
                            </div>
                            <div class="row">
                                <div class="col-12 col-md-6 mb-2">
                                    <button type="submit" class="btn btn-primary float-left">Submit</button>
                                </div>
                                <div class="col-12 col-md-6">
                                    <!-- Button trigger modal -->
                                    <button type="button" class="btn btn-info float-left float-md-right" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                                        Open Camera
                                    </button>
                                </div>
                            </div>

                            <!--Camera Modal-->
                            <!-- Modal -->
                            <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title text-info">Take a picture <i class="fa fa-camera ml-2 text-danger fa-1x" aria-hidden="true"></i></h5>
                                        <button type="button" id="btnCloseModal" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body text-center bg-light">
                                        <div class="col ml-auto mr-auto mt-2 mb-2" id="my_camera"></div>
                                        <%--<div class="form-check form-check-inline">
                                            <button id="btnImgSize1" type="button" class="btn btn-sm btn-outline-info">350 x 250</button>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <button id="btnImgSize2" type="button" class="btn btn-sm btn-outline-info">480 x 320</button>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <button id="btnImgSize3" type="button" class="btn btn-sm btn-outline-info">640 x 480</button>
                                        </div>--%>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" onclick="take_left_snapshot()">Snap Left</button>
                                        <button type="button" class="btn btn-primary" onclick="take_right_snapshot()">Snap Right</button>
                                    </div>
                                </div>
                                </div>
                            </div>
                            
                        </form>
                    </div>
                    <div class="col-12 col-md-4">
                        <figure id="divLeftImage" class="figure mb-1 mb-sm-0">
                        </figure>
                        <figcaption id="fgCaptionLeft" class="figure-caption text-danger d-none">Left Image</figcaption>
                        <figure class="figure d-none">
                            <img id="imgLeftImage" src="assets/images/ospaper/pic1.jpg" class="figure-img img-fluid rounded" alt="Left Image">
                            <figcaption class="figure-caption text-danger">Left Image</figcaption>
                        </figure>
                    </div>
                    <div class="col-12 col-md-4">
                        <figure id="divRightImage" class="figure mb-1 mb-sm-0">
                        </figure>
                        <figcaption id="fgCaptionRight" class="figure-caption text-danger d-none">Right Image</figcaption>
                        <figure class="figure d-none">
                            <img src="assets/images/ospaper/pic2.jpg" class="figure-img img-fluid rounded" alt="Right Image">
                            <figcaption class="figure-caption text-danger">Right Image</figcaption>
                        </figure>
                    </div>
                </div>
            </div>

            <script type="text/javascript" src="assets/webcam.min.js"></script>
	        <!-- Configure a few settings and attach camera -->
	        <script type="text/javascript">
                Webcam.set({
                    width: 320,
                    height: 240,
                    dest_width: 640,
                    dest_height: 480,
                    image_format: 'png',
                    png_quality: 90,
                    constraints: {
                        facingMode: "environment",
                        frameRate: 30
                    }
                });
                Webcam.attach('#my_camera');

                //document.getElementById("btnImgSize1").onclick = function () { selectImageSize(320, 240) };
                //document.getElementById("btnImgSize2").onclick = function () { selectImageSize(480, 320) };
                //document.getElementById("btnImgSize3").onclick = function () { selectImageSize(640, 480) };
                function selectImageSize(width, height) {
                    //Webcam.reset()
                    Webcam.set({
                        width: width,
                        height: height,
                        dest_width: width,
                        dest_height: height,
                        image_format: 'png',
                        png_quality: 90,
                        constraints: {
                            facingMode: "environment",
                            frameRate: 30
                        }
                    });
                    Webcam.attach('#my_camera');
                }

                function take_left_snapshot() {
                    // take snapshot and get image data
                    Webcam.snap(function (data_uri) {
                        // display results in page
                        //document.getElementById('contentPlaceHolder_divLeftImage').innerHTML =
                        document.getElementById('divLeftImage').innerHTML =
                            '<img class="figure-img img-fluid rounded" src="' + data_uri + '"/>';
                        document.getElementById('btnCloseModal').click();
                    });
                    var fgCaptionLeft = document.getElementById('fgCaptionLeft');
                    fgCaptionLeft.className = 'figure-caption text-danger';
                }
                function take_right_snapshot() {
                    // take snapshot and get image data
                    Webcam.snap(function (data_uri) {
                        // display results in page
                        //document.getElementById('contentPlaceHolder_divRightImage').innerHTML =
                        document.getElementById('divRightImage').innerHTML =
                            '<img class="figure-img img-fluid rounded" src="' + data_uri + '"/>';
                        document.getElementById('btnCloseModal').click();
                    });
                    var fgCaptionRight = document.getElementById('fgCaptionRight');
                    fgCaptionRight.className = 'figure-caption text-danger';
                }
            </script>
        </body>
    </html>
</asp:Content>

