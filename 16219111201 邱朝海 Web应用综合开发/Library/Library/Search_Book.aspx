<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Search_Book.aspx.cs" Inherits="Library.Search_Book" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>图书信息</title>
    <link href="Css/common.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div id="tit">
        <b style="font-size:x-large">图书资料管理系统</b>
    </div>
    <div style="text-align:center">
        <asp:Label ID="Label1" runat="server" Text="可输入图书名称进行查询"></asp:Label>
        &nbsp&nbsp
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        &nbsp
        <asp:Button ID="Button1" runat="server" Text="查询" OnClick="Button1_Click" />
        &nbsp&nbsp
        <asp:Button ID="Button2" runat="server" Text="首页" OnClick="Button2_Click" />
    </div>
    <div id="rep">
        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" 
            OnItemCommand="Repeater1_ItemCommand">
        <ItemTemplate>
            <div>
                <hr>
                <table id="tab">
                    <tr>
                        <td><b>图书编号：</b></td>
                        <td><%#Eval("BookID") %></td>
                        <td><b>索书号：</b></td>
                        <td><%#Eval("CallNumbe") %></td>
                        <td><b>图书ISBN：</b></td>
                        <td><%#Eval("BookISBN") %></td>
                    </tr>
                    <tr>
                        <td><b>图书名称：</b></td>
                        <td><%#Eval("BName") %></td>
                    </tr>
                    <tr>
                        <td><b>作者：</b></td>
                        <td><%#Eval("Author") %></td>
                        <td><b>出版社：</b></td>
                        <td><%#Eval("Press") %></td>
                        <td><b>单价：</b></td>
                        <td>￥<%#Eval("Pirce") %></td>
                    </tr>
                    <tr>
                        <td><b>图书状态：</b></td>
                        <td><%#Eval("Status") %></td>
                    </tr>
                    <tr>
                        <td><asp:Button ID="btnBorrow" runat="server" Text="借阅" 
                            CommandArgument='<%#Eval("BookID")+","+Eval("Status") %>' /></td>
                    </tr>
                </table>
            </div>
        </ItemTemplate>
    </asp:Repeater>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryConnectionString %>" SelectCommand="SELECT * FROM [Book]"></asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
