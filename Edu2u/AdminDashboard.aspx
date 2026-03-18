<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="Assignment.AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4 mb-5">
        
        <div class="row mb-4">
            <div class="col-12">
                <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                    <div class="card-body p-5 position-relative text-white" style="background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);">
                        <i class="fas fa-user-shield position-absolute" style="font-size: 10rem; right: 5%; top: 50%; transform: translateY(-50%); opacity: 0.1;"></i>
                        
                        <div class="position-relative" style="z-index: 1;">
                            <h2 class="fw-bold mb-2">System Administration</h2>
                            <p class="fs-5 mb-0 text-white-50">Welcome back, <asp:Label ID="lblAdminName" runat="server" CssClass="text-white fw-semibold"></asp:Label>. Here is your system overview.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4 mb-5">
            <div class="col-md-4">
                <div class="card border-0 shadow-sm rounded-4 h-100 stat-card">
                    <div class="card-body p-4 d-flex align-items-center">
                        <div class="bg-primary bg-opacity-10 text-primary rounded-circle d-flex align-items-center justify-content-center me-4" style="width: 65px; height: 65px;">
                            <i class="fas fa-user-graduate fs-3"></i>
                        </div>
                        <div>
                            <p class="text-muted mb-0 small text-uppercase fw-bold tracking-wide">Total Students</p>
                            <h2 class="fw-bold mb-0 text-dark"><asp:Label ID="lblTotalStudents" runat="server" Text="0"></asp:Label></h2>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card border-0 shadow-sm rounded-4 h-100 stat-card">
                    <div class="card-body p-4 d-flex align-items-center">
                        <div class="bg-info bg-opacity-10 text-info rounded-circle d-flex align-items-center justify-content-center me-4" style="width: 65px; height: 65px;">
                            <i class="fas fa-chalkboard-teacher fs-3"></i>
                        </div>
                        <div>
                            <p class="text-muted mb-0 small text-uppercase fw-bold tracking-wide">Total Educators</p>
                            <h2 class="fw-bold mb-0 text-dark"><asp:Label ID="lblTotalEducators" runat="server" Text="0"></asp:Label></h2>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card border-0 shadow-sm rounded-4 h-100 stat-card">
                    <div class="card-body p-4 d-flex align-items-center">
                        <div class="bg-success bg-opacity-10 text-success rounded-circle d-flex align-items-center justify-content-center me-4" style="width: 65px; height: 65px;">
                            <i class="fas fa-book-open fs-3"></i>
                        </div>
                        <div>
                            <p class="text-muted mb-0 small text-uppercase fw-bold tracking-wide">Active Courses</p>
                            <h2 class="fw-bold mb-0 text-dark"><asp:Label ID="lblTotalCourses" runat="server" Text="0"></asp:Label></h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <h5 class="fw-bold text-dark mb-3 ps-1">Quick Management</h5>
        <div class="row g-4">
            
            <div class="col-md-6 col-lg-3">
                <div class="card h-100 shadow-sm border-0 rounded-4 admin-card">
                    <div class="card-body p-4 d-flex flex-column align-items-center text-center">
                        <div class="icon-circle bg-primary bg-opacity-10 text-primary mb-4" style="width: 70px; height: 70px; border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                            <i class="fas fa-users-cog fs-3"></i>
                        </div>
                        <h5 class="card-title fw-bold">Manage Users</h5>
                        <p class="card-text text-muted small flex-grow-1">Add, update, or remove students and educators from the system.</p>
                        <a href="UserManagement.aspx" class="btn btn-outline-primary w-100 mt-2 fw-bold rounded-pill stretched-link">Users</a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card h-100 shadow-sm border-0 rounded-4 admin-card">
                    <div class="card-body p-4 d-flex flex-column align-items-center text-center">
                        <div class="icon-circle bg-info bg-opacity-10 text-info mb-4" style="width: 70px; height: 70px; border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                            <i class="fas fa-file-upload fs-3"></i>
                        </div>
                        <h5 class="card-title fw-bold">Course Materials</h5>
                        <p class="card-text text-muted small flex-grow-1">Upload PDF notes, create new learning modules, and manage course data.</p>
                        <a href="CourseManagement.aspx" class="btn btn-outline-info w-100 mt-2 fw-bold rounded-pill stretched-link text-dark">Courses</a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card h-100 shadow-sm border-0 rounded-4 admin-card">
                    <div class="card-body p-4 d-flex flex-column align-items-center text-center">
                        <div class="icon-circle bg-success bg-opacity-10 text-success mb-4" style="width: 70px; height: 70px; border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                            <i class="fas fa-tasks fs-3"></i>
                        </div>
                        <h5 class="card-title fw-bold">Manage Quizzes</h5>
                        <p class="card-text text-muted small flex-grow-1">Create and manage multiple-choice assessments for active courses.</p>
                        <a href="UploadContent.aspx" class="btn btn-outline-success w-100 mt-2 fw-bold rounded-pill stretched-link">Quizzes</a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card h-100 shadow-sm border-0 rounded-4 admin-card">
                    <div class="card-body p-4 d-flex flex-column align-items-center text-center">
                        <div class="icon-circle bg-warning bg-opacity-10 text-warning mb-4" style="width: 70px; height: 70px; border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                            <i class="fas fa-chart-pie fs-3"></i>
                        </div>
                        <h5 class="card-title fw-bold">System Reports</h5>
                        <p class="card-text text-muted small flex-grow-1">Generate and view analytics on platform usage and user activity.</p>
                        <a href="Report.aspx" class="btn btn-outline-warning w-100 mt-2 fw-bold rounded-pill stretched-link text-dark">Reports</a>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <style>
        .tracking-wide {
            letter-spacing: 0.05em;
        }

        .stat-card, .admin-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .stat-card:hover {
            box-shadow: 0 0.5rem 1.5rem rgba(0,0,0,.08)!important;
        }

        .admin-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 1rem 2.5rem rgba(0,0,0,.12)!important;
        }
    </style>
</asp:Content>