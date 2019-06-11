<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Library.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>图书资料管理系统</title>
    <link href="Css/default.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div  class="main">
        <div id="top">
            <h1>图书资料管理系统</h1>
        </div>
        <div class="status">
            您好，<asp:Label ID="lblUser" runat="server"></asp:Label>
            <asp:Literal ID="ltlUser" runat="server">
                <a href="LogIn.aspx">【登录】</a>
                <a href="Register.aspx">【免费注册】</a>
            </asp:Literal>
        </div>
        <div class="nav">
            <ul id="mainnav">
                <li><asp:Button ID="Button1" runat="server" Text="首页" OnClick="Button1_Click" /></li>
                <li><asp:Button ID="Button2" runat="server" Text="图书信息" OnClick="Button2_Click" /></li>
                <li><asp:Button ID="Button3" runat="server" Text="读者信息" OnClick="Button3_Click" /></li>
                <li><asp:Button ID="Button4" runat="server" Text="归还" OnClick="Button4_Click" /></li>
                <li><asp:Button ID="Button5" runat="server" Text="帮助" OnClick="Button5_Click" /></li>
            </ul>
        </div>
        <div class="img"></div>
        <div class="foot">
            <footer class="footer">
                <div>      
                    <p>Designed and built with all the love in the world by <a href="https://twitter.com/mdo" target="_blank">@mdo</a> and <a href="https://twitter.com/fat" target="_blank">@fat</a>. Maintained by the <a href="https://github.com/orgs/twbs/people">core team</a> with the help of <a href="https://github.com/twbs/bootstrap/graphs/contributors">our contributors</a>.</p>
                    <p>本项目源码受 <a rel="license" href="https://github.com/twbs/bootstrap/blob/master/LICENSE" target="_blank">MIT</a>开源协议保护，文档受 <a rel="license" href="https://creativecommons.org/licenses/by/3.0/" target="_blank">CC BY 3.0</a> 开源协议保护。</p>     
                </div>
            </footer>
        </div>
    </div>
    </form>
</body>
</html>
