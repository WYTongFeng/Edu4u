<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Assignment.About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4 mb-5">
        
        <div class="row mb-5">
            <div class="col-12">
                <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                    <div class="card-body p-5 position-relative text-white" style="background: linear-gradient(135deg, #2b5876 0%, #4e4376 100%);">
                        <i class="fas fa-globe-asia position-absolute" style="font-size: 12rem; right: 5%; top: 50%; transform: translateY(-50%); opacity: 0.1;"></i>
                        
                        <div class="position-relative" style="z-index: 1;">
                            <span class="badge bg-white text-dark mb-3 px-3 py-2 rounded-pill fw-bold tracking-wide">GROUP 28 PROJECT</span>
                            <h1 class="fw-bold mb-3 display-4">Edu2U</h1>
                            <p class="fs-5 mb-0 text-white-50" style="max-width: 600px;">
                                A comprehensive digital learning platform designed to break down geographical barriers and provide students with convenient, efficient learning resources.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4 mb-5">
            <div class="col-md-6">
                <div class="card border-0 shadow-sm rounded-4 h-100 info-card p-2">
                    <div class="card-body p-4">
                        <div class="icon-circle bg-primary bg-opacity-10 text-primary mb-4" style="width: 60px; height: 60px; border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                            <i class="fas fa-bullseye fs-3"></i>
                        </div>
                        <h4 class="fw-bold text-dark">Our Mission</h4>
                        <p class="text-muted mb-0">To deliver high-quality, interactive, and accessible education to everyone, everywhere.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card border-0 shadow-sm rounded-4 h-100 info-card p-2">
                    <div class="card-body p-4">
                        <div class="icon-circle bg-success bg-opacity-10 text-success mb-4" style="width: 60px; height: 60px; border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                            <i class="fas fa-lightbulb fs-3"></i>
                        </div>
                        <h4 class="fw-bold text-dark">Our Vision</h4>
                        <p class="text-muted mb-0">To become the leading digital ecosystem that inspires students to achieve their highest potential.</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="text-center mb-5">
            <h2 class="fw-bold text-dark">Meet The Team</h2>
            <p class="text-muted">The developers and designers behind the Edu2U platform.</p>
        </div>

        <div class="row g-4 justify-content-center">
            
            <div class="col-md-6 col-lg-3">
                <div class="card border-0 shadow-sm rounded-4 h-100 text-center team-card overflow-hidden">
                    <img src="Images/Team/tan-li-qi.jpg" class="card-img-top" alt="Tan Li Qi" style="height: 280px; object-fit: cover; object-position: top;">
                    <div class="card-body p-4">
                        <h5 class="fw-bold mb-1">Tan Li Qi</h5>
                        <p class="text-muted small fw-semibold mb-0">Project Member </p>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card border-0 shadow-sm rounded-4 h-100 text-center team-card overflow-hidden">
                    <img src="Images/Team/chua-mi-kai.jpg" class="card-img-top" alt="Chua Mi Kai" style="height: 280px; object-fit: cover; object-position: top;">
                    <div class="card-body p-4">
                        <h5 class="fw-bold mb-1">Chua Mi Kai</h5>
                        <p class="text-muted small fw-semibold mb-0">Project Member </p>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card border-0 shadow-sm rounded-4 h-100 text-center team-card overflow-hidden">
                    <img src="Images/Team/lee-kiat-seng.jpg" class="card-img-top" alt="Lee Kiat Seng" style="height: 280px; object-fit: cover; object-position: top;">
                    <div class="card-body p-4">
                        <h5 class="fw-bold mb-1">Lee Kiat Seng</h5>
                        <p class="text-muted small fw-semibold mb-0">Project Member </p>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card border-0 shadow-sm rounded-4 h-100 text-center team-card overflow-hidden">
                    <img src="Images/Team/richter-yong.jpg" class="card-img-top" alt="Richter Yong Yik Chun" style="height: 280px; object-fit: cover; object-position: top;">
                    <div class="card-body p-4">
                        <h5 class="fw-bold mb-1">Richter Yong Yik Chun</h5>
                        <p class="text-muted small fw-semibold mb-0">Project Member </p>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <style>
        .tracking-wide { letter-spacing: 0.1em; }
        .info-card, .team-card { transition: transform 0.3s ease, box-shadow 0.3s ease; }
        .info-card:hover { box-shadow: 0 0.5rem 1.5rem rgba(0,0,0,.08)!important; }
        .team-card:hover { transform: translateY(-10px); box-shadow: 0 1rem 3rem rgba(0,0,0,.15)!important; }
        .team-card img { transition: transform 0.5s ease; }
        .team-card:hover img { transform: scale(1.05); }
    </style>
</asp:Content>