using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace ShoppingEmporium.Models
{
    public class ProductSqlDAL : IProductDAL
    {
        private string ConnectionString;
        public ProductSqlDAL(string connectionString)
        {
            this.ConnectionString = connectionString;
        }
        public IList<Product> GetAllProducts()
        {
            throw new NotImplementedException();
        }

        public IList<Product> GetProducctsByCategory(string cat)
        {
            throw new NotImplementedException();
        }

        public Product GetProduct(int id)
        {
            throw new NotImplementedException();
        }

        public Product MapRowToProduct(SqlDataReader reader)
        {
            throw new NotImplementedException();
        }
    }
}
