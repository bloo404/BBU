using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace User_Family.Models
{
    public class FamilyRelation
    {
        public int id { get; set; }
        public string username { get; set; }
        public string mother { get; set; }
        public string father { get; set; }
    }
}