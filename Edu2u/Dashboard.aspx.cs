using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Assignment
{
    public partial class Dashboard : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["Edu2UDB"]?.ConnectionString
            ?? @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Edu2U.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Security Check: Only Educators allowed!
            if (Session["UserID"] == null || Session["Role"]?.ToString() != "Educator")
            {
                Response.Redirect("LoginPage.aspx");
                return;
            }

            if (!IsPostBack)
            {
                string educatorName = Session["FullName"].ToString();
                lblEducatorName.Text = educatorName.Split(' ')[0]; // Friendly first-name greeting

                LoadEducatorStats(educatorName);
                LoadMyCourses(educatorName);
            }
        }

        private void LoadEducatorStats(string educatorName)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    conn.Open();

                    // 1. Count how many courses this specific educator has created
                    string courseQuery = "SELECT COUNT(1) FROM Courses WHERE Instructor = @InstructorName";
                    using (SqlCommand cmd = new SqlCommand(courseQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@InstructorName", educatorName);
                        lblMyCoursesCount.Text = cmd.ExecuteScalar().ToString();
                    }

                    // 2. Count how many times students have completed THIS educator's courses
                    string completionsQuery = @"
                        SELECT COUNT(p.ProgressID) 
                        FROM StudentProgress p
                        INNER JOIN Courses c ON p.CourseID = c.CourseID
                        WHERE c.Instructor = @InstructorName";

                    using (SqlCommand cmd = new SqlCommand(completionsQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@InstructorName", educatorName);
                        lblStudentCompletions.Text = cmd.ExecuteScalar().ToString();
                    }
                }
                catch (SqlException ex)
                {
                    ShowMessage("Error loading statistics: " + ex.Message);
                }
            }
        }

        private void LoadMyCourses(string educatorName)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                // Only pull courses where this educator is the instructor
                string query = "SELECT Title, Category, ContentPath, CreatedAt FROM Courses WHERE Instructor = @InstructorName ORDER BY CreatedAt DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@InstructorName", educatorName);

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        try
                        {
                            sda.Fill(dt);

                            if (dt.Rows.Count > 0)
                            {
                                gvMyCourses.DataSource = dt;
                                gvMyCourses.DataBind();
                                gvMyCourses.Visible = true;
                                lblNoCourses.Visible = false;
                            }
                            else
                            {
                                gvMyCourses.Visible = false;
                                lblNoCourses.Visible = true;
                            }
                        }
                        catch (SqlException ex)
                        {
                            ShowMessage("Error loading courses: " + ex.Message);
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