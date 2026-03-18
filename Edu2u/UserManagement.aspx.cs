using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Security.Cryptography;

namespace Assignment
{
    public partial class UserManagement : System.Web.UI.Page
    {
        private readonly string connString = ConfigurationManager.ConnectionStrings["Edu2UDB"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null || Session["Role"]?.ToString() != "Administrator")
            {
                Response.Redirect("LoginPage.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        private void BindGrid()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                // Removed IsActive since we are fully deleting users now
                string query = "SELECT UserID, Username, FullName, Email, Role FROM Users ORDER BY UserID DESC";
                using (SqlDataAdapter sda = new SqlDataAdapter(query, conn))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    gvUsers.DataSource = dt;
                    gvUsers.DataBind();
                }
            }
        }

        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string fullName = txtNewFullName.Text.Trim();
            string email = txtNewEmail.Text.Trim();
            string username = txtNewUsername.Text.Trim();
            string password = txtNewPassword.Text;
            string role = ddlNewRole.SelectedValue;

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

                        ShowMessage($"User '{username}' created successfully.", true);

                        txtNewFullName.Text = "";
                        txtNewEmail.Text = "";
                        txtNewUsername.Text = "";
                        txtNewPassword.Text = "";
                        ddlNewRole.SelectedIndex = 0;

                        BindGrid();
                    }
                    catch (SqlException ex)
                    {
                        if (ex.Number == 2627 || ex.Number == 2601)
                        {
                            ShowMessage("Username or Email already exists. Please choose another.", false);
                        }
                        else
                        {
                            ShowMessage("An unexpected database error occurred while creating the user.", false);
                        }
                    }
                }
            }
        }

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

        protected void gvUsers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvUsers.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void gvUsers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvUsers.EditIndex = -1;
            BindGrid();
        }

        // Expanded Updating Logic to include Username
        protected void gvUsers_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int userId = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvUsers.Rows[e.RowIndex];

            TextBox txtUsername = row.FindControl("txtEditUsername") as TextBox;
            TextBox txtFullName = row.FindControl("txtEditFullName") as TextBox;
            TextBox txtEmail = row.FindControl("txtEditEmail") as TextBox;
            DropDownList ddlRole = row.FindControl("ddlEditRole") as DropDownList;

            if (txtUsername == null || txtFullName == null || txtEmail == null || ddlRole == null) return;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "UPDATE Users SET Username = @Username, FullName = @FullName, Email = @Email, Role = @Role WHERE UserID = @UserID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
                    cmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@Role", ddlRole.SelectedValue);
                    cmd.Parameters.AddWithValue("@UserID", userId);

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();

                        gvUsers.EditIndex = -1;
                        BindGrid();
                        ShowMessage("User details updated successfully.", true);
                    }
                    catch (SqlException ex)
                    {
                        if (ex.Number == 2627 || ex.Number == 2601)
                        {
                            ShowMessage("The Username or Email provided is already in use by another account.", false);
                        }
                        else
                        {
                            ShowMessage("Database error while updating user.", false);
                        }
                    }
                }
            }
        }

        // New Hard-Delete Logic
        protected void gvUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int userId = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value);

            // Prevent the Admin from accidentally deleting their own currently logged-in account
            if (Session["UserID"] != null && userId.ToString() == Session["UserID"].ToString())
            {
                ShowMessage("You cannot delete your own administrator account.", false);
                return;
            }

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "DELETE FROM Users WHERE UserID = @UserID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();

                        BindGrid();
                        ShowMessage("User deleted successfully.", true);
                    }
                    catch (SqlException ex)
                    {
                        // 547 is the SQL error code for Foreign Key Constraint Violations
                        if (ex.Number == 547)
                        {
                            ShowMessage("Cannot delete this user because they are associated with existing courses or quizzes.", false);
                        }
                        else
                        {
                            ShowMessage("An error occurred while deleting the user.", false);
                        }
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
        }
    }
}