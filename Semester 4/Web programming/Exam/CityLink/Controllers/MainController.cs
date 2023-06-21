using CityLink.DataAbstractionLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Services.Description;


using CityLink.Models;
using Microsoft.SqlServer.Server;
using System.Windows.Forms;

namespace CityLink.Controllers
{
    public class MainController : Controller
    {
        // GET: Main
        public ActionResult Index()
        {
            return RedirectToAction("GetCities");
        }

        public ActionResult GetCities()
        {
            DAL dal = new DAL();
            List<City> cities = dal.GetAllCities();
            ViewData["cityList"] = cities;
            return View("View");
        }

        public ActionResult LinkToCity(int id)
        {
            DAL dal = new DAL();
            // MessageBox.Show(id.ToString());
            List<Link> cities = dal.GetLinkedCities(id);
            ViewData["cityList"] = cities;
            return View("LinkedCities");
            
        }

    }
}