using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Services.Description;
using System.Windows;
using User_Family.DataAbstractionLayer;
using User_Family.Models;

namespace User_Family.Controllers
{
    public class MainController : Controller
    {
        public ActionResult Index()
        {
            return View("Authenticate");
        }

        [HttpPost]
        public ActionResult Authenticate(string username, string parent)
        {
            DAL dal = new DAL();
            bool response = dal.Authenticate(username, parent);
            if (response)
            {
                SetCurrentUsername(username);
                return View("View");
            }
            else
            {
                MessageBox.Show("Invalid username or parent name!");
                // ViewBag.Message = "Invalid username";
                return View("Authenticate");
            }
        }


        [HttpGet]
        public ActionResult GetParentLine(string parent)
        {
            DAL dal = new DAL();
            List<FamilyRelation> people = dal.GetAllParentSide(GetCurrentUsername(), parent);
            ViewData["peopleList"] = people;
            //MessageBox.Show(parent);
            return View("View");
        }

        private string GetCurrentUsername()
        {
            if (Session["currentUsername"] != null)
            {
                return Session["currentUsername"].ToString();
            }
            else
            {
                return null;
            }
        }
        private void SetCurrentUsername(string username)
        {
            Session["currentUsername"] = username;
        }
    }
}