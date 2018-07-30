using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace ShoppingEmporium.Models
{
    public interface IProductDAL
    {
        IList<Product> GetAllProducts();
        Product GetProduct(int id);
        Product MapRowToProduct(SqlDataReader reader);
        IList<Product> GetProductsByCategory(string cat);
        Product IsTopSeller(Product p);
        IList<string> GetAllCategories();
    }
}
