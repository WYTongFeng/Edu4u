using System;
using System.Web.UI;

namespace Assignment
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if the user is currently logged in via Session
            if (Session["UserID"] != null)
            {
                // Hide the Login/Register buttons
                phLoggedOut.Visible = false;
                // Show the user's name and Log Off button
                phLoggedIn.Visible = true;

                if (Session["FullName"] != null)
                {
                    // Always HtmlEncode text from the database to prevent cross-site scripting (XSS)
                    lblUserName.Text = Server.HtmlEncode(Session["FullName"].ToString().Split(' ')[0]);
                }
            }
            else
            {
                // User is not logged in
                phLoggedOut.Visible = true;
                phLoggedIn.Visible = false;
            }
        }

        // Handle the Logout button click
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Destroy the user's session securely
            Session.Clear();
            Session.Abandon();

            // Redirect them to the login page
            Response.Redirect("~/LoginPage.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}