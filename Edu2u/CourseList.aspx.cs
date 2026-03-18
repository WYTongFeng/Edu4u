using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Assignment
{
    public partial class CourseList : System.Web.UI.Page
    {
        // Safely retrieve the connection string without falling back to a hardcoded local path
        private readonly string connString = ConfigurationManager.ConnectionStrings["Edu2UDB"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Load all courses when the page first loads
                LoadCourses(string.Empty);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            // Load courses filtered by the search text
            LoadCourses(txtSearch.Text);
        }

        private void LoadCourses(string searchTerm)
        {
            // Normalize the search term (removes accidental leading/trailing spaces)
            searchTerm = searchTerm?.Trim();

            using (SqlConnection conn = new SqlConnection(connString))
            {
                // PERFORMANCE FIX: Instead of appending strings in C#, we write one clean SQL query.
                // The (@SearchTerm = '') condition acts as a bypass switch if the user didn't type anything.
                string query = @"
                    SELECT CourseID, Title, Description, Category, Instructor 
                    FROM Courses 
                    WHERE (@SearchTerm = '' OR Title LIKE @SearchTerm OR Category LIKE @SearchTerm)
                    ORDER BY CreatedAt DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    // If the search term is empty or just white spaces, pass an empty string
                    if (string.IsNullOrWhiteSpace(searchTerm))
                    {
                        cmd.Parameters.AddWithValue("@SearchTerm", "");
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@SearchTerm", "%" + searchTerm + "%");
                    }

                    try
                    {
                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            sda.Fill(dt);

                            if (dt.Rows.Count > 0)
                            {
                                rptCourses.DataSource = dt;
                                rptCourses.DataBind();

                                rptCourses.Visible = true;
                                lblNoCourses.Visible = false;
                            }
                            else
                            {
                                rptCourses.Visible = false;
                                lblNoCourses.Text = "<h4>No courses found. Try adjusting your search!</h4>";
                                lblNoCourses.Visible = true;
                            }
                        }
                    }
                    catch (SqlException ex)
                    {
                        // STABILITY FIX: If the database is down, don't crash the whole page.
                        // Hide the repeater and show a friendly error message.
                        rptCourses.Visible = false;
                        lblNoCourses.Text = "<h4 class='text-danger'>We're having trouble loading courses right now. Please try again later.</h4>";
                        lblNoCourses.Visible = true;

                        // Note: In a production app, you would log 'ex.Message' to a file here.
                    }
                }
            }
        }
    }
}