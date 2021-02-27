<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ImportPackingListPage.aspx.cs" Inherits="WebsiteTesting.Pages.LoadingSystem.ImportPackingListPage" MasterPageFile="../../Main.Master" %>
<asp:Content runat="server" ContentPlaceHolderID="contentPlaceHolder">
    <!DOCTYPE html>
    <head>
        <title>Loadding | Import Carton Numbering</title>
    </head>
    <html>
        <body>
            <!-- Content Header (Page header) -->
            <div class="content-header">
                    <div class="container">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                        <h3 class="m-0">Import packing list</h3>
                        </div><!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><p>Loading</p></li>
                                <li class="breadcrumb-item active">Import packing list</li>
                            </ol>
                        </div><!-- /.col -->
                    </div><!-- /.row -->
                    </div><!-- /.container-fluid -->
                </div>
            <!-- /.content-header -->
            <!-- Main content -->
            <div class="content">
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <asp:FileUpload ID="fileUpload" runat="server" />
                            <br />
                            <asp:Button ID="btnRead" runat="server" Text="Upload & Read" OnClick="btnRead_Click" />
                            <br />
                            <asp:Label runat="server" Text="Clear Old Packing List?"></asp:Label>
                            <asp:RadioButton ID="rbtnClear" runat="server" Text="Yes" GroupName="OldPackingList"
                                ForeColor="Red" />
                            <asp:RadioButton ID="rbtnKeep" runat="server" Text="No" GroupName="OldPackingList"
                                ForeColor="Green" Checked="true" />
                            <br />
                            <asp:Button ID="btnImport" runat="server" Text="Import" OnClick="btnImport_Click"
                                Font-Bold="true" Enabled="false" />
                            <br />
                            <asp:Label ID="lblStatus" runat="server" Text="..."></asp:Label>
                        </div>
                    </div>
                </div>
                <!-- /.container-fluid -->
            </div>
            <!-- /.content -->
        </body>
    </html>
</asp:Content>
