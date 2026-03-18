using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Configuration;

namespace Assignment
{
    public partial class LoginPage : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["Edu2UDB"]?.ConnectionString
            ?? @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Edu2U.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Show success message if redirected from the Registration page
                if (Request.QueryString["registered"] == "true")
                {
                    ShowMessage("Registration successful! Please log in.", true);
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string username = txtUsername.Text.Trim();
                string password = txtPassword.Text;

                // Hash the inputted password to compare with the database
                string hashedPassword = HashPassword(password);

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    string query = @"SELECT UserID, Role, IsActive, FullName 
                                     FROM Users 
                                     WHERE Username = @Username AND PasswordHash = @PasswordHash";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@PasswordHash", hashedPassword);

                        try
                        {
                            conn.Open();
                            using (SqlDataReader reader = cmd.ExecuteReader())
                            {
                                if (reader.Read())
                                {
                                    bool isActive = Convert.ToBoolean(reader["IsActive"]);

                                    if (!isActive)
                                    {
                                        ShowMessage("This account has been disabled. Please contact an administrator.", false);
                                        return;
                                    }

                                    // Account is valid and active. Set up Session variables.
                                    Session["UserID"] = reader["UserID"].ToString();
                                    Session["Username"] = username;
                                    Session["FullName"] = reader["FullName"].ToString();

                                    string role = reader["Role"].ToString();
                                    Session["Role"] = role;

                                    // Redirect users to their specific modules based on Role
                                    switch (role)
                                    {
                                        case "Administrator":
                                            Response.Redirect("AdminDashboard.aspx");
                                            break;
                                        case "Educator":
                                            Response.Redirect("Dashboard.aspx");
                                            break;
                                        case "Student":
                                            Response.Redirect("HomePage.aspx");
                                            break;
                                        default:
                                            Response.Redirect("HomePage.aspx");
                                            break;
                                    }
                                }
                                else
                                {
                                    ShowMessage("Invalid username or password.", false);
                                }
                            }
                        }
                        catch (SqlException ex)
                        {
                            ShowMessage("A database error occurred: " + ex.Message, false);
                        }
                    }
                }
            }
        }

        // SHA256 Password Hashing Helper (Must match the one in Register.aspx.cs)
        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString();
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