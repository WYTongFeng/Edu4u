using System;
using System.Web.UI;

namespace Assignment
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if the user is currently logged in
            if (Session["UserID"] != null)
            {
                // User is logged in: Hide guest buttons, show logout and profile name
                phLoggedOut.Visible = false;
                phLoggedIn.Visible = true;

                // Extract their first name from the Session to display in the navbar
                if (Session["FullName"] != null)
                {
                    string fullName = Session["FullName"].ToString();
                    string firstName = fullName.Split(' ')[0];
                    lblUserName.Text = "Hi, " + firstName;
                }
            }
            else
            {
                // User is a guest: Show login/register buttons
                phLoggedOut.Visible = true;
                phLoggedIn.Visible = false;
            }
        }

        // Event handler for the Logout button
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // 1. Destroy all session data securely
            Session.Clear();
            Session.Abandon();

            // 2. Redirect the user back to the login page
            Response.Redirect("~/LoginPage.aspx");
        }
    }
}