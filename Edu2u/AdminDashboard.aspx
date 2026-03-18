<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="Assignment.AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        
        <div class="row mb-4">
            <div class="col-12">
                <h2 class="text-danger fw-bold">System Administration 🛠️</h2>
                <p class="text-muted">Welcome, <asp:Label ID="lblAdminName" runat="server" CssClass="fw-bold"></asp:Label>. Here is your system overview.</p>
            </div>
        </div>

        <div class="row g-4 mb-5">
            
            <div class="col-md-4">
                <div class="card bg-primary text-white shadow-sm border-0 h-100">
                    <div class="card-body text-center py-4">
                        <h1 class="display-3 fw-bold"><asp:Label ID="lblTotalStudents" runat="server" Text="0"></asp:Label></h1>
                        <h5 class="mb-0">Registered Students</h5>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card bg-info text-white shadow-sm border-0 h-100">
                    <div class="card-body text-center py-4">
                        <h1 class="display-3 fw-bold"><asp:Label ID="lblTotalEducators" runat="server" Text="0"></asp:Label></h1>
                        <h5 class="mb-0">Registered Educators</h5>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card bg-success text-white shadow-sm border-0 h-100">
                    <div class="card-body text-center py-4">
                        <h1 class="display-3 fw-bold"><asp:Label ID="lblTotalCourses" runat="server" Text="0"></asp:Label></h1>
                        <h5 class="mb-0">Active Courses</h5>
                    </div>
                </div>
            </div>

        </div>

        <div class="row">
            <div class="col-12">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-white fw-bold py-3">
                        ⚡ Quick Management Links
                    </div>
                    <div class="card-body p-4">
                        <div class="d-grid gap-3 d-md-block">
                            <a href="UserManagement.aspx" class="btn btn-outline-primary me-md-2 mb-2 mb-md-0">👥 Manage Users</a>
                            <a href="CourseManagement.aspx" class="btn btn-outline-success me-md-2 mb-2 mb-md-0">📚 Manage Courses</a>
                            <a href="Report.aspx" class="btn btn-outline-secondary mb-2 mb-md-0">📊 View System Reports</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</asp:Content>