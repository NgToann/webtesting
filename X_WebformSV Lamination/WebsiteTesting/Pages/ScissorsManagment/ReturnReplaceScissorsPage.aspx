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
                
                <div class="container p-0">
                    <div class="input-group">
                        <input id="txtWorkerId" type="text" class="form-control rounded-0" placeholder="Input WorkerID"/>
                        <input id="btnSearch" type="button" class="btn rounded-0 btn-outline-primary" value="Search"/>
                    </div>
                </div>
            </div>

            <script type="text/javascript">
                var currentReleaseScissorsList;
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
                                alert(JSON.stringify(currentReleaseScissorsList));

                                btnSearch.onclick = function () { searchReleaseScissors() };
                            }
                        },
                        error: onError
                    })
                });

                function onError() {
                    alert('An error occured at the backend !');
                };

                function searchReleaseScissors() {
                    var workerIdInput = document.getElementById('txtWorkerId').value;
                    var scissorsReleaseByWorkerId = currentReleaseScissorsList.filter(f => f.WorkerId == workerIdInput && f.Status == 'Borrowed');
                    if (scissorsReleaseByWorkerId.length == 0) {
                        alert('WorkerId: ' + workerIdInput + ' has`not borrowed any Scissors !');
                        return;
                    }
                };

            </script>
        </body>
    </html>
</asp:Content>
