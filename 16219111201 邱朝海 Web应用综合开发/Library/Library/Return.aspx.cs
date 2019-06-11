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
    public partial class Return : System.Web.UI.Page
    {
        private string _id;// 账号
        public string Id
        {
            get { return _id; }
            set { _id = value; }
        }
        // 权限标记 值为admin为管理员 ，值为user则为普通用户
        private string _tag;
        public string _Tag
        {
            get { return _tag; }
            set { _tag = value; }
        }
        private string name;
        protected void Page_Load(object sender, EventArgs e)
        {
            name = Request.QueryString["name"];
            _id = Request.QueryString["id"];
            _tag = Request.QueryString["tag"];
            SqlDataSource1.SelectCommand = "SELECT * FROM [Borrow]";
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Search();
        }
        private void Search()
        {
            string sql = "select * from Borrow where BookID = '" + TextBox1.Text.Trim() + "'"; 
            SqlDataReader sr = SqlHelper.getSqlDateReader(sql);
            while (sr.Read())
            {
                SqlDataSource1.SelectCommand = "SELECT * FROM [Borrow] WHERE BookID = '" + TextBox1.Text.Trim() + "'";
            }
            sr.Close();
        }
        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx?name=" + name + "&id=" + _id + "&tag=" + _tag);
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            object[] arguments = e.CommandArgument.ToString().Split(',');
            string BookId = arguments[0].ToString();
            DateTime time1 = Convert.ToDateTime(arguments[1]);
            DateTime time2 = DateTime.Now;
            // 删除借书记录
            string sql = "delete from Borrow where BookID='" + BookId + "'";
            if (SqlHelper.getRs(sql) == 1)
            {
                if(DateTime.Compare(time1,time2)<0)                
                    Response.Write("<script language='javascript'>alert('归还成功,但借阅期限已超时！')</script>");
                else
                    Response.Write("<script language='javascript'>alert('归还成功！')</script>");
                sql = "update Book set Status = '可借' where BookID='" + BookId + "'";
                SqlHelper.getRs(sql);
                sql = "select * from Borrow";
                SqlDataReader sr = SqlHelper.getSqlDateReader(sql);
                while (sr.Read())
                {
                    SqlDataSource1.SelectCommand = "SELECT * FROM [Borrow] ";
                }
                sr.Close();
            }
            else
            {
                Response.Write("<script language='javascript'>alert('归还失败！')</script>");
            }
        }
    }
}