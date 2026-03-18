using System;
using System.Data.SqlClient;
using System.Configuration;

namespace Assignment
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["Edu2UDB"]?.ConnectionString
            ?? @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Edu2U.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Strict Security Check: Only Administrators allowed!
            if (Session["UserID"] == null || Session["Role"]?.ToString() != "Administrator")
            {
                // Boot them back to the home page or login page
                Response.Redirect("LoginPage.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // Set the admin's name
                if (Session["FullName"] != null)
                {
                    lblAdminName.Text = Session["FullName"].ToString();
                }

                // Load system statistics
                LoadStatistics();
            }
        }

        private void LoadStatistics()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    conn.Open();

                    // 1. Count Students
                    string studentQuery = "SELECT COUNT(1) FROM Users WHERE Role = 'Student'";
                    using (SqlCommand cmd = new SqlCommand(studentQuery, conn))
                    {
                        lblTotalStudents.Text = cmd.ExecuteScalar().ToString();
                    }

                    // 2. Count Educators
                    string educatorQuery = "SELECT COUNT(1) FROM Users WHERE Role = 'Educator'";
                    using (SqlCommand cmd = new SqlCommand(educatorQuery, conn))
                    {
                        lblTotalEducators.Text = cmd.ExecuteScalar().ToString();
                    }

                    // 3. Count Courses
                    string courseQuery = "SELECT COUNT(1) FROM Courses";
                    using (SqlCommand cmd = new SqlCommand(courseQuery, conn))
                    {
                        lblTotalCourses.Text = cmd.ExecuteScalar().ToString();
                    }
                }
                catch (SqlException ex)
                {
                    // In a real production app, you'd log this error. 
                    // For now, we just safely show '0' or an error indicator if the DB fails.
                    lblTotalStudents.Text = "!";
                    lblTotalEducators.Text = "!";
                    lblTotalCourses.Text = "!";
                }
            }
        }
    }
}