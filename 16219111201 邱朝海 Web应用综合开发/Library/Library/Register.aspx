<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Library.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>注册</title>
    <link href="Css/default.css" rel="stylesheet" />
    <link href="Css/regist.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div class="main">
        <div id="top">
            <h1>图书资料管理系统</h1>
        </div>
        <div id="regist">
            <table>
                <tr>
                    <td id="rg1" colspan="2"><b>注册窗口</b></td>
                </tr>
                <tr>
                    <td style="width: 78px; height: 26px">
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
                    <td style="width: 78px">
                        <asp:Label ID="Label1" runat="server" Text="确认密码:"/>
                    </td>
                    <td><asp:TextBox ID="txtLoginPwd2" runat="server" TextMode="Password" /></td>
                </tr>
                <tr>
                    <td style="width: 78px">
                        <asp:Label ID="Label2" runat="server" Text="姓名:"/>
                    </td>
                    <td><asp:TextBox ID="txtName" runat="server"/></td>
                </tr>
                <tr>
                    <td style="width: 78px">
                        <asp:Label ID="Label3" runat="server" Text="性别:"/>
                    </td>
                    <td>
                        <asp:RadioButton ID="RadioButton3" runat="server" text="男"/>
                        &nbsp&nbsp
                        <asp:RadioButton ID="RadioButton4" runat="server" text="女"/>
                    </td>
                </tr>
                <tr>
                    <td style="width: 78px">
                        <asp:Label ID="Label4" runat="server" Text="联系电话:"/>
                    </td>
                    <td><asp:TextBox ID="txtTel" runat="server"/>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationExpression="\d{11}"
                            ControlToValidate="txtTel" ErrorMessage="手机号位数不正确">*</asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td style="width: 78px">
                        <asp:Label ID="Label5" runat="server" Text="所属院校:"/>
                    </td>
                    <td>
                        <asp:DropDownList ID="DropDownList1" runat="server">
                            <asp:ListItem>文法学院</asp:ListItem>
                            <asp:ListItem>数信学院</asp:ListItem>
                            <asp:ListItem>艺术学院</asp:ListItem>
                            <asp:ListItem>建筑学院</asp:ListItem>
                            <asp:ListItem>体育学院</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="height: 26px; text-align: center">
                        <asp:Button ID="btnRegist" runat="server" OnClick="btnRegist_Click" Text=" 注册 " style="height: 21px" />
                        &nbsp&nbsp
                        <asp:Button ID="btnBack" runat="server" Text=" 返回 " style="height: 21px" OnClick="btnBack_Click"/>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </form>
</body>
</html>
