using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Configuration;
using System.Web;

namespace Assignment
{
    public partial class Profile : System.Web.UI.Page
    {
        private readonly string connString = ConfigurationManager.ConnectionStrings["Edu2UDB"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Security Check
            if (Session["UserID"] == null)
            {
                Response.Redirect("LoginPage.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
            {
                LoadUserData();
            }
        }

        private void LoadUserData()
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT Username, FullName, Email FROM Users WHERE UserID = @UserID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);

                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                txtUsername.Text = reader["Username"].ToString();
                                txtFullName.Text = reader["FullName"].ToString();
                                txtEmail.Text = reader["Email"].ToString();
                            }
                        }
                    }
                    catch (SqlException)
                    {
                        ShowMessage(lblProfileMessage, "An error occurred while loading your profile data.", false);
                    }
                }
            }
        }

        protected void btnUpdateProfile_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                string fullName = txtFullName.Text.Trim();
                string email = txtEmail.Text.Trim();

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    string query = "UPDATE Users SET FullName = @FullName, Email = @Email WHERE UserID = @UserID";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@FullName", fullName);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@UserID", userId);

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();

                            // Update the session so the Master Page navigation bar changes immediately
                            Session["FullName"] = fullName;

                            ShowMessage(lblProfileMessage, "Profile updated successfully!", true);
                        }
                        catch (SqlException ex)
                        {
                            if (ex.Number == 2627 || ex.Number == 2601) // Unique constraint errors
                            {
                                ShowMessage(lblProfileMessage, "That email is already in use by another account.", false);
                            }
                            else
                            {
                                ShowMessage(lblProfileMessage, "An unexpected database error occurred.", false);
                            }
                        }
                    }
                }
            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                string currentPassword = txtCurrentPassword.Text;
                string newPassword = txtNewPassword.Text;

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    // STEP 1: Fetch the stored hash from the database
                    string fetchQuery = "SELECT PasswordHash FROM Users WHERE UserID = @UserID";
                    string storedHash = string.Empty;

                    using (SqlCommand fetchCmd = new SqlCommand(fetchQuery, conn))
                    {
                        fetchCmd.Parameters.AddWithValue("@UserID", userId);
                        try
                        {
                            conn.Open();
                            var result = fetchCmd.ExecuteScalar();
                            if (result != null)
                            {
                                storedHash = result.ToString();
                            }
                        }
                        catch (SqlException)
                        {
                            ShowMessage(lblPasswordMessage, "An error occurred while verifying your password.", false);
                            return;
                        }
                    }

                    // STEP 2: Verify the password in C# using our helper method
                    if (VerifyPassword(currentPassword, storedHash))
                    {
                        // STEP 3: Hash the new password securely and update the database
                        string hashedNewPassword = HashPasswordSecurely(newPassword);

                        string updateQuery = "UPDATE Users SET PasswordHash = @NewPassword WHERE UserID = @UserID";
                        using (SqlCommand updateCmd = new SqlCommand(updateQuery, conn))
                        {
                            updateCmd.Parameters.AddWithValue("@NewPassword", hashedNewPassword);
                            updateCmd.Parameters.AddWithValue("@UserID", userId);

                            try
                            {
                                updateCmd.ExecuteNonQuery();
                                ShowMessage(lblPasswordMessage, "Password changed successfully!", true);

                                // Clear textboxes
                                txtCurrentPassword.Text = string.Empty;
                                txtNewPassword.Text = string.Empty;
                                txtConfirmPassword.Text = string.Empty;
                            }
                            catch (SqlException)
                            {
                                ShowMessage(lblPasswordMessage, "An error occurred while updating your password.", false);
                            }
                        }
                    }
                    else
                    {
                        ShowMessage(lblPasswordMessage, "Incorrect current password.", false);
                    }
                }
            }
        }

        // --- PASSWORD SECURITY HELPERS ---

        // Hashes a new password with a random Salt (Matches Register.aspx.cs)
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

        // Extracts the Salt from the stored hash and verifies the entered password
        private bool VerifyPassword(string enteredPassword, string storedHash)
        {
            if (string.IsNullOrEmpty(storedHash)) return false;

            try
            {
                byte[] hashBytes = Convert.FromBase64String(storedHash);
                byte[] salt = new byte[16];
                Array.Copy(hashBytes, 0, salt, 0, 16);

                using (var pbkdf2 = new Rfc2898DeriveBytes(enteredPassword, salt, 100000, HashAlgorithmName.SHA256))
                {
                    byte[] hash = pbkdf2.GetBytes(32);
                    for (int i = 0; i < 32; i++)
                    {
                        if (hashBytes[i + 16] != hash[i])
                            return false;
                    }
                    return true;
                }
            }
            catch
            {
                return false; // Fail safely if the hash is corrupted
            }
        }

        private void ShowMessage(System.Web.UI.WebControls.Label labelControl, string message, bool isSuccess)
        {
            labelControl.Visible = true;
            labelControl.Text = message;
            labelControl.CssClass = isSuccess ? "alert alert-success d-block" : "alert alert-danger d-block";
        }
    }
}