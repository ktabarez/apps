using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Web.Website.Controllers
{
    public class SettingsController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Stats()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Settings()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}