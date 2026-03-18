<%@ Page Title="Welcome to Edu2U" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="Assignment.HomePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <asp:PlaceHolder ID="phGuestView" runat="server">
        <div class="bg-dark text-white text-center py-5 mb-5" style="background: linear-gradient(135deg, var(--edu-blue) 0%, #002244 100%);">
            <div class="container py-5">
                <h1 class="display-3 fw-bold mb-3">Education to You.</h1>
                <p class="fs-4 fw-light mb-5 text-white-50">Break down geographical barriers and access world-class learning resources from anywhere, anytime.</p>
                <div class="d-flex justify-content-center gap-3">
                    <a href="Register.aspx" class="btn btn-warning btn-lg fw-bold px-5 rounded-pill">Start Learning for Free</a>
                    <a href="CourseList.aspx" class="btn btn-outline-light btn-lg fw-bold px-5 rounded-pill">Browse Catalog</a>
                </div>
            </div>
        </div>

        <div class="container mb-5">
            <div class="row g-4 text-center">
                <div class="col-md-4">
                    <div class="card h-100 border-0 shadow-sm p-4">
                        <div class="display-4 text-primary mb-3"><i class="fas fa-book-open"></i></div>
                        <h4 class="fw-bold">Rich Materials</h4>
                        <p class="text-muted">Access detailed PDFs and course notes uploaded directly by professional educators.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card h-100 border-0 shadow-sm p-4">
                        <div class="display-4 text-success mb-3"><i class="fas fa-tasks"></i></div>
                        <h4 class="fw-bold">Interactive Quizzes</h4>
                        <p class="text-muted">Test your knowledge immediately after studying with our dynamic assessment system.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card h-100 border-0 shadow-sm p-4">
                        <div class="display-4 text-info mb-3"><i class="fas fa-chart-line"></i></div>
                        <h4 class="fw-bold">Track Progress</h4>
                        <p class="text-muted">Watch your completion metrics rise as you conquer new subjects and modules.</p>
                    </div>
                </div>
            </div>
        </div>
    </asp:PlaceHolder>


    <asp:PlaceHolder ID="phStudentView" runat="server" Visible="false">
        <div class="container mt-5 mb-5">
            
            <div class="row mb-5">
                <div class="col-12">
                    <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                        <div class="card-body p-5 position-relative text-white" style="background: linear-gradient(135deg, var(--edu-blue) 0%, #002244 100%);">
                            
                            <i class="fas fa-user-graduate position-absolute" style="font-size: 10rem; right: 5%; top: 50%; transform: translateY(-50%); opacity: 0.1;"></i>
                            
                            <div class="position-relative" style="z-index: 1;">
                                <h2 class="fw-bold mb-2">Welcome back, <asp:Label ID="lblStudentName" runat="server"></asp:Label>!</h2>
                                <p class="fs-5 mb-0 text-white-50">Ready to continue your learning journey? Pick up right where you left off.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row g-4">
                
                <div class="col-md-4">
                    <div class="card h-100 shadow-sm border-0 rounded-4 student-card">
                        <div class="card-body p-4 d-flex flex-column">
                            <div class="icon-circle bg-primary bg-opacity-10 text-primary mb-4">
                                <i class="fas fa-book-open fs-4"></i>
                            </div>
                            <h4 class="card-title fw-bold">Explore Courses</h4>
                            <p class="card-text text-muted flex-grow-1">Browse our comprehensive catalog of digital learning resources and modules.</p>
                            <a href="CourseList.aspx" class="text-decoration-none fw-bold text-primary mt-3 stretched-link">View Catalog <i class="fas fa-arrow-right ms-2 fs-6"></i></a>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card h-100 shadow-sm border-0 rounded-4 student-card">
                        <div class="card-body p-4 d-flex flex-column">
                            <div class="icon-circle bg-success bg-opacity-10 text-success mb-4">
                                <i class="fas fa-chart-pie fs-4"></i>
                            </div>
                            <h4 class="card-title fw-bold">My Progress</h4>
                            <p class="card-text text-muted flex-grow-1">Track your completed courses, achievements, and view your latest quiz results.</p>
                            <a href="Progress.aspx" class="text-decoration-none fw-bold text-success mt-3 stretched-link">View Progress <i class="fas fa-arrow-right ms-2 fs-6"></i></a>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card h-100 shadow-sm border-0 rounded-4 student-card">
                        <div class="card-body p-4 d-flex flex-column">
                            <div class="icon-circle bg-warning bg-opacity-10 text-warning mb-4">
                                <i class="fas fa-user-shield fs-4"></i>
                            </div>
                            <h4 class="card-title fw-bold">My Profile</h4>
                            <p class="card-text text-muted flex-grow-1">Update your personal account details, change your password, and manage security settings.</p>
                            <a href="Profile.aspx" class="text-decoration-none fw-bold text-dark mt-3 stretched-link">Manage Account <i class="fas fa-arrow-right ms-2 fs-6"></i></a>
                        </div>
                    </div>
                </div>
                
            </div>
        </div>
    </asp:PlaceHolder>

    <style>
        /* Creates the perfect circle around the FontAwesome icons */
        .icon-circle {
            width: 65px;
            height: 65px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* Smooth hover animation for the cards */
        .student-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .student-card:hover {
            transform: translateY(-8px); /* Lifts the card up slightly */
            box-shadow: 0 .5rem 1.5rem rgba(0,0,0,.15)!important; /* Deepens the shadow */
        }
    </style>
</asp:Content>