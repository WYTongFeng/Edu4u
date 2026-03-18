using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class CourseManagement : System.Web.UI.Page
    {
        private readonly string connString = ConfigurationManager.ConnectionStrings["Edu2UDB"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // SECURITY FIX: Allow BOTH Educators and Administrators, block Students and Guests.
            string role = Session["Role"] != null ? Session["Role"].ToString() : "";

            if (Session["UserID"] == null || (role != "Educator" && role != "Administrator"))
            {
                Response.Redirect("LoginPage.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
            {
                LoadCourses();
            }
        }

        private void LoadCourses()
        {
            // We no longer need to check the role or the instructor's name here
            // because Page_Load already ensures only Admins and Educators can access this page.

            using (SqlConnection conn = new SqlConnection(connString))
            {
                // This query now fetches ALL courses for EVERYONE
                string query = "SELECT CourseID, Title, Category, Instructor FROM Courses ORDER BY CourseID DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            gvCourses.DataSource = reader;
                            gvCourses.DataBind();
                        }
                    }
                    catch (SqlException ex)
                    {
                        ShowMessage("Error loading courses: " + ex.Message, false);
                    }
                }
            }
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            if (fileUpload.HasFile)
            {
                try
                {
                    string folderPath = Server.MapPath("~/Materials/");
                    if (!Directory.Exists(folderPath))
                    {
                        Directory.CreateDirectory(folderPath);
                    }

                    string fileName = Path.GetFileName(fileUpload.FileName);
                    string savePath = Path.Combine(folderPath, fileName);
                    fileUpload.SaveAs(savePath);

                    InsertCourseToDatabase(txtTitle.Text.Trim(), txtDescription.Text.Trim(), ddlCategory.SelectedValue, fileName, txtInstructor.Text.Trim());
                }
                catch (Exception ex)
                {
                    ShowMessage("An error occurred while uploading the file: " + ex.Message, false);
                }
            }
            else
            {
                ShowMessage("Please select a PDF file to upload.", false);
            }
        }

        private void InsertCourseToDatabase(string title, string description, string category, string fileName, string instructorName)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"INSERT INTO Courses (Title, Description, Category, Instructor, ContentPath) 
                                 VALUES (@Title, @Description, @Category, @Instructor, @ContentPath)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Description", description);
                    cmd.Parameters.AddWithValue("@Category", category);
                    cmd.Parameters.AddWithValue("@Instructor", instructorName);
                    cmd.Parameters.AddWithValue("@ContentPath", "~/Materials/" + fileName);

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        ShowMessage("Course uploaded successfully!", true);

                        txtTitle.Text = "";
                        txtInstructor.Text = "";
                        txtDescription.Text = "";
                        ddlCategory.SelectedIndex = 0;

                        LoadCourses();
                    }
                    catch (SqlException ex)
                    {
                        ShowMessage("A database error occurred: " + ex.Message, false);
                    }
                }
            }
        }

        protected void gvCourses_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int courseId = Convert.ToInt32(gvCourses.DataKeys[e.RowIndex].Value);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "DELETE FROM Courses WHERE CourseID = @CourseID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CourseID", courseId);

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        ShowMessage("Course deleted successfully.", true);
                        LoadCourses();
                    }
                    catch (SqlException ex)
                    {
                        if (ex.Number == 547)
                        {
                            ShowMessage("Cannot delete this course because students have already interacted with it.", false);
                        }
                        else
                        {
                            ShowMessage("Error deleting course.", false);
                        }
                    }
                }
            }
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Visible = true;
            lblMessage.Text = message;
            lblMessage.CssClass = isSuccess ? "alert alert-success d-block rounded-3 shadow-sm" : "alert alert-danger d-block rounded-3 shadow-sm";
        }
    }
}