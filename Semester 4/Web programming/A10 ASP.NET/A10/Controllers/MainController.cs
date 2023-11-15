using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using A10.Models;
using A10.DataAbstractionLayer;

namespace A10.Controllers
{
    public class MainController : Controller
    {
        // GET: Main
        public ActionResult Index()
        {
            return View("Authenticate");
        }

        public string Test()
        {
            return "It's working";
        }

        public ActionResult GetDocuments()
        {
            DAL dal = new DAL();
            List<Document> dlist = dal.GetAllDocuments();
            ViewData["documentList"] = dlist;
            return View("ViewGetDocuments");
        }

        public ActionResult AddDocument()
        {
            return View("AddDocument");
        }

        public ActionResult SaveDocument()
        {
            Document doc = new Document();
            doc.id = 0;
            doc.author = Request.Params["author"];
            doc.title = Request.Params["title"];
            doc.number_of_pages = int.Parse(Request["number_of_pages"]);
            doc.type = Request.Params["type"];
            doc.format = Request.Params["format"];

            DAL dal = new DAL();
            dal.SaveDocument(doc);
            return RedirectToAction("GetDocuments");
        }

        [HttpGet]
        public ActionResult FilterDocuments()
        {
            return View("FilterDocuments");
        }

        [HttpGet]
        public ActionResult GetFilteredDocuments(string type, string format)
        {
            DAL dal = new DAL();
            List<Document> dlist = dal.GetFilteredDocuments(type, format);
            ViewData["documentList"] = dlist;
            return View("FilterDocuments");
        }

        [HttpPost]
        public ActionResult Authenticate(string username, string password)
        {
            DAL dal = new DAL();
            bool response = dal.Authenticate(username, password);

            if (response)
            {
                return RedirectToAction("GetDocuments");
            }
            else
            {
                ViewBag.Message = "Invalid username or password";
                return View("Authenticate");
            }
        }

        public ActionResult DeleteDocument(int id)
        {
            DAL dal = new DAL();
            dal.DeleteDocument(id);

            return RedirectToAction("GetDocuments");
        }

    }
}