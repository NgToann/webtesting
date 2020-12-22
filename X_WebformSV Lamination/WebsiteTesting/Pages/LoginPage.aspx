<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="WebsiteTesting.Pages.LoginPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="~/assets/css/bootstrap.css" rel="Stylesheet"/>
    <link href="~/assets/css/style.css" rel="Stylesheet"/>

    <script src="~/assets/js/jquery-3.3.1.min.js"></script>
    <script src="~/assets/js/popper.min.js"></script>
    <script src="~/assetsjs/bootstrap.min.js"></script>

    <style>
        
        body {
          font-family: 'Nunito', sans-serif;
          color: #fefefe;
          background: #fefefe;
        }
        .wrapper {
          margin: 0 auto;
          width: 400px;
          box-shadow: 0 3px 6px rgba(0, 0, 0, 0.16), 0 3px 6px rgba(0, 0, 0, 0.23);
          vertical-align: central;
          align-content: center;
        }
        .section {
          padding: 1rem;
        }
        .header {
          position: relative;
          text-align: center;
          height: 160px;
          background-color: transparent;
        }
        .header__text {
          position: relative;
          padding: 2rem;
        }
        .header__text > h1 {
          margin: 0;
          font-size: 2.5rem;
          font-weight: 550;
          color: #fefefe;
	      text-shadow: 1px 1px 20px rgba(0, 0, 0, 0.16);
        }
        .header > .trapezoid {
          position: absolute;
          top: 0;
          left: 0;
          width: 100%;
          height: 100%;
          transform: skewY(-8deg);
          transform-origin: top left;
          box-shadow: 0 3px 6px rgba(0, 0, 0, 0.16), 0 3px 6px rgba(0, 0, 0, 0.23);
          background-color: #ff6a00;
          background-position: top center;
          background-attachment: fixed;
        }
        form {
          margin: 0 auto;
          max-width: 20rem;
          overflow: auto;
        }
        form > * + * {
          margin-top: 1rem;
        }
        form > input {
          border: 0;
          border-bottom: 1px solid #1126be;
          border-radius: 0;
          width: 100%;
          height: 2rem;
          padding: 0 0 0.25rem 0;
          font-size: 1rem;
          color: #1126be;
          background: #fefefe;
        }
        form > input:focus {
          outline: none;
        }
        form > input::placeholder {
          color: #1126be;
        }
        form > button {
          margin-top: 2rem;
          border: 0;
          border-radius: 200px;
          width: 100%;
          padding: 0.85rem;
          font-size: 1rem;
          color: #fefefe;
          background: #1126be;
        }
        form > button:focus {
          outline: none;
        }
        form > p {
          margin: 0.25rem 0 0;
          text-align: center;
          color: #1126be;
        }
        .sign-up {
          display: none;
        }
        .opposite-btn1, .opposite-btn2 {
          cursor: pointer;
        }

        .section label {
            color: #000000;
            line-height: 1rem;
        }
        .formLogin table td {
            margin-top: 10px !important;
            margin-bottom: 10px !important;
            line-height: 1.2rem;
        }

        #loginMain_Password, #loginMain_UserName {
            padding-left: 3px !important;
            padding-top: 3px !important;
            padding-bottom: 3px !important;
        }
        table {
            padding: 5px;
        }
        table tr td
        {
            padding: 5px;
            margin: 5px;
        }
        table tr td label {
            padding-top: 8px;
        }
        
        #loginMain_RememberMe {
            margin-right: 10px;
        }
    </style>
</head>
    
<body>
    <div class="container p-0 text-center align-items-center SVContent">
        <div class="wrapper">
            <!--Header-->
            <header class="section header">
            <div class="trapezoid"></div>
            <div class="header__text">
                <h1><asp:Label ID="lblFactory" Text="Welcome" runat="server"></asp:Label></h1>
                <p></p>
            </div>
            </header>

            <!--Sign In-->
            <section class="section sign-in">
                <form class="formLogin" id="formMain" runat="server">
                    <asp:Login ID="loginMain" runat="server" FailureText="Login Fail!" OnAuthenticate="loginMain_Authenticate"
                        PasswordRequiredErrorMessage="Enter Password" 
                        RememberMeText="Remember Me?" UserNameLabelText="User ID:"
                        UserNameRequiredErrorMessage="Enter User ID">
                    </asp:Login>
                </form>
            </section>
        </div>

        <footer class="page-footer font-small">
            <div class="footer-copyright text-center py-3">© 2020 Created by:<a runat="server" href="#"> IT Saoviet</a></div>
        </footer>
    </div>
    
</body>
</html>
