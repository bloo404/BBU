using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

using A10.Models;
using Microsoft.SqlServer.Server;
using MySql.Data.MySqlClient;

namespace A10.DataAbstractionLayer
{
    public class DAL
    {

        public List<Document> GetAllDocuments()
        {
            MySql.Data.MySqlClient.MySqlConnection conn;
            string myConnectionString;

            myConnectionString = "server=localhost;uid=root;pwd=;database=documents;";
            List<Document> dlist = new List<Document>();

            try
            {
                conn = new MySql.Data.MySqlClient.MySqlConnection();
                conn.ConnectionString = myConnectionString;
                conn.Open();

                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = "select * from documents";
                MySqlDataReader myreader = cmd.ExecuteReader();

                while (myreader.Read())
                {
                    Document doc = new Document();
                    doc.id = myreader.GetInt32("id");
                    doc.author = myreader.GetString("author");
                    doc.title = myreader.GetString("title");
                    doc.number_of_pages = myreader.GetInt32("number_of_pages");
                    doc.type = myreader.GetString("type");
                    doc.format = myreader.GetString("format");
                    dlist.Add(doc);
                }
                myreader.Close();
            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                Console.Write(ex.Message);
            }
            return dlist;

        }

        public void SaveDocument(Document doc)
        {
            MySql.Data.MySqlClient.MySqlConnection conn;
            string myConnectionString;

            myConnectionString = "server=localhost;uid=root;pwd=;database=documents;";

            try
            {
                conn = new MySql.Data.MySqlClient.MySqlConnection();
                conn.ConnectionString = myConnectionString;
                conn.Open();

                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = "INSERT INTO documents(author, title, number_of_pages, type, format) VALUES ('" + doc.author + "','" + doc.title + "','" + doc.number_of_pages + "','" + doc.type + "','" + doc.format + "')";
                cmd.ExecuteNonQuery();

            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                Console.Write(ex.Message);
            }

        }

        public List<Document> GetFilteredDocuments(string type, string format)
        {
            MySql.Data.MySqlClient.MySqlConnection conn;
            string myConnectionString;

            myConnectionString = "server=localhost;uid=root;pwd=;database=documents;";
            List<Document> dlist = new List<Document>();

            try
            {
                conn = new MySql.Data.MySqlClient.MySqlConnection();
                conn.ConnectionString = myConnectionString;
                conn.Open();

                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = "select * from documents where type='" + type + "' AND format='" + format + "'";
                MySqlDataReader myreader = cmd.ExecuteReader();

                while (myreader.Read())
                {
                    Document doc = new Document();
                    doc.id = myreader.GetInt32("id");
                    doc.author = myreader.GetString("author");
                    doc.title = myreader.GetString("title");
                    doc.number_of_pages = myreader.GetInt32("number_of_pages");
                    doc.type = myreader.GetString("type");
                    doc.format = myreader.GetString("format");
                    dlist.Add(doc);
                }
                myreader.Close();
            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                Console.Write(ex.Message);
            }
            return dlist;
        }

        public bool Authenticate(string username, string password)
        {
            bool resp = false;

            MySql.Data.MySqlClient.MySqlConnection conn;
            string myConnectionString;

            myConnectionString = "server=localhost;uid=root;pwd=;database=wp;";

            try
            {
                conn = new MySql.Data.MySqlClient.MySqlConnection();
                conn.ConnectionString = myConnectionString;
                conn.Open();

                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = "select * from users where user='" + username + "' AND password='" + password + "'";
                MySqlDataReader myreader = cmd.ExecuteReader();

                while (myreader.Read())
                {
                    resp = true;
                }
                myreader.Close();
            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                Console.Write(ex.Message);
            }

            return resp;
        }

        public void DeleteDocument(int id)
        {
            MySql.Data.MySqlClient.MySqlConnection conn;
            string myConnectionString;

            myConnectionString = "server=localhost;uid=root;pwd=;database=documents;";

            try
            {
                conn = new MySql.Data.MySqlClient.MySqlConnection();
                conn.ConnectionString = myConnectionString;
                conn.Open();

                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = "DELETE FROM documents WHERE id=" + id;
                cmd.ExecuteNonQuery();

            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                Console.Write(ex.Message);
            }

        }
    }
}