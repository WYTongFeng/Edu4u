<%@ Page Title="Welcome to Edu2U" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="Edu2U_Application._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <%-- Custom Styles specific to HomePage for layout and mimicking reference image --%>
    <style>
        /* 1. Hero Section (Reference: Main large banner in your image) */
        .hero-banner {
            background: linear-gradient(rgba(0, 75, 156, 0.85), rgba(0, 75, 156, 0.7)), 
                        url('https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?q=80&w=2070') no-repeat center center;
            background-size: cover;
            color: white;
            padding: 10rem 2rem;
            text-align: center;
        }

        .hero-banner h1 {
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 1.5rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .hero-banner p {
            font-size: 1.25rem;
            max-width: 700px;
            margin: 0 auto 2rem auto;
            opacity: 0.9;
        }

        .btn-edu-accent {
            background-color: var(--edu-orange);
            color: white;
            font-weight: bold;
            padding: 0.75rem 2.5rem;
            border-radius: 25px;
            text-transform: uppercase;
            transition: all 0.3s ease;
        }

        .btn-edu-accent:hover {
            background-color: #d16b1a;
            color: white;
            transform: translateY(-3px);
        }

        /* 2. Features Grid (Reference: The grid of white info cards in your image) */
        .features-section {
            padding: 5rem 2rem;
            background-color: white;
        }

        .section-title {
            color: var(--edu-blue);
            font-weight: bold;
            margin-bottom: 3rem;
            text-transform: uppercase;
        }

        .info-card {
            background: #fff;
            border: none;
            border-radius: 10px;
            padding: 2.5rem;
            height: 100%;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .info-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        .info-card i {
            font-size: 3rem;
            color: var(--edu-orange);
            margin-bottom: 1.5rem;
        }

        .info-card h4 {
            color: var(--edu-blue);
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .info-card p {
            color: #666;
            font-size: 0.95rem;
            margin-bottom: 1.5rem;
        }

        .card-link {
            color: var(--edu-blue);
            font-weight: bold;
            text-decoration: none;
            text-transform: uppercase;
            font-size: 0.85rem;
        }

        .card-link:hover {
            color: var(--edu-orange);
        }
    </style>

    <%-- Hero Banner Section --%>
    <div class="hero-banner">
        <div class="container">
            <h1>Unlock Your Potential with Edu2U</h1>
            <p>Access world-class learning materials, collaborate with educators, and advance your career today through our professional web platform.</p>
            <asp:HyperLink ID="lnkAction" runat="server" NavigateUrl="~/CourseView.aspx" CssClass="btn btn-edu-accent btn-lg">Explore Courses</asp:HyperLink>
        </div>
    </div>

    <%-- Features Grid Section (Mimics the grid structure of reference image) --%>
    <div class="features-section">
        <div class="container">
            <h2 class="text-center section-title">Your Learning Journey Starts Here</h2>
            
            <div class="row g-4">
                <%-- Feature 1 --%>
                <div class="col-md-4">
                    <div class="info-card">
                        <div>
                            <i class="fas fa-book-open"></i>
                            <h4>Browse Courses</h4>
                            <p>Explore a wide variety of subjects tailored to your academic or professional needs.</p>
                        </div>
                        <asp:HyperLink runat="server" NavigateUrl="~/CourseView.aspx" CssClass="card-link">Learn More <i class="fas fa-arrow-right ms-1"></i></asp:HyperLink>
                    </div>
                </div>

                <%-- Feature 2 --%>
                <div class="col-md-4">
                    <div class="info-card">
                        <div>
                            <i class="fas fa-chalkboard-teacher"></i>
                            <h4>Expert Educators</h4>
                            <p>Interact with experienced instructors dedicated to providing quality guidance.</p>
                        </div>
                        <asp:HyperLink runat="server" NavigateUrl="#" CssClass="card-link">Our Faculty <i class="fas fa-arrow-right ms-1"></i></asp:HyperLink>
                    </div>
                </div>

                <%-- Feature 3 --%>
                <div class="col-md-4">
                    <div class="info-card">
                        <div>
                            <i class="fas fa-user-shield"></i>
                            <h4>Manage Profile</h4>
                            <p>Keep your academic records, enrolled courses, and achievements organized and accessible.</p>
                        </div>
                        <%-- This link changes dynamically based on role in codebehind --%>
                        <asp:HyperLink ID="lnkDashboard" runat="server" NavigateUrl="~/Register.aspx" CssClass="card-link">Access Dashboard <i class="fas fa-arrow-right ms-1"></i></asp:HyperLink>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>