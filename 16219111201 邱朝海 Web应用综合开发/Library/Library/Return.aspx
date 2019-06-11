<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Return.aspx.cs" Inherits="Library.Return" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>归还</title>
    <link href="Css/common.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div id="tit">
        <b style="font-size:x-large">图书资料管理系统</b>
    </div>
    <div style="text-align:center">
        <asp:Label ID="Label1" runat="server" Text="可输入读者编号进行查询"></asp:Label>
        &nbsp&nbsp
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        &nbsp
        <asp:Button ID="Button1" runat="server" Text="查询" OnClick="Button1_Click" />
        &nbsp&nbsp
        <asp:Button ID="Button2" runat="server" Text="首页" OnClick="Button2_Click" />
    </div>
    <div id="rep">
        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" OnItemCommand="Repeater1_ItemCommand">
        <ItemTemplate>
            <div>
                <hr>
                <table id="tab">
                    <tr>
                        <td><b>读者编号：</b></td>
                        <td><%#Eval("ReaderID") %></td>
                        <td><b>图书编号：</b></td>
                        <td><%#Eval("BookID") %></td>
                    </tr>
                    <tr>
                        <td><b>借阅日期：</b></td>
                        <td><%#Eval("BorrowDate") %></td>
                        <td><b>预期归还日期：</b></td>
                        <td><%#Eval("Expect_Return_Time") %></td>
                    </tr>
                    <tr>
                        <td><b>是否续借：</b></td>
                        <td><%#Eval("Renew") %></td>
                    </tr>
                    <tr>
                        <td><asp:Button ID="btnBorrow" runat="server" Text="归还" CommandArgument='<%#Eval("BookID")+","+Eval("Expect_Return_Time") %>' /></td>
                    </tr>
                </table>
            </div>
        </ItemTemplate>
    </asp:Repeater>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryConnectionString %>" SelectCommand="SELECT * FROM [Borrow]"></asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
