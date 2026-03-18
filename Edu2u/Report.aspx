<%@ Page Title="System Reports" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="Assignment.Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4 mb-5">
        
        <div class="row mb-4 align-items-center">
            <div class="col-md-8">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-1">
                        <li class="breadcrumb-item"><a href="AdminDashboard.aspx" class="text-decoration-none">Dashboard</a></li>
                        <li class="breadcrumb-item active" aria-current="page">System Reports</li>
                    </ol>
                </nav>
                <h2 class="text-secondary fw-bold mb-0">📊 System Usage Reports</h2>
                <p class="text-muted mt-1">Real-time statistics and analytics for the Edu2U platform.</p>
            </div>
            <div class="col-md-4 text-md-end mt-3 mt-md-0">
                <button type="button" class="btn btn-outline-secondary" onclick="window.print()">🖨️ Print Report</button>
            </div>
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="alert d-block" Visible="false"></asp:Label>

        <div class="card shadow-sm border-0 mb-4 border-top-primary">
            <div class="card-header bg-white fw-bold py-3">
                🏆 Course Popularity & Completion Rates
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <asp:GridView ID="gvCourseReport" runat="server" CssClass="table table-hover table-striped mb-0 align-middle" 
                        AutoGenerateColumns="False" GridLines="None">
                        <HeaderStyle CssClass="table-light" />
                        <Columns>
                            <asp:BoundField DataField="Title" HeaderText="Course Title" ItemStyle-CssClass="fw-bold ps-4" HeaderStyle-CssClass="ps-4" />
                            <asp:BoundField DataField="Category" HeaderText="Category" />
                            <asp:BoundField DataField="Instructor" HeaderText="Instructor" />
                            <asp:TemplateField HeaderText="Total Completions">
                                <ItemTemplate>
                                    <span class="badge bg-success fs-6"><%# Eval("TotalCompletions") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>

        <div class="card shadow-sm border-0 border-top-info">
            <div class="card-header bg-white fw-bold py-3">
                🆕 Recent User Registrations (Top 10)
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <asp:GridView ID="gvRecentUsers" runat="server" CssClass="table table-hover mb-0 align-middle" 
                        AutoGenerateColumns="False" GridLines="None">
                        <HeaderStyle CssClass="table-light" />
                        <Columns>
                            <asp:BoundField DataField="Username" HeaderText="Username" ItemStyle-CssClass="fw-bold ps-4" HeaderStyle-CssClass="ps-4" />
                            <asp:BoundField DataField="FullName" HeaderText="Full Name" />
                            <asp:TemplateField HeaderText="Role">
                                <ItemTemplate>
                                    <span class="badge bg-secondary"><%# Eval("Role") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="CreatedAt" HeaderText="Registration Date" DataFormatString="{0:dd MMM yyyy, hh:mm tt}" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>

    </div>

    <style>
        .border-top-primary { border-top: 4px solid #0d6efd !important; }
        .border-top-info { border-top: 4px solid #0dcaf0 !important; }
        
        /* Hide buttons and breadcrumbs when printing the report */
        @media print {
            .navbar, .breadcrumb, button, .footer { display: none !important; }
            .card { border: 1px solid #ddd !important; box-shadow: none !important; }
        }
    </style>
</asp:Content>