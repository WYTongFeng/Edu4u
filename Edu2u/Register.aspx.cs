using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Configuration;

namespace Assignment
{
    public partial class Register : System.Web.UI.Page
    {
        private readonly string connString = ConfigurationManager.ConnectionStrings["Edu2UDB"]?.ConnectionString;

        // The secret code required to create an educator account
        private readonly string SECRET_EDUCATOR_CODE = "EDU-2026-APU";

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string fullName = txtFullName.Text.Trim();
                string email = txtEmail.Text.Trim();
                string username = txtUsername.Text.Trim();
                string password = txtPassword.Text;
                string role = ddlRole.SelectedValue;
                string accessCode = txtAccessCode.Text.Trim();

                if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password) || string.IsNullOrEmpty(email))
                {
                    ShowMessage("Please fill in all required fields.", false);
                    return;
                }

                // 🚨 SECURITY CHECK: Verify Educator Access Code
                if (role == "Educator")
                {
                    if (accessCode != SECRET_EDUCATOR_CODE)
                    {
                        ShowMessage("Invalid Educator Access Code. Please contact IT if you are a legitimate staff member.", false);
                        return;
                    }
                }

                // Hash the password securely with a Salt
                string hashedPassword = HashPasswordSecurely(password);

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    string query = @"INSERT INTO Users (Username, PasswordHash, FullName, Email, Role, IsActive) 
                                     VALUES (@Username, @PasswordHash, @FullName, @Email, @Role, 1)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
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

        // PBKDF2 Password Hashing with a Salt
        private string HashPasswordSecurely(string password)
        {
            byte[] salt = new byte[16];
            using (var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(salt);
            }

            using (var pbkdf2 = new Rfc2898DeriveBytes(password, salt, 100000, HashAlgorithmName.SHA256))
            {
                byte[] hash = pbkdf2.GetBytes(32);

                byte[] hashBytes = new byte[48];
                Array.Copy(salt, 0, hashBytes, 0, 16);
                Array.Copy(hash, 0, hashBytes, 16, 32);

                return Convert.ToBase64String(hashBytes);
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