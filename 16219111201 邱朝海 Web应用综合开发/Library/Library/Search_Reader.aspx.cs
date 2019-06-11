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
    public partial class Search_Reader : System.Web.UI.Page
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
            if (_tag == "user")
                Button1.Enabled = false;
            Search();
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            string sql = "select * from Reader where ReaderID='" + TextBox1.Text+"'";
            SqlDataReader sr = SqlHelper.getSqlDateReader(sql);
            while (sr.Read())
            {
                SqlDataSource1.SelectCommand = "SELECT * FROM [Reader] WHERE ReaderID='" + TextBox1.Text + "'";
            }
            sr.Close();
        }
        private void Search()
        {
            if (_tag == "user")
            {
                string sql = "select * from Reader where ReaderID=" + _id;
                SqlDataReader sr = SqlHelper.getSqlDateReader(sql);
                while (sr.Read())
                {
                    SqlDataSource1.SelectCommand = "SELECT * FROM [Reader] WHERE ReaderID=" + _id;
                }
                sr.Close();
            }
            else
            {
                string sql = "select * from Reader";
                SqlDataReader sr = SqlHelper.getSqlDateReader(sql);
                while (sr.Read())
                {
                    SqlDataSource1.SelectCommand = "SELECT * FROM [Reader]";
                }
                sr.Close();
            }
        }
        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx?name=" + name + "&id=" + _id + "&tag=" + _tag);
        }
    }
}