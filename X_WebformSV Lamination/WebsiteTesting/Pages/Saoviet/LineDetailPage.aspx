<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LineDetailPage.aspx.cs"
    Inherits="WebsiteTesting.Pages.Saoviet.LineDetailPage" MasterPageFile="../../Main.Master" %>

<asp:content runat="server" contentplaceholderid="head">
    <title>Line Detail</title>
    </asp:content>
<asp:content runat="server" contentplaceholderid="contentPlaceHolder">
    <div>
        <asp:HyperLink runat="server" NavigateUrl="~/Pages/Saoviet">Back</asp:HyperLink>
    </div>
    <div>
        <asp:Label runat="server" Text="Line: "></asp:Label>
        <asp:Label ID="lblLineName" runat="server" Text=""></asp:Label>
    </div>
    <div>
        <asp:Label runat="server" Text="Production No.: "></asp:Label>
        <asp:Label ID="lblProductNo" runat="server" Text=""></asp:Label>
    </div>
    <div>
        <asp:Label runat="server" Text="OUTPUT: "></asp:Label>
        <asp:Label ID="lblOutput" runat="server" Text=""></asp:Label>
    </div>
    <div>
        <asp:Label runat="server" Text="RFT: "></asp:Label>
        <asp:Label ID="lblRft" runat="server" Text=""></asp:Label>
    </div>
    <div> 
        <asp:GridView ID="gridViewLineDetail" runat="server" 
            AutoGenerateColumns="false" AlternatingRowStyle-BackColor="LightGray" 
            onrowdatabound="gridViewLineDetail_RowDataBound">
        </asp:GridView>
    </div>
    </asp:content>
