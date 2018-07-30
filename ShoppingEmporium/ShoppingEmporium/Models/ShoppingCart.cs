using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ShoppingEmporium.Models
{
    public class ShoppingCart
    {
        public IList<ShoppingCartItem> Items { get; } = new List<ShoppingCartItem>();

        public bool AddToCart(Product p, int quantity)
        {
            // Find the item that represents that product (if it exsts)
            var existingItem = Items.FirstOrDefault(item => item.Product.Id == p.Id);

            // If it doesn't exist, then add the item to the cart for the first time
            if (existingItem == null)
            {
                existingItem = new ShoppingCartItem() { Product = p, Quantity = 0 };
                Items.Add(existingItem);
            }

            // Update the item's quantity
            existingItem.Quantity += quantity;

            return true;
        }

        public decimal GrandTotal
        {
            get
            {
                return Items.Sum(item => item.SubTotal);
            }
        }
    }
}
