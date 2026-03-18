using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Assignment
{
    public partial class Progress : System.Web.UI.Page
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
                LoadAllProgress();
            }
        }

        private void LoadAllProgress()
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    conn.Open();

                    // --- 1. LOAD COURSE MATERIAL PROGRESS ---
                    string courseQuery = @"
                        SELECT c.Title, c.Category, c.Instructor, p.CompletedAt 
                        FROM StudentProgress p
                        INNER JOIN Courses c ON p.CourseID = c.CourseID
                        WHERE p.UserID = @UserID
                        ORDER BY p.CompletedAt DESC";

                    using (SqlCommand cmdCourse = new SqlCommand(courseQuery, conn))
                    {
                        cmdCourse.Parameters.AddWithValue("@UserID", userId);
                        using (SqlDataAdapter sdaCourse = new SqlDataAdapter(cmdCourse))
                        {
                            DataTable dtCourse = new DataTable();
                            sdaCourse.Fill(dtCourse);

                            lblTotalCompleted.Text = dtCourse.Rows.Count.ToString();

                            if (dtCourse.Rows.Count > 0)
                            {
                                rptProgress.DataSource = dtCourse;
                                rptProgress.DataBind();
                                rptProgress.Visible = true;
                                pnlNoProgress.Visible = false;
                            }
                            else
                            {
                                rptProgress.Visible = false;
                                pnlNoProgress.Visible = true;
                            }
                        }
                    }

                    // --- 2. LOAD QUIZ RESULTS ---
                    string quizQuery = @"
                        SELECT c.Title, c.Category, q.Score, q.TotalQuestions 
                        FROM QuizResults q
                        INNER JOIN Courses c ON q.CourseID = c.CourseID
                        WHERE q.UserID = @UserID";

                    using (SqlCommand cmdQuiz = new SqlCommand(quizQuery, conn))
                    {
                        cmdQuiz.Parameters.AddWithValue("@UserID", userId);
                        using (SqlDataAdapter sdaQuiz = new SqlDataAdapter(cmdQuiz))
                        {
                            DataTable dtQuiz = new DataTable();
                            sdaQuiz.Fill(dtQuiz);

                            lblTotalQuizzes.Text = dtQuiz.Rows.Count.ToString();

                            if (dtQuiz.Rows.Count > 0)
                            {
                                rptQuizProgress.DataSource = dtQuiz;
                                rptQuizProgress.DataBind();
                                rptQuizProgress.Visible = true;
                                pnlNoQuizProgress.Visible = false;
                            }
                            else
                            {
                                rptQuizProgress.Visible = false;
                                pnlNoQuizProgress.Visible = true;
                            }
                        }
                    }
                }
                catch (SqlException)
                {
                    // Fallback UI in case of database error
                    lblTotalCompleted.Text = "Error";
                    lblTotalQuizzes.Text = "Error";

                    rptProgress.Visible = false;
                    pnlNoProgress.Visible = true;

                    rptQuizProgress.Visible = false;
                    pnlNoQuizProgress.Visible = true;
                }
            }
        }
    }
}