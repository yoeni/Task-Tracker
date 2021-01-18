using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Task_Tracer
{
    public partial class addtask : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("default.aspx");
            }
            taskuser.Value = Session["username"].ToString();
            if (Session["openTaskId"]!=null&& !Page.IsPostBack)
            {
                savebutton.Text = "Güncelle";
                savebuttonmobil.Text = "Güncelle";
                Task task = SingletonDB.GetInstance.getTask(Convert.ToInt32(Session["openTaskId"]));
                taskname.Value = task.TaskName;
                projectno.Value = task.Project;
                ckeditor1.Value = task.Description;
                notes.Value = task.Note;
                taskpredate.Value = task.PreDate.ToString("dd/MM/yyyy").Replace('.','/');
                taskenddate.Value = task.RealDate.ToString("dd/MM/yyyy").Replace('.', '/');

            }
           
        }
        protected void addbutton_Click(object sender, EventArgs e)
        {
            if (Session["openTaskId"] != null)
            {
                DateTime predate = Convert.ToDateTime(taskpredate.Value);
                DateTime enddate = Convert.ToDateTime(taskenddate.Value);
                Task before= SingletonDB.GetInstance.getTask(Convert.ToInt32(Session["openTaskId"]));
                Task task = new Task(Convert.ToInt32(Session["openTaskId"]),before.UserId, taskname.Value, ckeditor1.Value, notes.Value, DateTime.Now, predate, enddate, projectno.Value, before.State);
                SingletonDB.GetInstance.updateTask(task);
                Response.Redirect("main.aspx");
            }
            else
            {
                States.State tempstate=States.State.todo;
                if (Session["add"] != null)
                {
                    switch (Session["add"])
                    {
                        case "todo":tempstate = States.State.todo;break;
                        case "inprogress": tempstate = States.State.inprogress; break;
                        case "revision": tempstate = States.State.revision; break;
                        case "check": tempstate = States.State.check; break;
                        case "done": tempstate = States.State.done; break;
                    }
                }
                DateTime predate = Convert.ToDateTime(taskpredate.Value);
                DateTime enddate = Convert.ToDateTime(taskenddate.Value);
                
                Task task = new Task(int.Parse(Session["userId"].ToString()), taskname.Value, ckeditor1.Value, notes.Value, DateTime.Now, enddate, predate, projectno.Value, tempstate);
                SingletonDB.GetInstance.addTask(task);
                Response.Redirect("main.aspx");
            }
        }
    }
}