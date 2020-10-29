<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangeCustomerModePage.aspx.cs" Inherits="WebsiteTesting.Pages.Saoviet.ChangeCustomerModePage" MasterPageFile="../../Main.Master" %>

<asp:content runat="server" contentplaceholderid="head">
    <title>Change Visitor Mode</title>
    </asp:content>
<asp:content runat="server" contentplaceholderid="contentPlaceHolder">    
    <asp:Button ID="btnOnAllLine" runat="server" Text="ON ALL..." 
        Tooltip="CLICK TO TURN ON CUSTOMER MODE FOR ALL LINE" Font-Bold="true" 
        ForeColor="Green" onclick="btnOnAllLine_Click"/>
    <asp:Button ID="btnOffAllLine" runat="server" Text="OFF ALL..." 
        Tooltip="CLICK TO TURN OFF CUSTOMER MODE FOR ALL LINE" Font-Bold="true" 
        ForeColor="Red" onclick="btnOffAllLine_Click"/>
    <asp:Table id="tableMain" runat="server">
    </asp:Table>    
   </asp:content>
