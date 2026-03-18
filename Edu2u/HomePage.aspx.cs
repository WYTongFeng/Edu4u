using System;
using System.Web.UI;

namespace Assignment
{
    public partial class HomePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Check if the user is logged in as an Educator or Admin
            string role = Session["Role"]?.ToString();

            if (role == "Educator")
            {
                // Educators don't use this page, send them to their dashboard
                Response.Redirect("Dashboard.aspx");
                return;
            }
            else if (role == "Administrator")
            {
                // Admins don't use this page, send them to their dashboard
                Response.Redirect("AdminDashboard.aspx");
                return;
            }

            // 2. Handle Guests vs. Students using our new PlaceHolders
            if (Session["UserID"] == null)
            {
                // User is an Anonymous Guest. 
                // Show the beautiful public landing page, hide the student dashboard.
                phGuestView.Visible = true;
                phStudentView.Visible = false;
            }
            else
            {
                // User is a Logged-in Student!
                // Hide the public landing page, show their personal dashboard.
                phGuestView.Visible = false;
                phStudentView.Visible = true;

                if (!IsPostBack && Session["FullName"] != null)
                {
                    // Grab the user's full name and extract just the first name for a friendly greeting
                    string fullName = Session["FullName"].ToString();
                    string firstName = fullName.Split(' ')[0];

                    // Securely encode it to prevent XSS
                    lblStudentName.Text = Server.HtmlEncode(firstName);
                }
            }
        }
    }
}