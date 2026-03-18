<%@ Page Title="Educator Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Assignment.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4 mb-5">
        
        <div class="row mb-4">
            <div class="col-12">
                <div class="p-4 bg-info bg-opacity-10 rounded-3 border-start border-info border-4 shadow-sm">
                    <h2 class="text-info fw-bold">Educator Dashboard 👨‍🏫</h2>
                    <p class="fs-5 text-muted mb-0">Welcome back, <asp:Label ID="lblEducatorName" runat="server" CssClass="fw-bold"></asp:Label>! Here is an overview of your teaching activities.</p>
                </div>
            </div>
        </div>

        <div class="row g-4 mb-5">
            <div class="col-md-6">
                <div class="card bg-white shadow-sm border-0 h-100 border-bottom border-primary border-3">
                    <div class="card-body text-center py-4">
                        <h1 class="display-4 fw-bold text-primary"><asp:Label ID="lblMyCoursesCount" runat="server" Text="0"></asp:Label></h1>
                        <h5 class="text-muted mb-0">My Active Courses</h5>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="card bg-white shadow-sm border-0 h-100 border-bottom border-success border-3">
                    <div class="card-body text-center py-4">
                        <h1 class="display-4 fw-bold text-success"><asp:Label ID="lblStudentCompletions" runat="server" Text="0"></asp:Label></h1>
                        <h5 class="text-muted mb-0">Total Student Completions</h5>
                    </div>
                </div>
            </div>
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="alert d-block" Visible="false"></asp:Label>

        <div class="card shadow-sm border-0 mb-4">
            <div class="card-header bg-white d-flex justify-content-between align-items-center py-3">
                <span class="fw-bold">📚 My Uploaded Materials</span>
                <a href="UploadContent.aspx" class="btn btn-sm btn-info text-white fw-bold">+ Upload New Material</a>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <asp:GridView ID="gvMyCourses" runat="server" CssClass="table table-hover mb-0 align-middle" 
                        AutoGenerateColumns="False" GridLines="None">
                        <HeaderStyle CssClass="table-light" />
                        <Columns>
                            <asp:BoundField DataField="Title" HeaderText="Course Title" ItemStyle-CssClass="fw-bold ps-4" HeaderStyle-CssClass="ps-4" />
                            <asp:BoundField DataField="Category" HeaderText="Category" />
                            <asp:TemplateField HeaderText="Material Status">
                                <ItemTemplate>
                                    <span class='<%# string.IsNullOrEmpty(Eval("ContentPath")?.ToString()) ? "badge bg-danger" : "badge bg-success" %>'>
                                        <%# string.IsNullOrEmpty(Eval("ContentPath")?.ToString()) ? "No PDF Uploaded" : "Material Active" %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="CreatedAt" HeaderText="Created On" DataFormatString="{0:dd MMM yyyy}" />
                        </Columns>
                    </asp:GridView>

                    <asp:Label ID="lblNoCourses" runat="server" CssClass="text-center text-muted w-100 d-block py-5" Visible="false">
                        <h5 class="mb-3">You haven't created any courses yet.</h5>
                        <p>Click the 'Upload New Material' button above to get started!</p>
                    </asp:Label>
                </div>
            </div>
        </div>

    </div>
</asp:Content>