<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebsiteTesting.Pages.MachineInventory.Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width">
    <title>Testing</title>
</head>
<body>
    <form id="formMain" runat="server">
    <div>
        <asp:FileUpload ID="fileUpload" runat="server" />
        <br />
        <asp:Button ID="btnOK" runat="server" Text="Upload & Read Barcode" OnClick="btnOK_Click"
            Font-Bold="true" />
        <br />
        <asp:Image ID="imageBarcode" runat="server" />
        <br />
        <asp:Label ID="lblResult" runat="server" Text="Result"></asp:Label>
    </div>
    </form>
</body>
</html>
