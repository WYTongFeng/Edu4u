using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Assignment
{
    public partial class UploadContent : System.Web.UI.Page
    {
        private readonly string connString = ConfigurationManager.ConnectionStrings["Edu2UDB"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // SECURITY FIX: Allow BOTH Educators and Administrators.
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
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT CourseID, Title FROM Courses ORDER BY CourseID DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    // FIX: Removed the unnecessary @Instructor parameter that was causing confusion
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            ddlCourse.DataSource = reader;
                            ddlCourse.DataTextField = "Title";
                            ddlCourse.DataValueField = "CourseID";
                            ddlCourse.DataBind();
                        }

                        ddlCourse.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select a Course --", ""));
                    }
                    catch (SqlException ex)
                    {
                        ShowMessage("Failed to load courses. Please try again. Error: " + ex.Message, false);
                    }
                }
            }
        }

        protected void btnSaveQuestion_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            int courseId = int.Parse(ddlCourse.SelectedValue);
            string questionText = txtQuestion.Text.Trim();
            string optionA = txtOptionA.Text.Trim();
            string optionB = txtOptionB.Text.Trim();
            string optionC = txtOptionC.Text.Trim();
            string optionD = txtOptionD.Text.Trim();
            string correctOption = ddlCorrectOption.SelectedValue;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"INSERT INTO QuizQuestions 
                                 (CourseID, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectOption) 
                                 VALUES 
                                 (@CourseID, @QuestionText, @OptionA, @OptionB, @OptionC, @OptionD, @CorrectOption)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CourseID", courseId);
                    cmd.Parameters.AddWithValue("@QuestionText", questionText);
                    cmd.Parameters.AddWithValue("@OptionA", optionA);
                    cmd.Parameters.AddWithValue("@OptionB", optionB);
                    cmd.Parameters.AddWithValue("@OptionC", optionC);
                    cmd.Parameters.AddWithValue("@OptionD", optionD);
                    cmd.Parameters.AddWithValue("@CorrectOption", correctOption);

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();

                        ShowMessage("Question added successfully!", true);

                        txtQuestion.Text = "";
                        txtOptionA.Text = "";
                        txtOptionB.Text = "";
                        txtOptionC.Text = "";
                        txtOptionD.Text = "";
                        ddlCorrectOption.SelectedIndex = 0;
                    }
                    catch (SqlException ex)
                    {
                        ShowMessage("Database error: " + ex.Message, false);
                    }
                }
            }
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Visible = true;
            lblMessage.Text = message;

            lblMessage.CssClass = isSuccess
                ? "alert alert-success border-0 bg-success bg-opacity-10 text-success d-block p-3"
                : "alert alert-danger border-0 bg-danger bg-opacity-10 text-danger d-block p-3";

            if (isSuccess)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Scroll", "window.scrollTo({top: 0, behavior: 'smooth'});", true);
            }
        }
    }
}