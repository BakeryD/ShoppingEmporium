using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ShoppingEmporium.Models
{
    public class Product
    {
        /*id, name, description, category_id, Is_BestSeller, cost, image_name */
        public string Name { get; set; }
        public int CategoryID { get; set; }
        public string Description { get; set; }
        public decimal Cost { get; set; }
        public string ImageName { get; set; }
        public bool IsBestSeller { get; set; }
        public int Id { get; set; }
    }
}
