using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Configuration;

namespace Assignment
{
    public partial class UserManagement : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["Edu2UDB"]?.ConnectionString
            ?? @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Edu2U.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Security Check: Admins only!
            if (Session["UserID"] == null || Session["Role"]?.ToString() != "Administrator")
            {
                Response.Redirect("LoginPage.aspx");
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
                string query = "SELECT UserID, Username, FullName, Email, Role, IsActive FROM Users ORDER BY UserID DESC";
                using (SqlDataAdapter sda = new SqlDataAdapter(query, conn))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    gvUsers.DataSource = dt;
                    gvUsers.DataBind();
                }
            }
        }

        // Triggered when Admin clicks "Edit"
        protected void gvUsers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvUsers.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        // Triggered when Admin clicks "Cancel" during edit
        protected void gvUsers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvUsers.EditIndex = -1;
            BindGrid();
        }

        // Triggered when Admin clicks "Update" to save changes
        protected void gvUsers_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int userId = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value);

            GridViewRow row = gvUsers.Rows[e.RowIndex];
            string fullName = (row.Cells[2].Controls[0] as TextBox).Text.Trim();
            string email = (row.Cells[3].Controls[0] as TextBox).Text.Trim();
            string role = (row.FindControl("ddlRoleEdit") as DropDownList).SelectedValue;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "UPDATE Users SET FullName = @FullName, Email = @Email, Role = @Role WHERE UserID = @UserID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@FullName", fullName);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Role", role);
                    cmd.Parameters.AddWithValue("@UserID", userId);

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();

                        gvUsers.EditIndex = -1; // Close edit mode
                        BindGrid(); // Refresh grid

                        ShowMessage("User updated successfully.", true);
                    }
                    catch (SqlException ex)
                    {
                        if (ex.Number == 2627)
                            ShowMessage("Update failed. That email is already in use.", false);
                        else
                            ShowMessage("Database error: " + ex.Message, false);
                    }
                }
            }
        }

        // Triggered when Admin clicks custom buttons (like Disable/Enable)
        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ToggleStatus")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                int userId = Convert.ToInt32(gvUsers.DataKeys[rowIndex].Value);

                // Find out what the current status is by reading the button text
                Button btn = (Button)gvUsers.Rows[rowIndex].FindControl("btnToggleStatus");
                bool makeActive = btn.Text == "Enable"; // If button says Enable, we need to set IsActive to 1 (true)

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    string query = "UPDATE Users SET IsActive = @IsActive WHERE UserID = @UserID";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@IsActive", makeActive);
                        cmd.Parameters.AddWithValue("@UserID", userId);

                        conn.Open();
                        cmd.ExecuteNonQuery();

                        BindGrid(); // Refresh grid to show new status
                        ShowMessage(makeActive ? "User account enabled." : "User account disabled.", true);
                    }
                }
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