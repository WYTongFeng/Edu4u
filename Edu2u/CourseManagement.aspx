<%@ Page Title="Course Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CourseManagement.aspx.cs" Inherits="Assignment.CourseManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4 mb-5">
        
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb bg-transparent p-0 mb-4">
                <li class="breadcrumb-item">
                    <a href='<%= (Session["Role"] != null && Session["Role"].ToString() == "Administrator") ? "AdminDashboard.aspx" : "Dashboard.aspx" %>' class="text-decoration-none">Dashboard</a>
                </li>
                <li class="breadcrumb-item active fw-semibold" aria-current="page">Course Management</li>
            </ol>
        </nav>

        <div class="d-flex align-items-center mb-4">
            <div class="icon-circle bg-primary bg-opacity-10 text-primary me-3" style="width: 60px; height: 60px; border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                <i class="fas fa-file-upload fs-3"></i>
            </div>
            <div>
                <h2 class="fw-bold mb-1">Manage Courses</h2>
                <p class="text-muted mb-0">Upload new learning materials or update your existing modules.</p>
            </div>
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="alert d-block rounded-3 shadow-sm" Visible="false"></asp:Label>

        <div class="row g-4">
            
            <div class="col-lg-4">
                <div class="card shadow-sm border-0 rounded-4 h-100 course-card">
                    <div class="card-header bg-white border-bottom border-0 pt-4 px-4 pb-3 fw-bold text-dark d-flex align-items-center">
                        <i class="fas fa-plus-circle text-primary me-2"></i> Add New Course
                    </div>
                    <div class="card-body p-4 d-flex flex-column">
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-muted small">Course Title <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control bg-light border-0" placeholder="e.g. Intro to Data Structures"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ControlToValidate="txtTitle" ErrorMessage="Title is required." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="UploadGroup"></asp:RequiredFieldValidator>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-muted small">Instructor Name <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtInstructor" runat="server" CssClass="form-control bg-light border-0" placeholder="e.g. Dr. Lai Ngan Kuen"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvInstructor" runat="server" ControlToValidate="txtInstructor" ErrorMessage="Instructor name is required." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="UploadGroup"></asp:RequiredFieldValidator>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold text-muted small">Category <span class="text-danger">*</span></label>
                            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select bg-light border-0">
                                <asp:ListItem Text="-- Select Category --" Value="" />
                                <asp:ListItem Text="Computer Science" Value="Computer Science" />
                                <asp:ListItem Text="Cybersecurity" Value="Cybersecurity" />
                                <asp:ListItem Text="Software Engineering" Value="Software Engineering" />
                                <asp:ListItem Text="Networking & Security" Value="Networking & Security" />
                                <asp:ListItem Text="UI/UX Design" Value="UI/UX Design" />
                                <asp:ListItem Text="Data Structures & Algorithms" Value="Data Structures & Algorithms" />
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="ddlCategory" InitialValue="" ErrorMessage="Please select a category." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="UploadGroup"></asp:RequiredFieldValidator>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold text-muted small">Course Description</label>
                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control bg-light border-0" TextMode="MultiLine" Rows="4" placeholder="Briefly describe the module..."></asp:TextBox>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold text-muted small">Upload Material (PDF) <span class="text-danger">*</span></label>
                            <asp:FileUpload ID="fileUpload" runat="server" CssClass="form-control border-primary" accept=".pdf" />
                            <asp:RequiredFieldValidator ID="rfvFile" runat="server" ControlToValidate="fileUpload" ErrorMessage="A file is required." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="UploadGroup"></asp:RequiredFieldValidator>
                        </div>

                        <asp:Button ID="btnUpload" runat="server" Text="Upload Course" CssClass="btn btn-primary w-100 fw-bold py-2 rounded-3 mt-auto shadow-sm" OnClick="btnUpload_Click" ValidationGroup="UploadGroup" />
                    </div>
                </div>
            </div>

            <div class="col-lg-8">
                <div class="card shadow-sm border-0 rounded-4 h-100 course-card">
                    <div class="card-header bg-white border-bottom border-0 pt-4 px-4 pb-3 fw-bold text-dark d-flex align-items-center">
                        <i class="fas fa-list text-primary me-2"></i> My Uploaded Courses
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <asp:GridView ID="gvCourses" runat="server" AutoGenerateColumns="False" 
                                CssClass="table table-hover align-middle mb-0 border-bottom-0" 
                                GridLines="None" DataKeyNames="CourseID" 
                                OnRowDeleting="gvCourses_RowDeleting">
                                <HeaderStyle CssClass="table-light text-muted small fw-semibold text-uppercase" />
                                <Columns>
                                    <asp:BoundField DataField="CourseID" HeaderText="ID" ItemStyle-CssClass="ps-4 fw-semibold text-dark border-light" HeaderStyle-CssClass="ps-4 py-3 border-bottom-0" />
                                    <asp:BoundField DataField="Title" HeaderText="Title" ItemStyle-CssClass="fw-semibold text-dark border-light" HeaderStyle-CssClass="py-3 border-bottom-0" />
                                    <asp:TemplateField HeaderText="Category" ItemStyle-CssClass="border-light" HeaderStyle-CssClass="py-3 border-bottom-0">
                                        <ItemTemplate>
                                            <span class="badge bg-secondary rounded-pill px-2 py-1"><%# Eval("Category") %></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-end pe-4 border-light" HeaderStyle-CssClass="text-end pe-4 py-3 border-bottom-0">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CssClass="btn btn-sm btn-outline-danger rounded-pill px-3 fw-semibold" OnClientClick="return confirm('Are you sure you want to delete this course?');">
                                                <i class="fas fa-trash-alt me-1"></i> Delete
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    <div class="text-center py-5 text-muted">
                                        <i class="fas fa-folder-open fs-1 opacity-50 mb-3"></i>
                                        <h5 class="fw-semibold text-dark">No courses found</h5>
                                        <p class="mb-0">You haven't uploaded any courses yet.</p>
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
        .course-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .course-card:hover {
            box-shadow: 0 .5rem 1.5rem rgba(0,0,0,.10)!important;
        }
    </style>
</asp:Content>