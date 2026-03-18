using System;
using System.Web;

namespace Assignment
{
    public partial class HomePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Security Check: Is the user actually logged in?
            if (Session["UserID"] == null)
            {
                // Safely redirect to login page
                Response.Redirect("LoginPage.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            // 2. Role Check: Ensure Educators don't accidentally end up on the Student dashboard
            string role = Session["Role"] as string;
            if (role == "Educator")
            {
                Response.Redirect("Dashboard.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            // 3. Personalize the dashboard
            if (!IsPostBack)
            {
                if (Session["FullName"] != null)
                {
                    // Grab the user's full name and clean up any accidental leading/trailing spaces
                    string fullName = Session["FullName"].ToString().Trim();

                    // Defensive check to ensure the name isn't completely empty
                    if (!string.IsNullOrEmpty(fullName))
                    {
                        string firstName = fullName.Split(' ')[0];

                        // SECURITY FIX: Always HTML Encode user-provided text before displaying it
                        lblStudentName.Text = Server.HtmlEncode(firstName);
                    }
                    else
                    {
                        lblStudentName.Text = "Student";
                    }
                }
            }
        }
    }
}