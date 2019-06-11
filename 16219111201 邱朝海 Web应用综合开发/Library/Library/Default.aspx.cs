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
    public partial class Default : System.Web.UI.Page
    {
        private string _id;// 账号
        public string Id
        {
            get { return _id; }
            set { _id = value; }
        }

        private string _name;
        public string Name1 // 姓名
        {
            get { return _name; }
            set { _name = value; }
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
            lblUser.Text = name;
        }
        // 首页
        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx?name=" + name + "&id=" + _id + "&tag=" + _tag);
        }
        // 图书信息
        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("Search_Book.aspx?name=" + name + "&id=" + _id + "&tag=" + _tag);
        }
        // 读者信息
        protected void Button3_Click(object sender, EventArgs e)
        {
            Response.Redirect("Search_Reader.aspx?name=" + name + "&id=" + _id + "&tag=" + _tag);
        }
        // 归还
        protected void Button4_Click(object sender, EventArgs e)
        {
            if (_tag == "admin")
                Response.Redirect("Return.aspx?name=" + name + "&id=" + _id + "&tag=" + _tag);
            else
                Response.Write("<script language='javascript'>alert('该功能只供管理员使用！')</script>");
        }
        protected void Button5_Click(object sender, EventArgs e)
        {
            Response.Write("<script language='javascript'>alert('请联系管理员')</script>");
        }
    }
}