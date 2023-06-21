using MySql.Data.Types;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TopicPost.Models
{
    public class Posts
    {
        public int id { get; set; }
        public string user { get; set; }
        public int topicid { get; set; }
        public string text { get; set; }
        public DateTime date { get; set; }

    }
}