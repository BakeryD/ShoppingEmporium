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
            string query = "Select * From Product";
            var products = new List<Product>();
            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(query, conn);
                    var reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        products.Add(MapRowToProduct(reader));
                    }
                }
            }
            catch (SqlException ex)
            {

                throw ex;
            }
            return products;
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
            return new Product()
            {
                Id = Convert.ToInt32(reader["id"]),
                Name = Convert.ToString(reader["name"]),
                Description = Convert.ToString(reader["description"]),
                Cost = Convert.ToInt32(reader["price"]),
                ImageName = Convert.ToString(reader["image_name"])

            };
        }

        public Product IsTopSeller(Product p)
        {
            string sql=
            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {

                }
            }
            catch (SqlException ex)
            {

                throw ex;
            }
        }
      
    }
}
