using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Task_Tracer
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["username"] == null)
            {
                Response.Redirect("default.aspx");
            }
            Session["openTaskId"] = null;
            listElement();
        }
        public void listElement()
        {
            todolistRepeater.DataSource = SingletonDB.GetInstance.getTaskListDataTable(1);
            todolistRepeater.DataBind();
            inprogresslistRepeater.DataSource = SingletonDB.GetInstance.getTaskListDataTable(2);
            inprogresslistRepeater.DataBind();
            revisionlistrepeater.DataSource = SingletonDB.GetInstance.getTaskListDataTable(3);
            revisionlistrepeater.DataBind();
            checklistrepeater.DataSource = SingletonDB.GetInstance.getTaskListDataTable(4);
            checklistrepeater.DataBind();
            donelistrepeater.DataSource = SingletonDB.GetInstance.getTaskListDataTable(5);
            donelistrepeater.DataBind();
        }
        void saveLastChanges()
        {
            foreach (RepeaterItem item in todolistRepeater.Items)
            {
                SingletonDB.GetInstance.updateTaskState(int.Parse(((HiddenField)item.FindControl("taskId")).Value), 1);
            }
            foreach (RepeaterItem item in inprogresslistRepeater.Items)
            {
                SingletonDB.GetInstance.updateTaskState(int.Parse(((HiddenField)item.FindControl("taskId")).Value), 2);
            }
            foreach (RepeaterItem item in revisionlistrepeater.Items)
            {
                SingletonDB.GetInstance.updateTaskState(int.Parse(((HiddenField)item.FindControl("taskId")).Value), 3);
            }
            foreach (RepeaterItem item in checklistrepeater.Items)
            {
                SingletonDB.GetInstance.updateTaskState(int.Parse(((HiddenField)item.FindControl("taskId")).Value), 4);
            }
            foreach (RepeaterItem item in donelistrepeater.Items)
            {
                SingletonDB.GetInstance.updateTaskState(int.Parse(((HiddenField)item.FindControl("taskId")).Value), 5);
            }
            listElement();
        }
        protected void savebutton_Click(object sender, EventArgs e)
        {
            //  string s=Request.Form["todolist"];
            //s += donelistrepeater.Items.Count + " - " + todolistRepeater.Items.Count;
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "text", "get_list_items()", true);
            //Response.Write("<script>alert('"+todo.Value.ToString()+"');</script>");
            //saveLastChanges();
            //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "DoPostBack", "__doPostBack(sender, e)", true);
            //Response.Write("<script>alert('" + donelistrepeater.Items.Count + "');</script>");
        }

        [WebMethod]
        public static void save(int id,int state_id)
        {
            SingletonDB.GetInstance.updateTaskState(id, state_id);
            
        }
        protected void checklistrepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "delete")
            {
                SingletonDB.GetInstance.deleteTask(Convert.ToInt32(e.CommandArgument));
                Response.Redirect("main.aspx");
            }
            if (e.CommandName == "open")
            {
                Session["openTaskId"] = e.CommandArgument.ToString();
                Response.Redirect("addtask.aspx");
            }
        }
        
        protected void todolistRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "delete")
            {
                SingletonDB.GetInstance.deleteTask(Convert.ToInt32(e.CommandArgument));
                Response.Redirect("main.aspx");
            }
            if (e.CommandName == "open")
            {
                Session["openTaskId"] = e.CommandArgument.ToString();
                Response.Redirect("addtask.aspx");
            }
        }

        protected void inprogresslistRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "delete")
            {
                SingletonDB.GetInstance.deleteTask(Convert.ToInt32(e.CommandArgument));
                Response.Redirect("main.aspx");
            }
            if (e.CommandName == "open")
            {
                Session["openTaskId"] = e.CommandArgument.ToString();
                Response.Redirect("addtask.aspx");
            }
        }

        protected void revisionlistrepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "delete")
            {
                SingletonDB.GetInstance.deleteTask(Convert.ToInt32(e.CommandArgument));
                Response.Redirect("main.aspx");
            }
            if (e.CommandName == "open")
            {
                Session["openTaskId"] = e.CommandArgument.ToString();
                Response.Redirect("addtask.aspx");
            }
        }

        protected void donelistrepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "delete")
            {
                SingletonDB.GetInstance.deleteTask(Convert.ToInt32(e.CommandArgument));
                Response.Redirect("main.aspx");
            }
            if (e.CommandName == "open")
            {
                Session["openTaskId"] = e.CommandArgument.ToString();
                Response.Redirect("addtask.aspx");
            }
        }

        protected void todobutton_Click(object sender, EventArgs e)
        {

            Session["openTaskId"] = null;
            Session["add"] = "todo";
            Response.Redirect("addtask.aspx");
        }

        protected void inprogressbutton_Click(object sender, EventArgs e)
        {
            Session["openTaskId"] = null;
            Session["add"] = "inprogress";
            Response.Redirect("addtask.aspx");
        }

        protected void revisionbutton_Click(object sender, EventArgs e)
        {
            Session["openTaskId"] = null;
            Session["add"] = "revision";
            Response.Redirect("addtask.aspx");
        }

        protected void checkbutton_Click(object sender, EventArgs e)
        {
            Session["openTaskId"] = null;
            Session["add"] = "check";
            Response.Redirect("addtask.aspx");
        }

        protected void donebutton_Click(object sender, EventArgs e)
        {
            Session["openTaskId"] = null;
            Session["add"] = "done";
            Response.Redirect("addtask.aspx");
        }
    }
}