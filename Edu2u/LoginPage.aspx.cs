using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Configuration;

namespace Assignment
{
    public partial class LoginPage : System.Web.UI.Page
    {
        private readonly string connString = ConfigurationManager.ConnectionStrings["Edu2UDB"]?.ConnectionString;

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

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    string query = @"SELECT UserID, Role, IsActive, FullName, PasswordHash 
                                     FROM Users 
                                     WHERE Username = @Username";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Username", username);

                        try
                        {
                            conn.Open();
                            using (SqlDataReader reader = cmd.ExecuteReader())
                            {
                                if (reader.Read())
                                {
                                    // 1. Check if the Account is Active
                                    bool isActive = reader["IsActive"] != DBNull.Value && Convert.ToBoolean(reader["IsActive"]);

                                    if (!isActive)
                                    {
                                        ShowMessage("Your account has been deactivated. Please contact an administrator.", false);
                                        return;
                                    }

                                    // 2. Test the Password Hash
                                    string storedHash = reader["PasswordHash"].ToString();
                                    try
                                    {
                                        byte[] hashBytes = Convert.FromBase64String(storedHash);

                                        if (hashBytes.Length != 48)
                                        {
                                            ShowMessage("Invalid username or password.", false);
                                            return;
                                        }

                                        byte[] salt = new byte[16];
                                        Array.Copy(hashBytes, 0, salt, 0, 16);

                                        using (var pbkdf2 = new Rfc2898DeriveBytes(password, salt, 100000, HashAlgorithmName.SHA256))
                                        {
                                            byte[] hash = pbkdf2.GetBytes(32);
                                            bool isMatch = true;
                                            for (int i = 0; i < 32; i++)
                                            {
                                                if (hashBytes[i + 16] != hash[i])
                                                {
                                                    isMatch = false;
                                                    break;
                                                }
                                            }

                                            if (isMatch)
                                            {
                                                // 3. SUCCESS! Log the user in.
                                                Session["UserID"] = reader["UserID"].ToString();
                                                Session["Username"] = username;
                                                Session["FullName"] = reader["FullName"].ToString();

                                                string role = reader["Role"].ToString();
                                                Session["Role"] = role;

                                                if (role == "Administrator") Response.Redirect("AdminDashboard.aspx", false);
                                                else if (role == "Educator") Response.Redirect("Dashboard.aspx", false);
                                                else Response.Redirect("HomePage.aspx", false);

                                                Context.ApplicationInstance.CompleteRequest();
                                            }
                                            else
                                            {
                                                ShowMessage("Invalid username or password.", false);
                                            }
                                        }
                                    }
                                    catch (FormatException)
                                    {
                                        ShowMessage("Invalid username or password.", false);
                                    }
                                }
                                else
                                {
                                    ShowMessage("Invalid username or password.", false);
                                }
                            }
                        }
                        catch (SqlException)
                        {
                            ShowMessage("An unexpected database error occurred. Please try again later.", false);
                        }
                    }
                }
            }
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Visible = true;
            lblMessage.Text = message;

            // Professional alert styles
            lblMessage.CssClass = isSuccess
                ? "alert alert-success border-0 bg-success bg-opacity-10 text-success d-block p-3"
                : "alert alert-danger border-0 bg-danger bg-opacity-10 text-danger d-block p-3";
        }
    }
}