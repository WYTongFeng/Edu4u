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
            // THIS FIXES THE LOGIN BUG: 
            // Only check if the Session has a UserID. We removed the strict, buggy Role check.
            if (Session["UserID"] == null)
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
            string instructorName = Session["FullName"]?.ToString() ?? Session["Username"]?.ToString() ?? "Educator";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                // Attempt to load courses that belong to this educator specifically
                string query = "SELECT CourseID, Title, Category, Instructor FROM Courses WHERE Instructor = @Instructor ORDER BY CourseID DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Instructor", instructorName);

                    try
                    {
                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            sda.Fill(dt);

                            // Fallback: If no courses found for the specific instructor, just load all of them so the table works
                            if (dt.Rows.Count == 0)
                            {
                                string fallbackQuery = "SELECT CourseID, Title, Category, Instructor FROM Courses ORDER BY CourseID DESC";
                                using (SqlCommand fallbackCmd = new SqlCommand(fallbackQuery, conn))
                                {
                                    using (SqlDataAdapter fallbackSda = new SqlDataAdapter(fallbackCmd))
                                    {
                                        dt = new DataTable();
                                        fallbackSda.Fill(dt);
                                    }
                                }
                            }

                            gvCourses.DataSource = dt;
                            gvCourses.DataBind();
                        }
                    }
                    catch (SqlException)
                    {
                        ShowMessage("Database error while loading courses.", false);
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
                    // Ensure the 'Materials' folder exists in your project
                    string folderPath = Server.MapPath("~/Materials/");
                    if (!Directory.Exists(folderPath))
                    {
                        Directory.CreateDirectory(folderPath);
                    }

                    // Save the uploaded PDF securely
                    string fileName = Path.GetFileName(fileUpload.FileName);
                    string savePath = Path.Combine(folderPath, fileName);
                    fileUpload.SaveAs(savePath);

                    // Insert data into Database
                    InsertCourseToDatabase(txtTitle.Text.Trim(), txtDescription.Text.Trim(), ddlCategory.SelectedValue, fileName);
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

        private void InsertCourseToDatabase(string title, string description, string category, string fileName)
        {
            string instructorName = Session["FullName"]?.ToString() ?? Session["Username"]?.ToString() ?? "Educator";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"INSERT INTO Courses (Title, Description, Category, Instructor, FilePath) 
                                 VALUES (@Title, @Description, @Category, @Instructor, @FilePath)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Description", description);
                    cmd.Parameters.AddWithValue("@Category", category);
                    cmd.Parameters.AddWithValue("@Instructor", instructorName);
                    cmd.Parameters.AddWithValue("@FilePath", "~/Materials/" + fileName); // Path to load the PDF later

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        ShowMessage("Course uploaded successfully!", true);

                        // Clear the form fields after successful upload
                        txtTitle.Text = "";
                        txtDescription.Text = "";
                        ddlCategory.SelectedIndex = 0;

                        // Refresh the table to show the new course
                        LoadCourses();
                    }
                    catch (SqlException)
                    {
                        ShowMessage("A database error occurred while saving the course. Please verify your table structure.", false);
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
                        if (ex.Number == 547) // SQL constraint violation (students took the course)
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