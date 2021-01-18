using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;

namespace Task_Tracer
{
    public sealed class SingletonDB
    {
        private static SingletonDB instance = null;
		
        public static SingletonDB GetInstance
        {
            get
            {
                if (instance == null)
                    instance = new SingletonDB();
                return instance;
            }
        }

        private SingletonDB()
        {
        }
		public MySqlConnection getConnection()
		{
			MySqlConnection connection = null;
			try
			{
				connection = new MySqlConnection("server=localhost;user=root;pwd=;database=tasktracker;charset=utf8");
			}
			catch (Exception e)
			{
				Console.WriteLine(e.Message);
			}
			return connection;
		}
		public int getId(string sql)
		{
			int id = 0;
			MySqlConnection connection = null;
			MySqlCommand command = null;
			try
			{
				connection = getConnection();
				connection.Open();
				command = new MySqlCommand(sql, connection);
				id = Convert.ToInt32(command.ExecuteScalar());
				command.ExecuteNonQuery();
			}
			catch (Exception e)
			{
				Console.WriteLine(e.Message);
			}
			finally
			{
				if (connection != null)
				{
					try
					{//bağlantıları kapat
						connection.Close();
						command.Dispose();
					}
					catch (Exception e)
					{
						Console.WriteLine(e.Message);
					}
				}
			}
			return id;
		}
		public int loginCheck(string userName,string password)
        {
			bool state = false;
			MySqlConnection connection = null;
			MySqlCommand command = null;
			try
			{
				connection = getConnection();
				connection.Open();
				command = new MySqlCommand("select username, password from users", connection);
				command.Connection = connection;
				MySqlDataReader read = command.ExecuteReader();
				while (read.Read())
				{
					if (read[0].ToString() == userName && read[1].ToString() == password)
					{
						state = true;
						break;

					}
				}
			}
            catch (Exception e)
            {
				Console.WriteLine("hata: "+e.Message);
			}
			finally
			{
				if (connection != null)
				{
					try
					{//bağlantıları kapat
						connection.Close();
						command.Dispose();
					}
					catch (Exception e)
					{
						Console.WriteLine(e.Message);
					}
				}
			}
			if (state==false)
            {
				return 0;
            }
            else
            {

				return getId("select userId from users where username='"+userName+"'");
			}
		}
		public DataTable getTaskListDataTable(int state)
        {
			DataTable dt=new DataTable();
			DataSet ds = new DataSet();	
			MySqlConnection connection=null;
			MySqlDataAdapter command=null;
            try
			{
				connection = getConnection();
				connection.Open();
				command = new MySqlDataAdapter("select taskId,taskName,taskDate, (case length(note)>50 when true then concat(left(note,50),' ...') else note end) as 'description',u.name,stateId from tasks inner join users u on tasks.userId=u.userId where stateId=" + state, connection);
				command.Fill(dt);
			}
			catch (Exception e)
			{
				Console.WriteLine(e.Message);
			}
            finally
            {
                if (connection != null)
                {
                    try
                    {//bağlantıları kapat
                        connection.Close();
                        command.Dispose();
                    }
                    catch (Exception e)
                    {
                        Console.WriteLine(e.Message);
                    }
                }
            }
            return dt;
        }
		public void updateTask(Task task)
		{
			MySqlConnection connection = null;
			MySqlCommand command = null;
			try
			{
				int state_id=1;
                switch (task.State)
                {
                    case States.State.todo:state_id = 1;
                        break;
                    case States.State.inprogress:state_id = 2;
                        break;
                    case States.State.revision:state_id = 3;
                        break;
                    case States.State.check:state_id = 4;
                        break;
                    case States.State.done:state_id = 5;
                        break;
                    default:
                        break;
                }
                connection = getConnection();
				connection.Open();
				command = new MySqlCommand("update tasks set stateId=" +state_id + ",taskName='"+task.TaskName+"', description='"+task.Description+"', note='"+task.Note+"', preDate='"+ task.PreDate.ToString("yyyy-MM-dd") + "', realDate='"+ task.RealDate.ToString("yyyy-MM-dd") + "',userID='"+task.UserId+"',projectId='"+task.Project+"' where taskId=" + task.TaskId, connection);
				command.Connection = connection;
				command.ExecuteNonQuery();
			}
			catch (Exception e)
			{
				Console.WriteLine(e.Message);
			}
			finally
			{
				if (connection != null)
				{
					try
					{//bağlantıları kapat
						connection.Close();
						command.Dispose();
					}
					catch (Exception e)
					{
						Console.WriteLine(e.Message);
					}
				}
			}
		}
		public void updateTaskState(int id,int state)
		{
			MySqlConnection connection = null;
			MySqlCommand command = null;
			try
			{
				connection = getConnection();
				connection.Open();
				command = new MySqlCommand("update tasks set stateId="+state+" where taskId="+id, connection);
				command.Connection = connection;
				command.ExecuteNonQuery();
			}
			catch (Exception e)
			{
				Console.WriteLine(e.Message);
			}
			finally
			{
				if (connection != null)
				{
					try
					{//bağlantıları kapat
						connection.Close();
						command.Dispose();
					}
					catch (Exception e)
					{
						Console.WriteLine(e.Message);
					}
				}
			}

		}
		public List<Task> getTaskList()
		{
			List<Task> listTask = new List<Task>();
			MySqlConnection connection = null;
			MySqlCommand command = null;
			String query = "Select * FROM tasks";
			try
			{
				connection = getConnection();
				connection.Open();
				command = new MySqlCommand(query,connection);
				command.Connection = connection;
				MySqlDataReader read = command.ExecuteReader();
				while (read.Read())
				{//gelen her veriyi
					States.State taskState;
                    switch (read[9].ToString())
                    {
						case "1": taskState = States.State.todo;break;
						case "2": taskState = States.State.inprogress; break;
						case "3": taskState = States.State.revision; break;
						case "4": taskState = States.State.check; break;
						case "5": taskState = States.State.done; break;
						default: taskState = States.State.todo; break;
					}
                    Task task = new Task(int.Parse(read[0].ToString()), int.Parse(read[8].ToString()),
						read[1].ToString(),
						read[2].ToString(),
						read[3].ToString(),
						Convert.ToDateTime(read[4].ToString()),
						Convert.ToDateTime(read[5].ToString()),
						Convert.ToDateTime(read[6].ToString()),
						read[7].ToString(),
						taskState
						);
					listTask.Add(task);
				}

			}
			catch (Exception e)
			{
				Console.WriteLine(e.Message);
			}
			finally
			{
				if (connection != null)
				{
					try
					{//bağlantıları kapat
						connection.Close();
						command.Dispose();
					}
					catch (Exception e)
					{
						Console.WriteLine(e.Message);
					}
				}
			}

			return listTask;
		}
		public Task getTask(int id)
		{
			Task task = null;
			MySqlConnection connection = null;
			MySqlCommand command = null;
			String query = "Select * FROM tasks where taskId="+id;
			try
			{
				connection = getConnection();
				connection.Open();
				command = new MySqlCommand(query, connection);
				command.Connection = connection;
				MySqlDataReader read = command.ExecuteReader();
				while (read.Read())
				{//gelen her veriyi
					States.State taskState;
					switch (read[9].ToString())
					{
						case "1": taskState = States.State.todo; break;
						case "2": taskState = States.State.inprogress; break;
						case "3": taskState = States.State.revision; break;
						case "4": taskState = States.State.check; break;
						case "5": taskState = States.State.done; break;
						default: taskState = States.State.todo; break;
					}
					 task = new Task(int.Parse(read[0].ToString()), int.Parse(read[8].ToString()),
						read[1].ToString(),
						read[2].ToString(),
						read[3].ToString(),
						Convert.ToDateTime(read[4].ToString()),
						Convert.ToDateTime(read[5].ToString()),
						Convert.ToDateTime(read[6].ToString()),
						read[7].ToString(),
						taskState
						);
				}

			}
			catch (Exception e)
			{
				Console.WriteLine(e.Message);
			}
			finally
			{
				if (connection != null)
				{
					try
					{//bağlantıları kapat
						connection.Close();
						command.Dispose();
					}
					catch (Exception e)
					{
						Console.WriteLine(e.Message);
					}
				}
			}

			return task;
		}
		public void addTask(Task task){

			MySqlConnection connection = null;
			MySqlCommand command = null;
			try
			{
				connection = getConnection();
				connection.Open();
				command = new MySqlCommand("insert into tasks (taskName,description,note,taskDate,preDate,realDate,projectId,stateId,userId) values ('"+task.TaskName+ "','"+task.Description+ "','"+task.Note+ "','"+task.TaskDate.ToString("yyyy-MM-dd") + "','"+task.PreDate.ToString("yyyy-MM-dd")+ "','"+task.RealDate.ToString("yyyy-MM-dd") + "','"+task.Project+ "','"+task.getState()+"','"+task.UserId+"')", connection);
				command.Connection = connection;
				command.ExecuteNonQuery();
			}
			catch (Exception e)
			{
				Console.WriteLine(e.Message);
			}
			finally
			{
				if (connection != null)
				{
					try
					{//bağlantıları kapat
						connection.Close();
						command.Dispose();
					}
					catch (Exception e)
					{
						Console.WriteLine(e.Message);
					}
				}
			}
		}
		public void deleteTask(int id)
		{

			MySqlConnection connection = null;
			MySqlCommand command = null;
			try
			{
				connection = getConnection();
				connection.Open();
				command = new MySqlCommand("delete from tasks where taskId="+id, connection);
				command.Connection = connection;
				command.ExecuteNonQuery();
			}
			catch (Exception e)
			{
				Console.WriteLine(e.Message);
			}
			finally
			{
				if (connection != null)
				{
					try
					{//bağlantıları kapat
						connection.Close();
						command.Dispose();
					}
					catch (Exception e)
					{
						Console.WriteLine(e.Message);
					}
				}
			}
		}
	}
}
