using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Library.Util;
using System.Configuration;
using System.Data.SqlClient;

namespace Library
{
    public partial class LogIn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // 获取账号
            string Id = txtloginId.Text.Trim();
            // 获取密码
            string Pwd = txtLoginPwd.Text.Trim();
            string tag = null;
            if (Id == "" || Pwd == "")
            {
                Response.Write("<script language='javascript'>alert('请输入账号或密码')</script>");
            }
            else
            {
                string str = ConfigurationManager.ConnectionStrings["Library"].ConnectionString;
                // 构造sql查询语句
                string sql;
                if (RadioButton1.Checked == true)
                {
                    sql = "select RName from Reader where ReaderID='" + Id + "' and Pwd='" + Pwd + "'";
                    tag = "user";
                }
                else
                {
                    sql = "select ManagerID from Manager where ManagerID='" + Id + "' and Pwd='" + Pwd + "'";
                    tag = "admin";
                }
                // 构造连接对象
                using (SqlConnection conn = new SqlConnection(str))
                {
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    // 打开数据库连接
                    try
                    {
                        conn.Open();
                    }
                    catch (Exception)
                    {
                        Response.Write("<script language='javascript'>alert('数据库连接失败')</script>");
                        return;
                    }
                    // 执行查询语句,返回结果集第一行第一列
                    string name = null;
                    string name1 = null;
                    try
                    {
                        name = cmd.ExecuteScalar().ToString();
                    }
                    catch (Exception)
                    {
                        name = "";
                    }

                    if (name != "")
                    {
                        name1 = name;
                        Response.Redirect("Default.aspx?name=" + name1 + "&id=" + Id + "&tag=" + tag);
                    }
                    else
                    {
                        Response.Write("<script language='javascript'>alert('账号或密码错误')</script>");
                    }
                }
            }
        }
    }
}