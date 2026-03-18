<%@ Page Title="System Reports" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="Assignment.Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4 mb-5">
        
        <nav aria-label="breadcrumb" class="d-print-none">
            <ol class="breadcrumb bg-transparent p-0 mb-4">
                <li class="breadcrumb-item"><a href="AdminDashboard.aspx" class="text-decoration-none">Dashboard</a></li>
                <li class="breadcrumb-item active fw-semibold" aria-current="page">System Reports</li>
            </ol>
        </nav>

        <div class="d-flex align-items-center justify-content-between mb-4">
            <div class="d-flex align-items-center">
                <div class="icon-circle bg-warning bg-opacity-10 text-warning me-3 d-print-none" style="width: 60px; height: 60px; border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                    <i class="fas fa-chart-pie fs-3"></i>
                </div>
                <div>
                    <h2 class="fw-bold mb-1">System Analytics</h2>
                    <p class="text-muted mb-0 d-print-none">Generate and view reports on platform usage and user activity.</p>
                </div>
            </div>
            
            <button type="button" class="btn btn-outline-secondary fw-bold px-4 py-2 rounded-pill shadow-sm d-print-none" onclick="window.print()">
                <i class="fas fa-print me-2"></i> Print Report
            </button>
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="alert d-block rounded-3 shadow-sm mb-4 d-print-none" Visible="false"></asp:Label>

        <div class="row g-4">
            
            <div class="col-lg-12">
                <div class="card shadow-sm border-0 rounded-4 mb-2">
                    <div class="card-header bg-white border-bottom border-0 pt-4 px-4 pb-3 fw-bold text-dark d-flex align-items-center">
                        <i class="fas fa-book-open text-primary me-2"></i> Course Interaction & Popularity
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <asp:GridView ID="gvCourseReport" runat="server" CssClass="table table-hover align-middle mb-0 border-bottom-0" 
                                AutoGenerateColumns="False" GridLines="None">
                                <HeaderStyle CssClass="table-light text-muted small fw-semibold text-uppercase" />
                                <Columns>
                                    <asp:BoundField DataField="Title" HeaderText="Course Title" ItemStyle-CssClass="fw-semibold text-dark ps-4 border-light" HeaderStyle-CssClass="ps-4 py-3 border-bottom-0" />
                                    <asp:TemplateField HeaderText="Category" ItemStyle-CssClass="border-light" HeaderStyle-CssClass="py-3 border-bottom-0">
                                        <ItemTemplate>
                                            <span class="badge bg-secondary rounded-pill px-2 py-1"><%# Eval("Category") %></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Instructor" HeaderText="Instructor" ItemStyle-CssClass="text-secondary border-light" HeaderStyle-CssClass="py-3 border-bottom-0" />
                                    <asp:BoundField DataField="TotalCompletions" HeaderText="Total Interactions" ItemStyle-CssClass="fw-bold text-primary border-light" HeaderStyle-CssClass="py-3 border-bottom-0" />
                                </Columns>
                                <EmptyDataTemplate>
                                    <div class="text-center py-5 text-muted">
                                        <i class="fas fa-chart-bar fs-1 opacity-50 mb-3"></i>
                                        <h5 class="fw-semibold text-dark">No course data</h5>
                                        <p class="mb-0">There is not enough data to generate this report yet.</p>
                                    </div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-12">
                <div class="card shadow-sm border-0 rounded-4 mb-2">
                    <div class="card-header bg-white border-bottom border-0 pt-4 px-4 pb-3 fw-bold text-dark d-flex align-items-center">
                        <i class="fas fa-check-double text-success me-2"></i> Student Quiz Performance
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <asp:GridView ID="gvQuizResults" runat="server" CssClass="table table-hover align-middle mb-0 border-bottom-0" 
                                AutoGenerateColumns="False" GridLines="None">
                                <HeaderStyle CssClass="table-light text-muted small fw-semibold text-uppercase" />
                                <Columns>
                                    <asp:BoundField DataField="StudentName" HeaderText="Student" ItemStyle-CssClass="fw-semibold text-dark ps-4 border-light" HeaderStyle-CssClass="ps-4 py-3 border-bottom-0" />
                                    <asp:BoundField DataField="QuizTitle" HeaderText="Quiz Title" ItemStyle-CssClass="text-secondary border-light" HeaderStyle-CssClass="py-3 border-bottom-0" />
                                    <asp:TemplateField HeaderText="Score" ItemStyle-CssClass="border-light" HeaderStyle-CssClass="py-3 border-bottom-0">
                                        <ItemTemplate>
                                            <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 rounded-pill px-3 py-1"><%# Eval("Score") %></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="AttemptDate" HeaderText="Attempted On" DataFormatString="{0:dd MMM yyyy, hh:mm tt}" ItemStyle-CssClass="text-muted small border-light" HeaderStyle-CssClass="py-3 border-bottom-0" />
                                </Columns>
                                <EmptyDataTemplate>
                                    <div class="text-center py-5 text-muted">
                                        <i class="fas fa-clipboard-list fs-1 opacity-50 mb-3"></i>
                                        <h5 class="fw-semibold text-dark">No quiz results found</h5>
                                        <p class="mb-0">Students haven't completed any quizzes yet.</p>
                                    </div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-12">
                <div class="card shadow-sm border-0 rounded-4">
                    <div class="card-header bg-white border-bottom border-0 pt-4 px-4 pb-3 fw-bold text-dark d-flex align-items-center">
                        <i class="fas fa-user-clock text-info me-2"></i> Recently Registered Users
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <asp:GridView ID="gvRecentUsers" runat="server" CssClass="table table-hover align-middle mb-0 border-bottom-0" 
                                AutoGenerateColumns="False" GridLines="None">
                                <HeaderStyle CssClass="table-light text-muted small fw-semibold text-uppercase" />
                                <Columns>
                                    <asp:BoundField DataField="Username" HeaderText="Username" ItemStyle-CssClass="fw-semibold text-dark ps-4 border-light" HeaderStyle-CssClass="ps-4 py-3 border-bottom-0" />
                                    <asp:BoundField DataField="FullName" HeaderText="Full Name" ItemStyle-CssClass="text-secondary border-light" HeaderStyle-CssClass="py-3 border-bottom-0" />
                                    <asp:TemplateField HeaderText="Role" ItemStyle-CssClass="border-light" HeaderStyle-CssClass="py-3 border-bottom-0">
                                        <ItemTemplate>
                                            <span class="badge bg-secondary rounded-pill px-2 py-1"><%# Eval("Role") %></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="CreatedAt" HeaderText="Registration Date" DataFormatString="{0:dd MMM yyyy, hh:mm tt}" ItemStyle-CssClass="text-muted small border-light" HeaderStyle-CssClass="py-3 border-bottom-0" />
                                </Columns>
                                <EmptyDataTemplate>
                                    <div class="text-center py-5 text-muted">
                                        <i class="fas fa-users fs-1 opacity-50 mb-3"></i>
                                        <h5 class="fw-semibold text-dark">No user data</h5>
                                        <p class="mb-0">There are no recently registered users.</p>
                                    </div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <style>
        @media print {
            body { background-color: #fff; }
            .d-print-none { display: none !important; }
            .card { border: 1px solid #ddd !important; box-shadow: none !important; margin-bottom: 2rem; }
            .card-header { background-color: #f8f9fa !important; border-bottom: 1px solid #ddd !important; }
            .badge { border: 1px solid #6c757d; color: #000 !important; background-color: transparent !important; }
        }
    </style>
</asp:Content>