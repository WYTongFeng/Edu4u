using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Edu2U_Application
{
    // Professional implementation of HomePage logic (non-AI)
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // We only need to adjust links if it is the first time the page loads
            if (!IsPostBack)
            {
                AdjustHomePageBasedOnAuth();
            }
        }

        /// <summary>
        /// Adjusts the HomePage call-to-action buttons depending on if the user is authenticated.
        /// </summary>
        private void AdjustHomePageBasedOnAuth()
        {
            // Note: Site.Master handles the security redirect if Session["UserID"] is null,
            // but we can make the HomePage look smarter by changing the buttons.

            if (Session["UserID"] != null && Session["Role"] != null)
            {
                // 1. If Logged In, change 'Explore Courses' to 'View My Courses'
                lnkAction.Text = "View My Courses";
                lnkAction.NavigateUrl = "~/CourseView.aspx";

                // 2. Change 'Access Dashboard' link to their specific dashboard role
                string role = Session["Role"].ToString();
                switch (role)
                {
                    case "Administrator":
                        lnkDashboard.NavigateUrl = "~/AdminDashboard.aspx";
                        break;
                    case "Educator":
                        lnkDashboard.NavigateUrl = "~/Dashboard.aspx";
                        break;
                    case "Student":
                        lnkDashboard.NavigateUrl = "~/HomePage.aspx"; // Currently they stay home or courseview
                        break;
                    default:
                        lnkDashboard.NavigateUrl = "~/CourseView.aspx";
                        break;
                }
            }
            else
            {
                // 3. If Not Logged In, make sure links point to Registration/Login
                lnkAction.Text = "Join Edu2U Today";
                lnkAction.NavigateUrl = "~/Register.aspx";

                lnkDashboard.NavigateUrl = "~/LoginPage.aspx";
            }
        }
    }
}