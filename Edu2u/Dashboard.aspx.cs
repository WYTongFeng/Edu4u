using System;

namespace Assignment
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Security Check: Ensure the user is logged in before viewing the dashboard
            if (Session["UserID"] == null)
            {
                Response.Redirect("LoginPage.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            // Note: Since we updated the UI to be a clean 3-module navigation menu, 
            // all the old data loading logic for tables and labels has been removed.
        }
    }
}