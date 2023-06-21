using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Web;
using System.Windows;
using Microsoft.SqlServer.Server;
using MySql.Data.MySqlClient;
using User_Family.Models;

namespace User_Family.DataAbstractionLayer
{
    public class DAL
    {
        /** this was not made until the end so this might not work if you try to use it!!!!!!
         * 
        public List<FamilyRelation> GetAllPeople()
        {
            MySql.Data.MySqlClient.MySqlConnection conn;
            string myConnectionString;

            myConnectionString = "server=localhost;uid=root;pwd=;database=users_family;";
            List<FamilyRelation> posts = new List<FamilyRelation>();

            try
            {
                conn = new MySql.Data.MySqlClient.MySqlConnection();
                conn.ConnectionString = myConnectionString;
                conn.Open();

                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = "select * from familyrelations";
                MySqlDataReader myreader = cmd.ExecuteReader();

                while (myreader.Read())
                {
                    // p - person
                    FamilyRelation p = new FamilyRelation();
                    p.id = myreader.GetInt32("id");
                    p.username = myreader.GetString("username");
                    p.mother = myreader.GetString("mother");
                    p.father = myreader.GetString("father");

                    posts.Add(p);
                }
                myreader.Close();
            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                Console.Write(ex.Message);
            }
            return posts;
        }*/

        public List<FamilyRelation> GetAllParentSide(string username, string parent)
        {
            MySql.Data.MySqlClient.MySqlConnection conn;
            string myConnectionString;

            myConnectionString = "server=localhost;uid=root;pwd=;database=users_family;";
            List<FamilyRelation> people = new List<FamilyRelation>();

            try
            {

                while (!string.IsNullOrEmpty(username))
                {
                    conn = new MySql.Data.MySqlClient.MySqlConnection();
                    conn.ConnectionString = myConnectionString;
                    conn.Open();

                    MySqlCommand cmd = new MySqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandText = "select * from familyrelations where username='" + username + "'";
                    MySqlDataReader myreader = cmd.ExecuteReader();
                    myreader.Read();
                    /// p - person
                    FamilyRelation p = new FamilyRelation();
                    p.id = myreader.GetInt32("id");
                    p.username = myreader.GetString("username");
                    p.mother = myreader.GetString("mother");
                    p.father = myreader.GetString("father");

                    people.Add(p);

                    if (parent == "mother")
                        username = p.mother;
                    else if (parent == "father")
                        username = p.father;
                    else
                    {
                        MessageBox.Show("Invalid parent type. It's mother or father.");
                        username = "";
                    }
                    myreader.Close();
                }

            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                Console.Write(ex.Message);
            }
            return people;
        }

        public bool Authenticate(string username, string parent)
        {
            bool resp = false;
            MySql.Data.MySqlClient.MySqlConnection conn;
            string myConnectionString;

            myConnectionString = "server=localhost;uid=root;pwd=;database=users_family;";

            try
            {
                conn = new MySql.Data.MySqlClient.MySqlConnection();
                conn.ConnectionString = myConnectionString;
                conn.Open();

                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = "select * from familyrelations where username='" + username + "' and (mother='" + parent + "' or father='" + parent + "')";

                MySqlDataReader myreader = cmd.ExecuteReader();
                while (myreader.Read())
                {
                    resp = true;
                }
                myreader.Close();
                Console.Write("Yay, you authenticated");
            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                Console.Write(ex.Message);
            }
            return resp;
        }
    }
}