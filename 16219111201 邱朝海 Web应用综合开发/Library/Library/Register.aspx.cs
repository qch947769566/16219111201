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
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegist_Click(object sender, EventArgs e)
        {
            string uGender = "";
            int uRt;
            if (txtloginId.Text.Trim().Length < 6)
            {
                Response.Write("<script language='javascript'>alert('账号长度应该大于6')</script>");
            }
            else if (txtLoginPwd.Text.Trim().Length < 6)
            {
                Response.Write("<script language='javascript'>alert('密码长度应该大于6')</script>");
            }
            else if (!txtLoginPwd2.Text.Equals(txtLoginPwd.Text))
            {
                Response.Write("<script language='javascript'>alert('密码输入不一致')</script>");
            }
            else if (txtName.Text.Trim().Length < 2 || txtName.Text.Trim().Length > 15)
            {

                Response.Write("<script language='javascript'>alert('姓名长度应该大于1并且小于等于15')</script>");
            }
            else
            {
                // 判断判断账号是否存在
                if (SqlHelper.IsUserExists(txtloginId.Text.Trim()))
                {
                    Response.Write("<script language='javascript'>alert('账号已存在')</script>");
                    return;
                }

                if (RadioButton3.Checked == true)
                {
                    uGender = "男";
                }
                else
                {
                    uGender = "女";
                }
                // 添加新用户
                string sql = "insert into Reader(ReaderID,Pwd,RName,Gender,Tel,dept,RegDate,ReaderType) values(@id,@pwd,@name,@gender,@phonum,@dept,@regtime,1)";
                MyDictionary dic = new MyDictionary();
                dic.Add("@id", txtloginId.Text.Trim());
                dic.Add("@pwd", txtLoginPwd.Text.Trim());
                dic.Add("@name", txtName.Text.Trim());
                dic.Add("@gender", uGender);
                dic.Add("@phonum", txtTel.Text.Trim());
                dic.Add("@dept", DropDownList1.SelectedItem.Text);
                dic.Add("@regtime", System.DateTime.Now.ToString());
                int i = SqlHelper.ExecuteNonQuery(sql, dic);
                if (i == 1)
                {
                    Response.Write("<script language='javascript'>alert('成功注册新用户')</script>");
                }
                else
                {
                    Response.Write("<script language='javascript'>alert('操作失败,请联系管理员')</script>");
                }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }
    }
}