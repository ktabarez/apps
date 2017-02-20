using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Web.Website.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            ViewBag.PageTitle = "Home page.";

            return View();
        }

        public ActionResult Memberfeedbacks()
        {
            ViewBag.PageTitle = "Feedbacks page.";

            return View();
        }
    }
}