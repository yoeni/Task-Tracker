using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Task_Tracer
{
    public class Task
    {
        public int TaskId { get;  set; }
        public int UserId { get; set; }
        public string TaskName { get; set; }
        public string Description { get; set; }
        public string Note { get; set; }
        public string Project { get; set; }
        public DateTime TaskDate { get; }
        public DateTime PreDate { get; set; }
        public DateTime RealDate { get; set; }
        public States.State State { get; set; }
        public Task(int taskId,int userId, string taskName,string description,string note,DateTime taskDate,DateTime preDate,DateTime realDate,string project,States.State state)
        {
            this.TaskId = taskId;
            this.TaskName = taskName;
            this.Description = description;
            this.Note = note;
            this.TaskDate= taskDate;
            this.PreDate = preDate;
            this.RealDate = realDate;
            this.Project = project;
            this.State = state;
            this.UserId = userId;
        }
        public Task( int userId, string taskName, string description, string note, DateTime taskDate, DateTime preDate, DateTime realDate, string project, States.State state)
        {
            this.TaskId = 0;
            this.TaskName = taskName;
            this.Description = description;
            this.Note = note;
            this.TaskDate = taskDate;
            this.PreDate = preDate;
            this.RealDate = realDate;
            this.Project = project;
            this.State = state;
            this.UserId = userId;
        }
        public int getState()
        {
            switch (State)
            {
                case States.State.todo:return 1;
                    break;
                case States.State.inprogress:return 2;
                    break;
                case States.State.revision:return 3;
                    break;
                case States.State.check:return 4;
                    break;
                case States.State.done:return 5;
                    break;
                default:return 1;
                    break;
            }
        }
    }
}