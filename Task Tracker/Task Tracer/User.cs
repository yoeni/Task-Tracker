using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Task_Tracer
{
    public class User
    {
        public int UserId { get; private set; }
        public string UserName { get;private  set; }
        public string Password { get;private set; }
        public string Name { get; private set; }
    }
}