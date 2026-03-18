using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Assignment
{
    public partial class Progress : System.Web.UI.Page
    {
        // Safely retrieve the connection string
        private readonly string connString = ConfigurationManager.ConnectionStrings["Edu2UDB"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Security Check: Only logged-in users can view progress
            if (Session["UserID"] == null)
            {
                // Safely redirect to login page
                Response.Redirect("LoginPage.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
            {
                LoadStudentProgress();
            }
        }

        private void LoadStudentProgress()
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                // Join the StudentProgress table with the Courses table to get readable details
                string query = @"
                    SELECT c.Title, c.Category, c.Instructor, p.CompletedAt 
                    FROM StudentProgress p
                    INNER JOIN Courses c ON p.CourseID = c.CourseID
                    WHERE p.UserID = @UserID
                    ORDER BY p.CompletedAt DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);

                    try
                    {
                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            sda.Fill(dt);

                            // Update the big number card
                            lblTotalCompleted.Text = dt.Rows.Count.ToString();

                            if (dt.Rows.Count > 0)
                            {
                                rptProgress.DataSource = dt;
                                rptProgress.DataBind();

                                rptProgress.Visible = true;
                                pnlNoProgress.Visible = false; // Updated to match the Panel ID
                            }
                            else
                            {
                                rptProgress.Visible = false;
                                pnlNoProgress.Visible = true; // Updated to match the Panel ID
                            }
                        }
                    }
                    catch (SqlException)
                    {
                        // STABILITY FIX: Prevent app crash if database goes offline
                        rptProgress.Visible = false;

                        // Fallback UI adjustments
                        lblTotalCompleted.Text = "Error";
                        // Note: In a full app, you might want a specific error panel, but for now, 
                        // forcing the empty state panel to show is a safe fallback.
                        pnlNoProgress.Visible = true;
                    }
                }
            }
        }
    }
}