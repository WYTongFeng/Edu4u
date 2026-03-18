using System;
using System.Web.UI;

namespace Assignment
{
    public partial class About : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // The About page is typically public, so we don't enforce a strict Role check here.
            // Anyone (Guest, Student, Educator, Admin) can read about the team!
        }
    }
}