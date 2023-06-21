using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TopicPost.Models;
using TopicPost.DataAbstractionLayer;
using System.Web.Mvc;
using System.Xml;
using MySql.Data.Types;
using System.Globalization;

namespace TopicPost.Controllers
{
    public class MainController : Controller
    {
        // GET: Main
       
        public ActionResult Index()
        {
            return View("Authenticate");
        }

        public ActionResult GetPosts()
        {
            DAL dal = new DAL();
            List<Posts> posts = dal.GetAllPosts();
            ViewData["postsList"] = posts;
            return View("View");
        }

        public ActionResult AddPost()
        {
            return View("AddPost");
        }

        public ActionResult SavePost()
        {
            Posts post = new Posts();
            post.id = 0;

            string topicName = Request.Params["topicname"];
            
            post.date = DateTime.Now;
            post.user = GetCurrentUsername();
            post.text = Request.Params["text"];

            DAL dal = new DAL();
            dal.SavePosts(post, topicName);
            return RedirectToAction("GetPosts");
        }

        [HttpPost]
        public ActionResult Authenticate(string username)
        {
            DAL dal = new DAL();
            bool response = dal.Authenticate(username);
            if (response)
            {
                SetCurrentUsername(username);
                return RedirectToAction("GetPosts");
            }
            else
            {
                ViewBag.Message = "Invalid username";
                return View("Authenticate");
            }
        }

        public ActionResult UpdatePost()
        {
            Posts post = new Posts();
            post.id = int.Parse(Request["postid"]);
            post.topicid = int.Parse(Request["topicid"]);
            post.date = DateTime.Now;
            post.user = GetCurrentUsername();
            post.text = Request.Params["text"];

            DAL dal = new DAL();
            dal.UpdatePosts(post);
            return RedirectToAction("GetPosts");
        }

        public ActionResult RedirectToUpdate()
        {
            return View("UpdatePost");
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