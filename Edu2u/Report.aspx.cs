using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Assignment
{
    public partial class Report : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["Edu2UDB"]?.ConnectionString
            ?? @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Edu2U.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Security Check: Admins only!
            if (Session["UserID"] == null || Session["Role"]?.ToString() != "Administrator")
            {
                Response.Redirect("LoginPage.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadCoursePopularityReport();
                LoadRecentUsersReport();
            }
        }

        private void LoadCoursePopularityReport()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                // This query joins the Courses and StudentProgress tables. 
                // It counts how many progress records exist for each course.
                string query = @"
                    SELECT 
                        c.Title, 
                        c.Category, 
                        c.Instructor, 
                        COUNT(p.ProgressID) AS TotalCompletions
                    FROM Courses c
                    LEFT JOIN StudentProgress p ON c.CourseID = p.CourseID
                    GROUP BY c.CourseID, c.Title, c.Category, c.Instructor
                    ORDER BY TotalCompletions DESC, c.Title ASC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        try
                        {
                            sda.Fill(dt);
                            gvCourseReport.DataSource = dt;
                            gvCourseReport.DataBind();
                        }
                        catch (SqlException ex)
                        {
                            ShowMessage("Error loading course report: " + ex.Message);
                        }
                    }
                }
            }
        }

        private void LoadRecentUsersReport()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                // Get the 10 most recently registered users
                string query = "SELECT TOP 10 Username, FullName, Role, CreatedAt FROM Users ORDER BY CreatedAt DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        try
                        {
                            sda.Fill(dt);
                            gvRecentUsers.DataSource = dt;
                            gvRecentUsers.DataBind();
                        }
                        catch (SqlException ex)
                        {
                            ShowMessage("Error loading user report: " + ex.Message);
                        }
                    }
                }
            }
        }

        private void ShowMessage(string message)
        {
            lblMessage.Visible = true;
            lblMessage.Text = message;
            lblMessage.CssClass = "alert alert-danger d-block";
        }
    }
}