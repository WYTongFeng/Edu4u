using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Assignment
{
    public partial class Report : System.Web.UI.Page
    {
        private readonly string connString = ConfigurationManager.ConnectionStrings["Edu2UDB"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null || Session["Role"]?.ToString() != "Administrator")
            {
                Response.Redirect("LoginPage.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
            {
                LoadCoursePopularityReport();
                LoadQuizResultsReport();
                LoadRecentUsersReport();
            }
        }

        private void LoadCoursePopularityReport()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"
                    SELECT 
                        c.Title, 
                        c.Category, 
                        c.Instructor, 
                        COUNT(p.ProgressID) AS TotalCompletions
                    FROM Courses c
                    LEFT JOIN StudentProgress p ON c.CourseID = p.CourseID
                    GROUP BY c.Title, c.Category, c.Instructor
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
                            if (ex.Number == 208) // "Invalid object name" if table doesn't exist
                            {
                                LoadCourseFallback(conn);
                            }
                            else
                            {
                                ShowMessage("Error loading course report: " + ex.Message, false);
                            }
                        }
                    }
                }
            }
        }

        private void LoadCourseFallback(SqlConnection conn)
        {
            string query = "SELECT Title, Category, Instructor, 0 AS TotalCompletions FROM Courses ORDER BY Title ASC";
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    gvCourseReport.DataSource = dt;
                    gvCourseReport.DataBind();
                }
            }
        }

        // --- NEW: Quiz Results Report ---
        private void LoadQuizResultsReport()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                // Notice the JOIN is now on the Courses table using CourseID
                string query = @"
            SELECT TOP 15
                u.FullName AS StudentName,
                c.Title AS QuizTitle,
                CONCAT(r.Score, '/', r.TotalQuestions) AS Score,
                r.AttemptDate
            FROM QuizResults r
            INNER JOIN Users u ON r.UserID = u.UserID
            INNER JOIN Courses c ON r.CourseID = c.CourseID
            ORDER BY r.AttemptDate DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        try
                        {
                            sda.Fill(dt);
                            gvQuizResults.DataSource = dt;
                            gvQuizResults.DataBind();
                        }
                        catch (SqlException ex)
                        {
                            if (ex.Number == 208) // Fallback if table is somehow missing
                            {
                                LoadQuizFallback();
                            }
                            else
                            {
                                ShowMessage("Error loading quiz report: " + ex.Message, false);
                            }
                        }
                    }
                }
            }
        }

        private void LoadQuizFallback()
        {
            // Just bind an empty table so the GridView safely displays the "No results found" EmptyDataTemplate
            gvQuizResults.DataSource = new DataTable();
            gvQuizResults.DataBind();
        }

        private void LoadRecentUsersReport()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
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
                            ShowMessage("Error loading user report: " + ex.Message, false);
                        }
                    }
                }
            }
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Visible = true;
            lblMessage.Text = message;

            lblMessage.CssClass = isSuccess
                ? "alert alert-success border-0 bg-success bg-opacity-10 text-success d-block p-3 d-print-none"
                : "alert alert-danger border-0 bg-danger bg-opacity-10 text-danger d-block p-3 d-print-none";
        }
    }
}