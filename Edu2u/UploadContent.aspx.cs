using System;
using System.Data.SqlClient;
using System.IO;
using System.Configuration;

namespace Assignment
{
    public partial class UploadContent : System.Web.UI.Page
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
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // Grab the instructor's name directly from the session (secure, they can't spoof it)
                string instructorName = Session["FullName"].ToString();

                string title = txtTitle.Text.Trim();
                string category = ddlCategory.SelectedValue;
                string description = txtDescription.Text.Trim();
                string contentPath = null;

                // 1. Handle the physical file upload
                if (fileUploadMaterial.HasFile)
                {
                    // Basic validation to ensure it's actually a PDF
                    string fileExtension = Path.GetExtension(fileUploadMaterial.FileName).ToLower();
                    if (fileExtension != ".pdf")
                    {
                        ShowMessage("Error: Please upload a valid PDF file.", false);
                        return;
                    }

                    try
                    {
                        string folderPath = Server.MapPath("~/Materials/");
                        if (!Directory.Exists(folderPath))
                        {
                            Directory.CreateDirectory(folderPath);
                        }

                        // Generate a unique identifier to prevent overwriting files with the same name
                        string fileName = Guid.NewGuid().ToString() + "_" + Path.GetFileName(fileUploadMaterial.FileName);
                        string savePath = folderPath + fileName;

                        fileUploadMaterial.SaveAs(savePath);
                        contentPath = "~/Materials/" + fileName;
                    }
                    catch (Exception ex)
                    {
                        ShowMessage("File upload failed: " + ex.Message, false);
                        return;
                    }
                }

                // 2. Save the course to the database
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
                        cmd.Parameters.AddWithValue("@ContentPath", contentPath);

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();

                            ShowMessage("Success! Your course and material have been published.", true);

                            // Reset the form so they can upload another if they want
                            txtTitle.Text = "";
                            ddlCategory.SelectedIndex = 0;
                            txtDescription.Text = "";
                        }
                        catch (SqlException ex)
                        {
                            ShowMessage("Database error: " + ex.Message, false);
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

            // If success, scroll the user to the top to see the message
            if (isSuccess)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Scroll", "window.scrollTo(0, 0);", true);
            }
        }
    }
}