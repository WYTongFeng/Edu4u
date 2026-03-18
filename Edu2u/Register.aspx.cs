using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Configuration;

namespace Assignment
{
    public partial class Register : System.Web.UI.Page
    {
        // Safely retrieve the connection string. It's better practice to let the app throw an error 
        // if the string is missing rather than falling back to a hardcoded LocalDB path.
        private readonly string connString = ConfigurationManager.ConnectionStrings["Edu2UDB"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            // Ensure ASPX validators have passed
            if (Page.IsValid)
            {
                string fullName = txtFullName.Text.Trim();
                string email = txtEmail.Text.Trim();
                string username = txtUsername.Text.Trim();
                string password = txtPassword.Text;
                string role = ddlRole.SelectedValue;

                // Basic server-side validation fallback
                if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password) || string.IsNullOrEmpty(email))
                {
                    ShowMessage("Please fill in all required fields.", false);
                    return;
                }

                // Hash the password securely with a Salt
                string hashedPassword = HashPasswordSecurely(password);

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    string query = @"INSERT INTO Users (Username, PasswordHash, FullName, Email, Role, IsActive) 
                                    VALUES (@Username, @PasswordHash, @FullName, @Email, @Role, 1)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        // Using AddWithValue is okay for simple strings, but specifying SqlDbType is safer for production
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@PasswordHash", hashedPassword);
                        cmd.Parameters.AddWithValue("@FullName", fullName);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Role", role);

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();

                            // Success! Redirect to login page
                            Response.Redirect("LoginPage.aspx?registered=true", false);
                            Context.ApplicationInstance.CompleteRequest();
                        }
                        catch (SqlException ex)
                        {
                            // Error 2627 is Unique Constraint, 2601 is Unique Index
                            if (ex.Number == 2627 || ex.Number == 2601)
                            {
                                ShowMessage("Username or Email already exists. Please choose another.", false);
                            }
                            else
                            {
                                // SECURITY FIX: Never expose raw database errors (ex.Message) to the end user.
                                ShowMessage("An unexpected database error occurred. Please try again later.", false);
                            }
                        }
                        catch (Exception)
                        {
                            ShowMessage("An unexpected error occurred during registration.", false);
                        }
                    }
                }
            }
        }

        // SECURITY UPGRADE: PBKDF2 Password Hashing with a Salt
        private string HashPasswordSecurely(string password)
        {
            // 1. Generate a random salt
            byte[] salt = new byte[16];
            using (var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(salt);
            }

            // 2. Hash the password using PBKDF2
            using (var pbkdf2 = new Rfc2898DeriveBytes(password, salt, 100000, HashAlgorithmName.SHA256))
            {
                byte[] hash = pbkdf2.GetBytes(32); // 256-bit hash

                // 3. Combine salt and hash into a single string for storage
                byte[] hashBytes = new byte[48]; // 16 bytes salt + 32 bytes hash
                Array.Copy(salt, 0, hashBytes, 0, 16);
                Array.Copy(hash, 0, hashBytes, 16, 32);

                return Convert.ToBase64String(hashBytes);
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