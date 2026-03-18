<%@ Page Title="Assessments" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QuizList.aspx.cs" Inherits="Assignment.QuizList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="bg-light border-bottom py-4 mb-5">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb bg-transparent p-0 mb-3">
                    <li class="breadcrumb-item"><a href="HomePage.aspx" class="text-decoration-none">Home</a></li>
                    <li class="breadcrumb-item active fw-semibold" aria-current="page">Assessments</li>
                </ol>
            </nav>
            <div class="d-flex align-items-center">
                <div class="icon-circle bg-primary bg-opacity-10 text-primary me-3" style="width: 55px; height: 55px;">
                    <i class="fas fa-tasks fs-4"></i>
                </div>
                <div>
                    <h2 class="fw-bold mb-1">Module Assessments</h2>
                    <p class="text-muted mb-0">Select a module below to begin your knowledge check.</p>
                </div>
            </div>
        </div>
    </div>

    <div class="container mb-5">
        <div class="row">
            <asp:Repeater ID="rptQuizList" runat="server">
                <ItemTemplate>
                    <div class="col-md-6 col-lg-4 mb-4">
                        <div class="card shadow-sm h-100 border-0 rounded-4 student-card">
                            <div class="card-body p-4 d-flex flex-column">
                                <span class="badge bg-secondary mb-3 align-self-start px-3 py-2 rounded-pill"><%# Eval("Category") %></span>
                                <h5 class="card-title fw-bold mb-3 flex-grow-1"><%# Eval("Title") %></h5>
                                <hr class="opacity-10 mb-3" />
                                <a href='Quiz.aspx?id=<%# Eval("CourseID") %>' class="btn btn-outline-primary w-100 fw-semibold">
                                    Start Assessment <i class="fas fa-arrow-right ms-2"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            
            <asp:Label ID="lblNoQuizzes" runat="server" CssClass="alert alert-info d-block shadow-sm rounded-3 py-3" Visible="false" Text="No assessments are currently active for your enrolled modules."></asp:Label>
        </div>
    </div>
    
    <style>
        .student-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .student-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 .5rem 1.5rem rgba(0,0,0,.10)!important;
        }
    </style>
</asp:Content>