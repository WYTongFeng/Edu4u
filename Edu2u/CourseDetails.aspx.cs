using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;

namespace Assignment
{
    public partial class CourseDetails : System.Web.UI.Page
    {
        // Safely retrieve the connection string
        private readonly string connString = ConfigurationManager.ConnectionStrings["Edu2UDB"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Security Check: Ensure user is logged in
            if (Session["UserID"] == null)
            {
                Response.Redirect("LoginPage.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
            {
                // Get the CourseID from the URL
                string courseIdStr = Request.QueryString["id"];

                if (string.IsNullOrEmpty(courseIdStr) || !int.TryParse(courseIdStr, out int courseId))
                {
                    // Invalid or missing ID, safely send them back to the list
                    Response.Redirect("CourseList.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                    return;
                }

                LoadCourseData(courseId);
            }
        }

        private void LoadCourseData(int courseId)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT Title, Description, Category, Instructor, ContentPath FROM Courses WHERE CourseID = @CourseID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CourseID", courseId);

                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // HTML Encode all data to prevent XSS attacks
                                lblTitle.Text = Server.HtmlEncode(reader["Title"].ToString());
                                lblDescription.Text = Server.HtmlEncode(reader["Description"].ToString());
                                lblCategory.Text = Server.HtmlEncode(reader["Category"].ToString());
                                lblInstructor.Text = Server.HtmlEncode(reader["Instructor"].ToString());

                                string contentPath = reader["ContentPath"]?.ToString();

                                // Check if the course actually has a PDF attached
                                if (!string.IsNullOrEmpty(contentPath))
                                {
                                    pdfViewer.Src = ResolveUrl(contentPath);
                                }
                                else
                                {
                                    pdfContainer.Visible = false;
                                    btnComplete.Visible = false; // Hide the completion button too
                                    ShowMessage("This course does not have any learning materials uploaded yet.", false);
                                }
                            }
                            else
                            {
                                // Course ID exists in URL, but not in Database
                                Response.Redirect("CourseList.aspx", false);
                                Context.ApplicationInstance.CompleteRequest();
                            }
                        }
                    }
                    catch (SqlException)
                    {
                        pdfContainer.Visible = false;
                        btnComplete.Visible = false;
                        ShowMessage("An unexpected error occurred while loading the course material. Please try again later.", false);
                    }
                }
            }
        }

        protected void btnComplete_Click(object sender, EventArgs e)
        {
            // Defensive check: Ensure session hasn't expired while they were reading the PDF
            if (Session["UserID"] == null)
            {
                Response.Redirect("LoginPage.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);
            string courseIdStr = Request.QueryString["id"];

            if (int.TryParse(courseIdStr, out int courseId))
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    // IF NOT EXISTS ensures we don't crash or create duplicate rows if they click twice
                    string query = @"
                        IF NOT EXISTS (SELECT 1 FROM StudentProgress WHERE UserID = @UserID AND CourseID = @CourseID)
                        BEGIN
                            INSERT INTO StudentProgress (UserID, CourseID) VALUES (@UserID, @CourseID)
                        END";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        cmd.Parameters.AddWithValue("@CourseID", courseId);

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();

                            ShowMessage("Great job! Course marked as completed. Your progress has been saved.", true);
                            pdfContainer.Visible = false; // Hide PDF
                            btnComplete.Visible = false;  // Hide the button so they don't click it again
                        }
                        catch (SqlException)
                        {
                            // SECURITY FIX: Do not leak raw database exceptions to the user
                            ShowMessage("An error occurred while saving your progress. Please try again later.", false);
                        }
                    }
                }
            }
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Visible = true;
            lblMessage.Text = message;
            lblMessage.CssClass = isSuccess ? "alert alert-success d-block" : "alert alert-danger d-block";
        }
    }
}