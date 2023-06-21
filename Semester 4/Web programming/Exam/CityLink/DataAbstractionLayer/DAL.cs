using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services.Description;

using CityLink.Models;
using Microsoft.SqlServer.Server;
using System.Windows.Forms;

namespace CityLink.DataAbstractionLayer
{
    public class DAL
    {
        public List<City> GetAllCities()
        {
            MySql.Data.MySqlClient.MySqlConnection conn;
            string myConnectionString;

            myConnectionString = "server=localhost;uid=root;pwd=;database=citylink;";
            List<City> cities = new List<City>();

            try
            {
                conn = new MySql.Data.MySqlClient.MySqlConnection();
                conn.ConnectionString = myConnectionString;
                conn.Open();

                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = "select * from city";
                MySqlDataReader myreader = cmd.ExecuteReader();

                while (myreader.Read())
                {
                    City c = new City();
                    c.id = myreader.GetInt32("ID");
                    c.name = myreader.GetString("Name");
                    c.county = myreader.GetString("County");
                    // MessageBox.Show(c.name);
                    cities.Add(c);
                }
                myreader.Close();
            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                Console.Write(ex.Message);
            }
            return cities;
        }

        public List<Link> GetLinkedCities(int id)
        {
            MySql.Data.MySqlClient.MySqlConnection conn;
            string myConnectionString;

            myConnectionString = "server=localhost;uid=root;pwd=;database=citylink;";
            List<Link> cities = new List<Link>();

            try
            {
                conn = new MySql.Data.MySqlClient.MySqlConnection();
                conn.ConnectionString = myConnectionString;
                conn.Open();

                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = "select * from link inner join city on (city.id = link.IDCity1 or link.IDCity2= city.id) where city.id=" + id;
                MySqlDataReader myreader = cmd.ExecuteReader();

                while (myreader.Read())
                {
                    Link c = new Link();
                    c.id = myreader.GetInt32("IDLink");
                    c.idcity1 = myreader.GetInt32("IDCity1");
                    c.idcity2 = myreader.GetInt32("IDCity2");
                    c.duration = myreader.GetInt32("Duration");
                    c.distance = myreader.GetInt32("Distance");
                    int city_id = myreader.GetInt32("ID");
                    c.name1 = myreader.GetString("Name");
                    c.name2 = this.GetName(c.idcity2);
                   

                    // MessageBox.Show(c.name);
                    cities.Add(c);
                }
                myreader.Close();
            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                Console.Write(ex.Message);
            }
            return OrderByMetric(cities);
        }
        public string GetName(int id)
        {
            MySql.Data.MySqlClient.MySqlConnection conn;
            string myConnectionString;

            myConnectionString = "server=localhost;uid=root;pwd=;database=citylink;";
            string name = "";

            try
            {
                conn = new MySql.Data.MySqlClient.MySqlConnection();
                conn.ConnectionString = myConnectionString;
                conn.Open();

                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = "select city.Name from city where city.id=" + id;
                MySqlDataReader myreader = cmd.ExecuteReader();

                while (myreader.Read())
                {
                   name = myreader.GetString("Name");
                }
                myreader.Close();
            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                Console.Write(ex.Message);
            }
            return name;
        }

        public List<Link> OrderByMetric(List<Link> cities)
        {
            for(int i=0; i < cities.Count; i++)
            {
                for(int j=i+1;j< cities.Count; j++)
                {
                    if (cities[i].duration*0.6 + 0.4 * cities[i].distance < cities[j].duration * 0.6 + 0.4 * cities[j].distance)
                    {
                        Link c = cities[i];
                        cities[i] = cities[j];
                        cities[j] = c;
                    }
                }
            }
            return cities;
        }


    }
}