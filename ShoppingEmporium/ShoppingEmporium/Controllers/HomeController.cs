using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using ShoppingEmporium.Extensions;
using ShoppingEmporium.Models;

namespace ShoppingEmporium.Controllers
{
    public class HomeController : Controller
    {
        //

        private IProductDAL dal;
        private string Session_Key = "User_Cart";

        public HomeController(IProductDAL dal)
        {
            this.dal = dal;
        }

        public IActionResult Index()
        {
            var products = dal.GetAllProducts();

           var categories = dal.GetAllCategories();
            ViewBag.categories = categories;//.Select(cat => new SelectListItem { Text = cat, Value = cat });
            return View(products);
        }

        public IActionResult ViewByCategory(string cat)
        {
            var products = dal.GetProductsByCategory(cat);
            ViewBag.category = cat;
            return View(products);
        }

        public IActionResult Detail(int id)
        {
            var p = dal.IsTopSeller(dal.GetProduct(id));

            return View(p);
        }


        private ShoppingCart GetActiveShoppingCart()
        {
            ShoppingCart cart = HttpContext.Session.Get<ShoppingCart>(Session_Key);

            // See if the user has a cart in session
            if (cart == null)
            {
                cart = new ShoppingCart();
                HttpContext.Session.Set(Session_Key, cart);
            }

            return cart;
        }

        public IActionResult AddToCart(int id)
        {
            var pToAdd = dal.GetProduct(id);
            var cart = GetActiveShoppingCart();
            cart.AddToCart(pToAdd, 1);
            HttpContext.Session.Set(Session_Key, cart);

            return RedirectToAction("Index");
        }


        public IActionResult About()
        {
            ViewData["Message"] = "Your application description page.";

            return View();
        }

        public IActionResult Contact()
        {
            ViewData["Message"] = "Your contact page.";

            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
