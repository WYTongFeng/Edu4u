using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Assignment
{
    public partial class QuizList : System.Web.UI.Page
    {
        private readonly string connString = ConfigurationManager.ConnectionStrings["Edu2UDB"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("LoginPage.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
            {
                LoadQuizzes();
            }
        }

        private void LoadQuizzes()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                // INNER JOIN ensures we ONLY show courses that have at least one question in the QuizQuestions table
                string query = @"
                    SELECT DISTINCT c.CourseID, c.Title, c.Category 
                    FROM Courses c
                    INNER JOIN QuizQuestions q ON c.CourseID = q.CourseID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    try
                    {
                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            sda.Fill(dt);

                            if (dt.Rows.Count > 0)
                            {
                                rptQuizList.DataSource = dt;
                                rptQuizList.DataBind();
                            }
                            else
                            {
                                lblNoQuizzes.Visible = true;
                            }
                        }
                    }
                    catch (SqlException)
                    {
                        lblNoQuizzes.Visible = true;
                        lblNoQuizzes.Text = "An error occurred while loading the quizzes. Please try again later.";
                        lblNoQuizzes.CssClass = "alert alert-danger d-block mt-3";
                    }
                }
            }
        }
    }
}