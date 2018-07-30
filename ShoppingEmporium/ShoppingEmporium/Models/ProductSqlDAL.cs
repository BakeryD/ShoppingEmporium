using System;
using System.Collections.Generic;
using System.Data;
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
                        products.Add(IsTopSeller(MapRowToProduct(reader)));
                    }
                }
            }
            catch (SqlException ex)
            {

                throw ex;
            }
            return products;
        }

        public IList<string> GetAllCategories()
        {
            var categories = new List<string>();
            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();
                    string sql = $"Select * From Category;";
                    var cmd = new SqlCommand(sql, conn);
                    var reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        categories.Add(Convert.ToString(reader["name"]));
                    }
                }

            }
            catch (SqlException)
            {

                throw;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }

            return categories;
        }

        public IList<Product> GetProductsByCategory(string cat)
        {
            List<Product> productsInCat = new List<Product>();
            string sql = $"Select * from Product " +
                $"Inner Join Category on Product.category_id = Category.id " +
                $"Where Category.name= @cat ;";
            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@cat", cat);
                    var reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        productsInCat.Add(IsTopSeller(MapRowToProduct(reader)));
                    }
                }
            }
            catch (SqlException)
            {

                throw;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }

            return productsInCat;
        }

        public Product GetProduct(int id)
        {
            return GetAllProducts().FirstOrDefault(p => p.Id == id);

        }

        public Product MapRowToProduct(SqlDataReader reader)
        {
            return new Product()
            {
                Id = Convert.ToInt32(reader["id"]),
                Name = Convert.ToString(reader["name"]),
                Description = Convert.ToString(reader["description"]),
                Cost = Convert.ToInt32(reader["cost"]),
                ImageName = Convert.ToString(reader["image_name"])
            };
        }

        public Product IsTopSeller(Product p)
        {

            string sqlPrintMessage = "";

            //event handler for sql PRINT message
            void myConnection_InfoMessage(object sender, SqlInfoMessageEventArgs e)
            {
                sqlPrintMessage = e.Message;
            }

            string sql = $"Declare @totalSales INT; " +
            $"Set @totalSales = ( select Count(sale.id) " +
            $"from Sale " +
            $"Inner Join Product on Product.id = Sale.product_id " +
            $"where product_id = {p.Id} );" +
            $"Declare @bool bit;" +
            $"set @bool = Case when( @totalSales > 100) then 1 else 0 end;" +
            $"Print @bool;";

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.InfoMessage += myConnection_InfoMessage;
                    conn.Open();
                    var cmd = new SqlCommand(sql, conn);
                    using (SqlDataAdapter adapt = new SqlDataAdapter(cmd))
                    {
                        using (DataSet set = new DataSet())
                        {
                            adapt.Fill(set);
                        }
                    }

                    //cmd.Parameters.AddWithValue("@product", p.Id);
                    cmd.ExecuteReader();
                    if (sqlPrintMessage != "")
                    {
                        p.IsBestSeller = Convert.ToBoolean(int.Parse(sqlPrintMessage));
                    }
                }
            }
            catch (SqlException ex)
            {

                throw ex;
            }
            return p;
        }

    }
}
