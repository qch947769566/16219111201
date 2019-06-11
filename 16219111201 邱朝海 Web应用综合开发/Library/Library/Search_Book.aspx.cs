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
    public partial class Search_Book : System.Web.UI.Page
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

        private bool is_admin;
        protected void Page_Load(object sender, EventArgs e)
        {
            name = Request.QueryString["name"];
            _id = Request.QueryString["id"];
            _tag = Request.QueryString["tag"];
            if (_tag == "admin")
                is_admin = true;
            else
                is_admin = false;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Search();
        }
        private void Search()
        {
            string sql = "select * from Book where BName like '%" + TextBox1.Text + "%'";

            SqlDataReader sr = SqlHelper.getSqlDateReader(sql);
            if (!sr.HasRows)
            {
                Response.Write("<script language='javascript'>alert('没有找到这本书，换本书找吧！')</script>");
                return;
            }
            while (sr.Read())
            {
                SqlDataSource1.SelectCommand = "SELECT * FROM [Book] WHERE BName LIKE '%" + TextBox1.Text + "%'";
            }
            sr.Close();
        }
        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx?name=" + name + "&id=" + _id + "&tag=" + _tag);
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            object[] argrument = e.CommandArgument.ToString().Split(',');
            string Status = argrument[1].ToString();
            if (!MaxBook())
            {
                Response.Write("<script language='javascript'>alert('您的借阅数量已超出最大可借数量！')</script>");
                return;
            }
            if (is_admin)
            {
                Response.Write("<script language='javascript'>alert('此用户为管理员，无法进行图书借阅！')</script>");
            }
            else if (!isOverTime()&&isBorrow(Status))
            {
                DateTime now = DateTime.Now;
                DateTime exp = now.AddDays(30);
                string bookid = argrument[0].ToString();
                string sql = "insert into Borrow values('" + _id + "','" + bookid + "','"
                    + now.ToString() + "','" + exp.ToString() + "','" + 0 + "')";
                if (SqlHelper.getRs(sql) == 1)
                {
                    Response.Write("<script language='javascript'>alert('借阅成功！')</script>");
                    ChangeBookState(bookid);
                    sql = "select * from Book";
                    SqlDataReader sr = SqlHelper.getSqlDateReader(sql);
                    while (sr.Read())
                    {
                        SqlDataSource1.SelectCommand = "SELECT * FROM [Book] ";
                    }
                    sr.Close();
                }
                else
                {
                    Response.Write("<script language='javascript'>alert('借阅失败！')</script>");
                }
            }
            else if (!isBorrow(Status))
            {
                Response.Write("<script language='javascript'>alert('该书已借出，暂时无法借阅！')</script>");
            }
        }
        private bool MaxBook()
        {
            string sql = "select Count(*) from Borrow where ReaderID='" + _id + "'";
            int cou = Convert.ToInt32(SqlHelper.ExecuteScalar(sql));
            sql = "select t.MaxBorrowingQuantity from Reader r,RoleType t where r.ReaderType=t.ReaderType";
            int max = Convert.ToInt32(SqlHelper.ExecuteScalar(sql));
            if (cou > max)
            {
                return false;
            }
            else
                return true;
        }
        private bool isOverTime()
        {
            string sql = "select Expect_Return_Time from Borrow where ReaderID='" + _id + "'";
            SqlDataReader sr = SqlHelper.getSqlDateReader(sql);
            while (sr.Read())
            {
                //预期归还时间早于系统时间返回true
                if (Convert.ToDateTime(sr[0]) < DateTime.Now)
                {
                    return true;
                }
            }
            sr.Close();
            return false;
        }

        private bool isBorrow(string status)
        {
            if (status == "借出")
                return false;
            else
                return true;
        }

        private void ChangeBookState(string bookid)
        {
            string sql = "update Book set Status = '借出' where BookID='" + bookid + "'";
            SqlHelper.getRs(sql);
        }
    }
}
