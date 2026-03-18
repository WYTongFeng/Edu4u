using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;
using System.Configuration;

namespace Assignment
{
    public partial class CourseManagement : System.Web.UI.Page
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
                BindGrid();
            }
        }

        private void BindGrid()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT CourseID, Title, Category, Instructor, ContentPath FROM Courses ORDER BY CourseID DESC";
                using (SqlDataAdapter sda = new SqlDataAdapter(query, conn))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    gvCourses.DataSource = dt;
                    gvCourses.DataBind();
                }
            }
        }

        // --- 1. CREATE: Add a new course ---
        protected void btnAddCourse_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string title = txtTitle.Text.Trim();
                string category = txtCategory.Text.Trim();
                string instructor = txtInstructor.Text.Trim();
                string description = txtDescription.Text.Trim();
                string contentPath = null;

                // Handle File Upload if the admin selected a PDF
                if (fileUploadMaterial.HasFile)
                {
                    try
                    {
                        // Ensure the Materials folder exists
                        string folderPath = Server.MapPath("~/Materials/");
                        if (!Directory.Exists(folderPath))
                        {
                            Directory.CreateDirectory(folderPath);
                        }

                        // Generate a unique file name so we don't overwrite existing files
                        string fileName = Guid.NewGuid().ToString() + "_" + Path.GetFileName(fileUploadMaterial.FileName);
                        string savePath = folderPath + fileName;

                        fileUploadMaterial.SaveAs(savePath);

                        // This is the path we save to the database so CourseDetails.aspx can find it
                        contentPath = "~/Materials/" + fileName;
                    }
                    catch (Exception ex)
                    {
                        ShowMessage("File upload failed: " + ex.Message, false);
                        return;
                    }
                }

                // Insert into Database
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    string query = @"INSERT INTO Courses (Title, Description, Category, Instructor, ContentPath) 
                                     VALUES (@Title, @Description, @Category, @Instructor, @ContentPath)";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Title", title);
                        cmd.Parameters.AddWithValue("@Description", description);
                        cmd.Parameters.AddWithValue("@Category", category);
                        cmd.Parameters.AddWithValue("@Instructor", instructor);
                        cmd.Parameters.AddWithValue("@ContentPath", (object)contentPath ?? DBNull.Value);

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();

                            ShowMessage("New course added successfully!", true);

                            // Clear form fields
                            txtTitle.Text = ""; txtCategory.Text = ""; txtInstructor.Text = ""; txtDescription.Text = "";

                            BindGrid();
                        }
                        catch (SqlException ex)
                        {
                            ShowMessage("Database error: " + ex.Message, false);
                        }
                    }
                }
            }
        }

        // --- 2. UPDATE: Edit existing course ---
        protected void gvCourses_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvCourses.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void gvCourses_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCourses.EditIndex = -1;
            BindGrid();
        }

        protected void gvCourses_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int courseId = Convert.ToInt32(gvCourses.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvCourses.Rows[e.RowIndex];

            string title = (row.Cells[1].Controls[0] as TextBox).Text.Trim();
            string category = (row.Cells[2].Controls[0] as TextBox).Text.Trim();
            string instructor = (row.Cells[3].Controls[0] as TextBox).Text.Trim();

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "UPDATE Courses SET Title = @Title, Category = @Category, Instructor = @Instructor WHERE CourseID = @CourseID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Category", category);
                    cmd.Parameters.AddWithValue("@Instructor", instructor);
                    cmd.Parameters.AddWithValue("@CourseID", courseId);

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    gvCourses.EditIndex = -1;
                    BindGrid();
                    ShowMessage("Course updated successfully.", true);
                }
            }
        }

        // --- 3. DELETE: Remove a course ---
        protected void gvCourses_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int courseId = Convert.ToInt32(gvCourses.DataKeys[e.RowIndex].Value);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                // First, delete any student progress linked to this course so we don't get foreign key errors
                string deleteProgressQuery = "DELETE FROM StudentProgress WHERE CourseID = @CourseID";
                // Then, delete the course itself
                string deleteCourseQuery = "DELETE FROM Courses WHERE CourseID = @CourseID";

                conn.Open();

                using (SqlTransaction trans = conn.BeginTransaction()) // Use a transaction to ensure both delete safely
                {
                    try
                    {
                        using (SqlCommand cmd1 = new SqlCommand(deleteProgressQuery, conn, trans))
                        {
                            cmd1.Parameters.AddWithValue("@CourseID", courseId);
                            cmd1.ExecuteNonQuery();
                        }

                        using (SqlCommand cmd2 = new SqlCommand(deleteCourseQuery, conn, trans))
                        {
                            cmd2.Parameters.AddWithValue("@CourseID", courseId);
                            cmd2.ExecuteNonQuery();
                        }

                        trans.Commit(); // Success!
                        BindGrid();
                        ShowMessage("Course and associated student progress deleted successfully.", true);
                    }
                    catch (Exception ex)
                    {
                        trans.Rollback(); // If something fails, undo the deletion
                        ShowMessage("Error deleting course: " + ex.Message, false);
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