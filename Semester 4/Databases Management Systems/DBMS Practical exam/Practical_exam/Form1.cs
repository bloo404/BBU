using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Practical_exam
{
    public partial class Form1 : Form
    {
        SqlConnection conn;

        SqlDataAdapter daParent, daChild;

        DataSet dset;
        BindingSource bs;

        BindingSource bsParent, bsChild;

        string queryParent, queryChild;

        public string getConnectionString()
        {
            return "Data Source=DESKTOP-B13DM0R;Initial Catalog=students;" +
                "Integrated Security=true;";
        }

        SqlCommandBuilder cmdBuilder;

        public Form1()
        {
            InitializeComponent();
            FillData();
        }

        void FillData()
        {
            conn = new SqlConnection(getConnectionString());

            queryParent = "SELECT * FROM " + "Company";
            queryChild = "SELECT * FROM " + "Internship";

            daParent = new SqlDataAdapter(queryParent, conn);
            daChild = new SqlDataAdapter(queryChild, conn);

            dset = new DataSet();
            daParent.Fill(dset, "Company"); 
            daChild.Fill(dset, "Internship"); 

            cmdBuilder = new SqlCommandBuilder(daChild);

            dset.Relations.Add("CompanyInternship",
                dset.Tables["Company"].Columns["CompanyID"],
                dset.Tables["Internship"].Columns["CompanyID"]);

            bsParent = new BindingSource();
            bsParent.DataSource = dset.Tables["Company"];
            bsChild = new BindingSource(bsParent, "Company" + "Internship");

            this.dgvCompanies.DataSource = bsParent;
            this.dgvInternships.DataSource = bsChild;

            cmdBuilder.GetUpdateCommand();
        }
        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                daChild.Update(dset, "Internship");
            }
            catch (Exception)
            {
                MessageBox.Show("Error: Something is not valid.", "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

    }
}
