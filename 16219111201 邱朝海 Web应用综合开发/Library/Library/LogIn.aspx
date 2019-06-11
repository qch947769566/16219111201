<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LogIn.aspx.cs" Inherits="Library.LogIn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>登录</title>
    <link href="Css/default.css" rel="stylesheet" />
    <link href="Css/login.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div class="main">
        <div id="top">
            <h1>图书资料管理系统</h1>
        </div>
        <div id="login">
            <table>
                <tr>
                    <td id="lg1" colspan="2">登录窗口</td>
                </tr>
                <tr>
                    <td style="width: 78px; height: 26px;">
                        <asp:Label ID="lblLoginId" runat="server" Text="用户名:"/>
                    </td>
                    <td><asp:TextBox ID="txtloginId" runat="server"/></td>
                </tr>
                <tr>
                    <td style="width: 78px">
                        <asp:Label ID="lblLoginPwd" runat="server" Text="密码:"/>
                    </td>
                    <td><asp:TextBox ID="txtLoginPwd" runat="server" TextMode="Password" /></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:RadioButton ID="RadioButton1" runat="server" text="读者"/>
                        &nbsp&nbsp&nbsp
                        <asp:RadioButton ID="RadioButton2" runat="server" Text="管理员" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="height: 26px; text-align: center">
                        <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text=" 登录 " style="height: 21px" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </form>
</body>
</html>
