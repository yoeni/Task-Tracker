using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Task_Tracer
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void loginButton_Click(object sender, EventArgs e)
        {
            
            string username = String.Format("{0}", Request.Form["username"]);
            string password = String.Format("{0}", Request.Form["password"]);
            if (username !=""  && password !="")
            {
                int id = SingletonDB.GetInstance.loginCheck(username, password);
                if (id!=0)
                {
                    Session["username"] = username;
                    Session["userId"] = id.ToString();
                    Response.Redirect("main.aspx");
                }
                else
                {
                    Response.Write("<script>alert('login unsuccessfull');</script>");
                }
            }
        }
    }
}