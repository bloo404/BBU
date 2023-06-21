using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using TopicPost.Models;
using Microsoft.SqlServer.Server;
using MySql.Data.MySqlClient;
using System.Globalization;
using System.Web.Services.Description;

namespace TopicPost.DataAbstractionLayer
{
    public class DAL
    {
        public List<Posts> GetAllPosts()
        {
            MySql.Data.MySqlClient.MySqlConnection conn;
            string myConnectionString;

            myConnectionString = "server=localhost;uid=root;pwd=;database=topics_posts;";
            List<Posts> posts = new List<Posts>();

            try {
                conn = new MySql.Data.MySqlClient.MySqlConnection();
                conn.ConnectionString = myConnectionString;
                conn.Open();

                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = "select * from posts";
                MySqlDataReader myreader = cmd.ExecuteReader();

                while (myreader.Read())
                {
                   Posts p = new Posts();
                    p.id = myreader.GetInt32("id");
                    p.user = myreader.GetString("user");
                    p.topicid = myreader.GetInt32("topicid");
                    p.text = myreader.GetString("text");
                    DateTime date = myreader.GetDateTime(myreader.GetOrdinal("date"));
                    p.date = date;
               
                    posts.Add(p);
                }
                myreader.Close();
            } 
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                Console.Write(ex.Message);
            }
            return posts;
        }

        public void SavePosts(Posts post, string topic_name)
        {
            MySql.Data.MySqlClient.MySqlConnection conn;
            string myConnectionString;

            myConnectionString = "server=localhost;uid=root;pwd=;database=topics_posts;";
            try
            {
                conn = new MySql.Data.MySqlClient.MySqlConnection();
                conn.ConnectionString = myConnectionString;
                conn.Open();

                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = conn;

                cmd.CommandText = "SELECT id FROM topics WHERE topicname='" + topic_name + "'";
                MySqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    int val = reader.GetInt32("id");
                    post.topicid = val;
                    reader.Close();

                    DateTime currentTime = DateTime.Now;
                    string formattedDate = currentTime.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
                    cmd.CommandText = "INSERT INTO posts(user, topicid, text, date) VALUES('" + post.user + "'," + post.topicid + ",'" + post.text + "','" + formattedDate + "')";
                    cmd.ExecuteNonQuery();
                }
                else
                {
                    reader.Close();

                    string topicName = topic_name;

                    cmd.CommandText = "INSERT INTO topics(topicname) VALUES(" + "'" + topicName + "')";
                    cmd.ExecuteNonQuery();

                    cmd.CommandText = "SELECT id FROM topics WHERE topicname='" + topic_name + "'";
                    MySqlDataReader newReader = cmd.ExecuteReader();

                    newReader.Read();

                    int val = newReader.GetInt32("id");
                    post.topicid = val;
                    newReader.Close();

                    DateTime currentTime = DateTime.Now;
                    string formattedDate = currentTime.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
                    cmd.CommandText = "INSERT INTO posts(user, topicid, text, date) VALUES('" + post.user + "'," + post.topicid + ",'" + post.text + "','" + formattedDate + "')";
                    cmd.ExecuteNonQuery();
                }
            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                Console.Write(ex.Message);
            }
        }
/*
        private string GenerateRandomTopicName()
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            Random random = new Random();
            string topicName = new string(Enumerable.Repeat(chars, 8).Select(s => s[random.Next(s.Length)]).ToArray());
            return topicName;
        }
*/


        public void UpdatePosts(Posts post)
        {
            MySql.Data.MySqlClient.MySqlConnection conn;
            string myConnectionString;

            myConnectionString = "server=localhost;uid=root;pwd=;database=topics_posts;";
            try
            {
                conn = new MySql.Data.MySqlClient.MySqlConnection();
                conn.ConnectionString = myConnectionString;
                conn.Open();

                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = conn;
                DateTime currentTime = DateTime.Now;
                string formattedDate = currentTime.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
                cmd.CommandText = "update posts set user='" + post.user + "',topicid=" + post.topicid + ",text='" + post.text + "',date='" + formattedDate + "' where id=" + post.id + "";
                cmd.ExecuteNonQuery();
            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                Console.Write(ex.Message);
            }
        }

        public bool Authenticate(string username)
        {
            bool resp = false;
            MySql.Data.MySqlClient.MySqlConnection conn;
            string myConnectionString;

            myConnectionString = "server=localhost;uid=root;pwd=;database=topics_posts;";

            try
            {
                conn = new MySql.Data.MySqlClient.MySqlConnection();
                conn.ConnectionString = myConnectionString;
                conn.Open();

                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = "select * from posts where user='" + username + "'";
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
    }
}