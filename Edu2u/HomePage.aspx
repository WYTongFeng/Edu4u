<%@ Page Title="Student Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="Assignment.HomePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <style>
        /* --- 3D Dashboard Specific Styles --- */
        .hero-3d {
            background: linear-gradient(135deg, #8e2de2 0%, #4a00e0 100%);
            border-radius: 20px;
            box-shadow: 10px 10px 20px var(--shadow-dark), 
                       -10px -10px 20px var(--shadow-light);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .card-3d {
            background-color: var(--bg-color);
            border: none;
            border-radius: 20px;
            box-shadow: 8px 8px 16px var(--shadow-dark), 
                       -8px -8px 16px var(--shadow-light);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card-3d:hover {
            transform: translateY(-5px);
            box-shadow: 12px 12px 24px var(--shadow-dark), 
                       -12px -12px 24px var(--shadow-light);
        }

        .border-left-theme {
            border-left: 5px solid var(--theme-color) !important;
            border-top-left-radius: 5px; /* Keeps the edge sharp for the accent line */
            border-bottom-left-radius: 5px;
        }

        /* Custom icon colors to match the premium vibe */
        .icon-violet { color: #8e2de2; }
        .icon-fuchsia { color: #d500f9; }
        .icon-indigo { color: #3d5afe; }
    </style>

    <div class="container mt-2">
        
        <div class="p-5 mb-5 text-white hero-3d">
            <div class="container-fluid py-3">
                <h1 class="display-5 fw-bold" style="text-shadow: 2px 2px 4px rgba(0,0,0,0.3);">
                    Welcome back, <asp:Label ID="lblStudentName" runat="server" Text="Student"></asp:Label>!
                </h1>
                <p class="col-md-9 fs-5 mt-3 text-white-50" style="text-shadow: 1px 1px 2px rgba(0,0,0,0.2);">
                    Ready to continue your learning journey? Explore new courses or pick up right where you left off in Edu2U.
                </p>
            </div>
        </div>

        <div class="row g-4 mt-2">
            
            <div class="col-md-4">
                <div class="card card-3d h-100">
                    <div class="card-body text-center p-4 p-xl-5">
                        <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" fill="currentColor" class="icon-violet mb-4" viewBox="0 0 16 16">
                            <path d="M1 2.828c.885-.37 2.154-.769 3.388-.893 1.33-.134 2.458.156 3.112.76.416.384.6.868.7 1.398h.02c.1-.53.284-1.014.7-1.398.654-.604 1.782-.894 3.112-.76 1.234.124 2.503.523 3.388.893V14.2c-.885-.37-2.154-.769-3.388-.893-1.33-.134-2.458.156-3.112.76-.416.384-.6.868-.7 1.398h-.02c-.1-.53-.284-1.014-.7-1.398-.654-.604-1.782-.894-3.112-.76-1.234.124-2.503.523-3.388.893V2.828zM8 4.5a.5.5 0 0 0 .5.5c1.25-.125 2.65-.5 3.96-1.05V12.1c-1.2-.55-2.5-1-3.6-1.15a.5.5 0 0 0-.86 0c-1.1.15-2.4.6-3.6 1.15V3.95c1.31.55 2.71.925 3.96 1.05a.5.5 0 0 0 .5-.5z"/>
                        </svg>
                        <h4 class="card-title fw-bold" style="color: var(--text-dark);">Learning Materials</h4>
                        <p class="card-text text-muted mb-4">Browse our comprehensive catalog of digital learning resources and courses.</p>
                        <a href="CourseList.aspx" class="btn-3d-outline w-100 text-decoration-none d-block">View Courses</a>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card card-3d h-100">
                    <div class="card-body text-center p-4 p-xl-5">
                        <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" fill="currentColor" class="icon-fuchsia mb-4" viewBox="0 0 16 16">
                            <path fill-rule="evenodd" d="M0 0h1v15h15v1H0V0Zm14.817 3.113a.5.5 0 0 1 .07.704l-4.5 5.5a.5.5 0 0 1-.74.037L7.06 6.767l-3.656 5.027a.5.5 0 0 1-.808-.588l4-5.5a.5.5 0 0 1 .758-.06l2.609 2.61 4.15-5.073a.5.5 0 0 1 .704-.07Z"/>
                        </svg>
                        <h4 class="card-title fw-bold" style="color: var(--text-dark);">My Progress</h4>
                        <p class="card-text text-muted mb-4">Track your learning activities, history, and view your quiz results.</p>
                        <a href="Progress.aspx" class="btn-3d-outline w-100 text-decoration-none d-block">View Progress</a>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card card-3d h-100">
                    <div class="card-body text-center p-4 p-xl-5">
                        <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" fill="currentColor" class="icon-indigo mb-4" viewBox="0 0 16 16">
                            <path d="M8 4.754a3.246 3.246 0 1 0 0 6.492 3.246 3.246 0 0 0 0-6.492zM5.754 8a2.246 2.246 0 1 1 4.492 0 2.246 2.246 0 0 1-4.492 0z"/>
                            <path d="M9.796 1.343c-.527-1.79-3.065-1.79-3.592 0l-.094.319a.873.873 0 0 1-1.255.52l-.292-.16c-1.64-.892-3.433.902-2.54 2.541l.159.292a.873.873 0 0 1-.52 1.255l-.319.094c-1.79.527-1.79 3.065 0 3.592l.319.094a.873.873 0 0 1 .52 1.255l-.16.292c-.892 1.64.901 3.434 2.541 2.54l.292-.159a.873.873 0 0 1 1.255.52l.094.319c.527 1.79 3.065 1.79 3.592 0l.094-.319a.873.873 0 0 1 1.255-.52l.292.16c1.64.893 3.434-.902 2.54-2.541l-.159-.292a.873.873 0 0 1 .52-1.255l.319-.094c1.79-.527 1.79-3.065 0-3.592l-.319-.094a.873.873 0 0 1-.52-1.255l.16-.292c.893-1.64-.902-3.433-2.541-2.54l-.292.159a.873.873 0 0 1-1.255-.52l-.094-.319zm-2.633.283c.246-.835 1.428-.835 1.674 0l.094.319a1.873 1.873 0 0 0 2.693 1.115l.291-.16c.764-.415 1.6.42 1.184 1.185l-.159.292a1.873 1.873 0 0 0 1.116 2.692l.318.094c.835.246.835 1.428 0 1.674l-.319.094a1.873 1.873 0 0 0-1.115 2.693l.16.291c.415.764-.42 1.6-1.185 1.184l-.291-.159a1.873 1.873 0 0 0-2.693 1.116l-.094.318c-.246.835-1.428.835-1.674 0l-.094-.319a1.873 1.873 0 0 0-2.692-1.115l-.292.16c-.764.415-1.6-.42-1.184-1.185l.159-.291A1.873 1.873 0 0 0 1.945 8.93l-.319-.094c-.835-.246-.835-1.428 0-1.674l.319-.094A1.873 1.873 0 0 0 3.06 4.377l-.16-.292c-.415-.764.42-1.6 1.185-1.184l.292.159a1.873 1.873 0 0 0 2.692-1.115l.094-.319z"/>
                        </svg>
                        <h4 class="card-title fw-bold" style="color: var(--text-dark);">Personal Profile</h4>
                        <p class="card-text text-muted mb-4">Update your account details, change your password, and manage preferences.</p>
                        <a href="Profile.aspx" class="btn-3d-outline w-100 text-decoration-none d-block">Manage Profile</a>
                    </div>
                </div>
            </div>
            
        </div>

        <div class="mt-5 mb-5 pt-3">
            <h3 class="mb-4 fw-bold" style="color: var(--text-dark); text-shadow: 1px 1px 2px rgba(0,0,0,0.05);">Recommended for You</h3>
            <div class="row g-4">
                
                <div class="col-md-6">
                    <div class="card card-3d border-left-theme h-100">
                        <div class="card-body p-4">
                            <h5 class="card-title fw-bold" style="color: var(--theme-color);">Web Applications using .NET</h5>
                            <h6 class="card-subtitle mb-3 text-muted">Instructor: Dr. Lai Ngan Kuen</h6>
                            <p class="card-text" style="color: var(--text-dark);">Master ASP.NET Web Forms, C# backend logic, and robust SQL Server database integration.</p>
                            <a href="CourseList.aspx" class="btn-3d mt-2 d-inline-block text-decoration-none">Start Learning</a>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-6">
                    <div class="card card-3d h-100">
                        <div class="card-body p-4">
                            <h5 class="card-title fw-bold" style="color: var(--text-dark);">Introduction to Cyber Security</h5>
                            <h6 class="card-subtitle mb-3 text-muted">Instructor: Dr. Lai Ngan Kuen</h6>
                            <p class="card-text text-muted">Learn the fundamentals of network security, safe coding practices, and risk management.</p>
                            <a href="CourseList.aspx" class="btn-3d-outline mt-2 d-inline-block text-decoration-none">Start Learning</a>
                        </div>
                    </div>
                </div>

            </div>
        </div>

    </div>
</asp:Content>