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
                                    bool isActive = false;
                                    if (reader["IsActive"] != DBNull.Value)
                                    {
                                        isActive = Convert.ToBoolean(reader["IsActive"]);
                                    }

                                    if (!isActive)
                                    {
                                        ShowMessage("DEBUG ERROR: Your account is in the database, but IsActive is False or NULL.", false);
                                        return;
                                    }

                                    // 2. Test the Password Hash
                                    string storedHash = reader["PasswordHash"].ToString();
                                    try
                                    {
                                        byte[] hashBytes = Convert.FromBase64String(storedHash);

                                        if (hashBytes.Length != 48)
                                        {
                                            ShowMessage($"DEBUG ERROR: Hash length is {hashBytes.Length}. The database might have cut off the end of your password!", false);
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
                                                ShowMessage("DEBUG ERROR: The passwords do not match.", false);
                                            }
                                        }
                                    }
                                    catch (FormatException)
                                    {
                                        ShowMessage("DEBUG ERROR: The Password in the database is not in valid Base64 format.", false);
                                    }
                                }
                                else
                                {
                                    ShowMessage("DEBUG ERROR: Username not found in the database.", false);
                                }
                            }
                        }
                        catch (SqlException ex)
                        {
                            ShowMessage("DEBUG ERROR: " + ex.Message, false);
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