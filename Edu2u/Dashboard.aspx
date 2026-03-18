<%@ Page Title="Educator Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Assignment.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4 mb-5">
        
        <div class="row mb-5">
            <div class="col-12">
                <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                    <div class="card-body p-5 position-relative text-white" style="background: linear-gradient(135deg, #0f2027 0%, #203a43 50%, #2c5364 100%);">
                        <i class="fas fa-chalkboard-teacher position-absolute" style="font-size: 10rem; right: 5%; top: 50%; transform: translateY(-50%); opacity: 0.1;"></i>
                        
                        <div class="position-relative" style="z-index: 1;">
                            <h2 class="fw-bold mb-2">Educator Portal</h2>
                            <p class="fs-5 mb-0 text-white-50">Manage your course materials, assessments, and profile settings.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4 justify-content-center">
            
            <div class="col-md-4">
                <div class="card h-100 shadow-sm border-0 rounded-4 educator-card">
                    <div class="card-body p-4 p-xl-5 d-flex flex-column align-items-center text-center">
                        <div class="icon-circle bg-primary bg-opacity-10 text-primary mb-4" style="width: 80px; height: 80px; border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                            <i class="fas fa-file-upload fs-2"></i>
                        </div>
                        <h4 class="card-title fw-bold">Upload Course</h4>
                        <p class="card-text text-muted flex-grow-1">Create new modules, upload PDF notes, and manage your existing learning materials.</p>
                        <a href="CourseManagement.aspx" class="btn btn-outline-primary w-100 mt-3 fw-bold rounded-pill stretched-link">Manage Courses</a>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card h-100 shadow-sm border-0 rounded-4 educator-card">
                    <div class="card-body p-4 p-xl-5 d-flex flex-column align-items-center text-center">
                        <div class="icon-circle bg-success bg-opacity-10 text-success mb-4" style="width: 80px; height: 80px; border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                            <i class="fas fa-tasks fs-2"></i>
                        </div>
                        <h4 class="card-title fw-bold">Upload Quiz</h4>
                        <p class="card-text text-muted flex-grow-1">Design interactive assessments and add multiple-choice questions to your courses.</p>
                        <a href="UploadContent.aspx" class="btn btn-outline-success w-100 mt-3 fw-bold rounded-pill stretched-link">Manage Quizzes</a>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card h-100 shadow-sm border-0 rounded-4 educator-card">
                    <div class="card-body p-4 p-xl-5 d-flex flex-column align-items-center text-center">
                        <div class="icon-circle bg-warning bg-opacity-10 text-warning mb-4" style="width: 80px; height: 80px; border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                            <i class="fas fa-user-edit fs-2"></i>
                        </div>
                        <h4 class="card-title fw-bold">Edit Profile</h4>
                        <p class="card-text text-muted flex-grow-1">Update your professional details, contact information, and account password.</p>
                        <a href="Profile.aspx" class="btn btn-outline-warning w-100 mt-3 fw-bold rounded-pill stretched-link text-dark border-warning">Manage Profile</a>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <style>
        .educator-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .educator-card:hover {
            transform: translateY(-8px); /* Lifts the card up slightly */
            box-shadow: 0 1rem 3rem rgba(0,0,0,.15)!important; /* Deepens the shadow */
        }
    </style>
</asp:Content>