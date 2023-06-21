using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CityLink.Models
{
    public class Link
    {
        public int id {  get; set; }
        public int idcity1 { get; set; }
        public int idcity2 { get; set;}
        public int duration {get; set;}
        public int distance { get; set; }

        public string name1 { get; set; }  
        public string name2 { get; set; }
    }
}