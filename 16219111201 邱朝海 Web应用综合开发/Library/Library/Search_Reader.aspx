<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Search_Reader.aspx.cs" Inherits="Library.Search_Reader" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>读者信息</title>
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
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString=
        "<%$ ConnectionStrings:LibraryConnectionString %>" SelectCommand="SELECT re.ReaderID, re.Pwd, re.RName, re.Gender, re.Tel, re.dept, re.RegDate, re.ReaderType, ro.MaxBorrowingQuantity, ro.MaxBorrowingTime FROM Reader AS re INNER JOIN RoleType AS ro ON re.ReaderType = ro.ReaderType">
    </asp:SqlDataSource>
    <div id="rep">
        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
        <ItemTemplate>
            <div>
                <hr>
                <table id="tab">
                    <tr>
                        <td><b>读者编号：</b></td>
                        <td><%#Eval("ReaderID") %></td>
                        <td><b>读者姓名：</b></td>
                        <td><%#Eval("RName") %></td>
                    </tr>
                    <tr>
                        <td><b>性别：</b>
                            <asp:RadioButton ID="RadioButton1" text="男" runat="server" checked=<%# Convert.ToBoolean((Eval("Gender").ToString()=="男")?"true":"false") %> />
                            <asp:RadioButton ID="RadioButton2" text="女" runat="server" checked=<%# Convert.ToBoolean((Eval("Gender").ToString()=="女")?"true":"false") %> />
                        </td>
                    </tr>
                    <tr>
                        <td><b>联系方式：</b></td>
                        <td><%#Eval("Tel") %></td>
                        <td><b>所属院校：</b></td>
                        <td><%#Eval("dept") %></td>
                    </tr>
                    <tr>
                        <td><b>注册日期：</b></td>
                        <td><%#Eval("RegDate") %></td>
                    </tr>
<%--                    <tr>
                        <td><b>最大可借阅图书数：</b></td>
                        <td><%#Eval("MaxBorrowingQuantity") %></td>
                        <td><b>最长可借阅期限：</b></td>
                        <td><%#Eval("MaxBorrowingTime") %></td>
                    </tr>--%>
                </table>
            </div>
        </ItemTemplate>
    </asp:Repeater>
    </div>
    </form>
</body>
</html>
