using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace mvcMobileStore.Controllers
{
    public class MobileStoreController : Controller
    {
        // GET: MobileStore
        public ActionResult Index()
        {
            return View();
        }
    }
}