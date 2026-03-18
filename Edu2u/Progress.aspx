<%@ Page Title="My Progress" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Progress.aspx.cs" Inherits="Assignment.Progress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4 mb-5">
        
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb bg-transparent p-0 mb-4">
                <li class="breadcrumb-item"><a href="HomePage.aspx" class="text-decoration-none">Home</a></li>
                <li class="breadcrumb-item active fw-semibold" aria-current="page">My Progress</li>
            </ol>
        </nav>

        <div class="d-flex align-items-center mb-5">
            <div class="icon-circle bg-success bg-opacity-10 text-success me-3">
                <i class="fas fa-chart-pie fs-3"></i>
            </div>
            <div>
                <h2 class="fw-bold mb-1">Learning Progress</h2>
                <p class="text-muted mb-0">Track your module completions and assessment scores.</p>
            </div>
        </div>

        <div class="row mb-5 g-4">
            <div class="col-md-6">
                <div class="card text-white shadow-sm border-0 rounded-4 h-100 progress-card" style="background: linear-gradient(135deg, #198754 0%, #146c43 100%);">
                    <div class="card-body text-center py-4 d-flex flex-column justify-content-center">
                        <h1 class="display-3 fw-bold mb-0">
                            <asp:Label ID="lblTotalCompleted" runat="server" Text="0"></asp:Label>
                        </h1>
                        <h5 class="mt-2 mb-0 fw-light opacity-75">Modules Completed</h5>
                    </div>
                </div>
            </div>
            
            <div class="col-md-6">
                <div class="card text-white shadow-sm border-0 rounded-4 h-100 progress-card" style="background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);">
                    <div class="card-body text-center py-4 d-flex flex-column justify-content-center">
                        <h1 class="display-3 fw-bold mb-0">
                            <asp:Label ID="lblTotalQuizzes" runat="server" Text="0"></asp:Label>
                        </h1>
                        <h5 class="mt-2 mb-0 fw-light opacity-75">Assessments Completed</h5>
                    </div>
                </div>
            </div>
        </div>

        <h4 class="fw-bold mb-3"><i class="fas fa-book-reader text-success me-2"></i> Module History</h4>
        <div class="card shadow-sm border-0 rounded-4 overflow-hidden mb-5">
            <div class="card-body p-0">
                <asp:Repeater ID="rptProgress" runat="server">
                    <HeaderTemplate>
                        <div class="table-responsive">
                            <table class="table table-hover mb-0 align-middle border-bottom-0">
                                <thead class="table-light">
                                    <tr>
                                        <th class="ps-4 py-3 border-bottom-0">Module Title</th>
                                        <th class="py-3 border-bottom-0">Category</th>
                                        <th class="py-3 border-bottom-0">Instructor</th>
                                        <th class="py-3 border-bottom-0">Completion Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td class="ps-4 fw-semibold text-dark border-light"><%# Eval("Title") %></td>
                            <td class="border-light"><span class="badge bg-secondary px-2 py-1 rounded-pill"><%# Eval("Category") %></span></td>
                            <td class="text-muted border-light"><%# Eval("Instructor") %></td>
                            <td class="text-success fw-medium border-light">
                                <i class="fas fa-check-circle me-1"></i>
                                <%# Convert.ToDateTime(Eval("CompletedAt")).ToString("dd MMM yyyy, hh:mm tt") %>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                                </tbody>
                            </table>
                        </div>
                    </FooterTemplate>
                </asp:Repeater>

                <asp:Panel ID="pnlNoProgress" runat="server" CssClass="text-center text-muted w-100 d-block py-5 bg-light" Visible="false">
                    <i class="fas fa-folder-open fs-1 text-muted opacity-50 mb-3"></i>
                    <h5 class="mb-1 fw-semibold text-dark">No modules completed yet</h5>
                    <p class="mb-0">Head over to the course catalog to start learning.</p>
                </asp:Panel>
            </div>
        </div>

        <h4 class="fw-bold mb-3"><i class="fas fa-clipboard-check text-primary me-2"></i> Assessment Results</h4>
        <div class="card shadow-sm border-0 rounded-4 overflow-hidden">
            <div class="card-body p-0">
                <asp:Repeater ID="rptQuizProgress" runat="server">
                    <HeaderTemplate>
                        <div class="table-responsive">
                            <table class="table table-hover mb-0 align-middle border-bottom-0">
                                <thead class="table-light">
                                    <tr>
                                        <th class="ps-4 py-3 border-bottom-0">Assessment Title</th>
                                        <th class="py-3 border-bottom-0">Category</th>
                                        <th class="py-3 border-bottom-0">Score Achieved</th>
                                    </tr>
                                </thead>
                                <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td class="ps-4 fw-semibold text-dark border-light"><%# Eval("Title") %></td>
                            <td class="border-light"><span class="badge bg-secondary px-2 py-1 rounded-pill"><%# Eval("Category") %></span></td>
                            <td class="fw-bold text-primary border-light">
                                <%# Eval("Score") %> / <%# Eval("TotalQuestions") %>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                                </tbody>
                            </table>
                        </div>
                    </FooterTemplate>
                </asp:Repeater>

                <asp:Panel ID="pnlNoQuizProgress" runat="server" CssClass="text-center text-muted w-100 d-block py-5 bg-light" Visible="false">
                    <i class="fas fa-tasks fs-1 text-muted opacity-50 mb-3"></i>
                    <h5 class="mb-1 fw-semibold text-dark">No assessments taken yet</h5>
                    <p class="mb-0">Test your knowledge by completing a module assessment.</p>
                </asp:Panel>
            </div>
        </div>

    </div>

    <style>
        .icon-circle {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .progress-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .progress-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 .5rem 1.5rem rgba(0,0,0,.15)!important;
        }
    </style>
</asp:Content>