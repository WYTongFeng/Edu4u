using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Assignment
{
    public partial class Quiz : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["Edu2UDB"]?.ConnectionString
            ?? @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Edu2U.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Security Check
            if (Session["UserID"] == null || Session["Role"]?.ToString() != "Student")
            {
                Response.Redirect("LoginPage.aspx");
                return;
            }

            if (!IsPostBack)
            {
                string courseIdStr = Request.QueryString["id"];
                if (int.TryParse(courseIdStr, out int courseId))
                {
                    LoadCourseName(courseId);
                    LoadQuestions(courseId);
                }
                else
                {
                    Response.Redirect("CourseList.aspx");
                }
            }
        }

        private void LoadCourseName(int courseId)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT Title FROM Courses WHERE CourseID = @CourseID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CourseID", courseId);
                    conn.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        lblCourseName.Text = result.ToString();
                    }
                }
            }
        }

        private void LoadQuestions(int courseId)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT * FROM QuizQuestions WHERE CourseID = @CourseID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CourseID", courseId);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            rptQuestions.DataSource = dt;
                            rptQuestions.DataBind();
                        }
                        else
                        {
                            quizContainer.Visible = false;
                            ShowMessage("There are no questions available for this course yet.", false);
                        }
                    }
                }
            }
        }

        protected void btnSubmitQuiz_Click(object sender, EventArgs e)
        {
            int courseId = Convert.ToInt32(Request.QueryString["id"]);
            int userId = Convert.ToInt32(Session["UserID"]);
            int score = 0;
            int totalQuestions = 0;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                // Pull the correct answers from the database to compare against the student's submission
                string query = "SELECT QuestionID, CorrectOption FROM QuizQuestions WHERE CourseID = @CourseID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CourseID", courseId);
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            totalQuestions++;
                            string questionId = reader["QuestionID"].ToString();
                            string correctOption = reader["CorrectOption"].ToString();

                            // Read the HTML radio button value submitted by the user
                            string studentAnswer = Request.Form["q_" + questionId];

                            if (studentAnswer == correctOption)
                            {
                                score++;
                            }
                        }
                    }
                }

                // Save the result to the QuizResults table
                if (totalQuestions > 0)
                {
                    string insertQuery = @"INSERT INTO QuizResults (UserID, CourseID, Score, TotalQuestions) 
                                           VALUES (@UserID, @CourseID, @Score, @TotalQuestions)";
                    using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                    {
                        insertCmd.Parameters.AddWithValue("@UserID", userId);
                        insertCmd.Parameters.AddWithValue("@CourseID", courseId);
                        insertCmd.Parameters.AddWithValue("@Score", score);
                        insertCmd.Parameters.AddWithValue("@TotalQuestions", totalQuestions);

                        insertCmd.ExecuteNonQuery();
                    }

                    // Hide the quiz and show the result!
                    quizContainer.Visible = false;
                    ShowMessage($"Quiz Submitted! You scored {score} out of {totalQuestions}.", true);
                }
            }
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Visible = true;
            lblMessage.Text = message;
            lblMessage.CssClass = isSuccess ? "alert alert-success d-block text-center fs-5 py-4" : "alert alert-warning d-block";
        }
    }
}