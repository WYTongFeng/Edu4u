<%@ Page Title="Course Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CourseManagement.aspx.cs" Inherits="Assignment.CourseManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        
        <div class="row mb-4 align-items-center">
            <div class="col-md-8">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-1">
                        <li class="breadcrumb-item"><a href="AdminDashboard.aspx" class="text-decoration-none">Dashboard</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Manage Courses</li>
                    </ol>
                </nav>
                <h2 class="text-success fw-bold mb-0">📚 Course Management</h2>
            </div>
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="alert d-block" Visible="false"></asp:Label>

        <div class="card shadow-sm border-0 mb-5 border-left-success">
            <div class="card-header bg-white fw-bold py-3">
                ➕ Add New Course
            </div>
            <div class="card-body p-4">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Course Title</label>
                        <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="e.g. Advanced Networking"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ControlToValidate="txtTitle" ErrorMessage="Title required" CssClass="text-danger small" ValidationGroup="AddCourse"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Category</label>
                        <asp:TextBox ID="txtCategory" runat="server" CssClass="form-control" placeholder="e.g. Security"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="txtCategory" ErrorMessage="Category required" CssClass="text-danger small" ValidationGroup="AddCourse"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Instructor</label>
                        <asp:TextBox ID="txtInstructor" runat="server" CssClass="form-control" placeholder="e.g. Dr. Smith"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvInstructor" runat="server" ControlToValidate="txtInstructor" ErrorMessage="Instructor required" CssClass="text-danger small" ValidationGroup="AddCourse"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-8">
                        <label class="form-label">Description</label>
                        <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" placeholder="Course overview..."></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvDesc" runat="server" ControlToValidate="txtDescription" ErrorMessage="Description required" CssClass="text-danger small" ValidationGroup="AddCourse"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Learning Material (PDF)</label>
                        <asp:FileUpload ID="fileUploadMaterial" runat="server" CssClass="form-control" accept=".pdf" />
                        <small class="text-muted">Optional: Upload a PDF document.</small>
                    </div>
                    <div class="col-12 mt-3">
                        <asp:Button ID="btnAddCourse" runat="server" Text="Save New Course" CssClass="btn btn-success" OnClick="btnAddCourse_Click" ValidationGroup="AddCourse" />
                    </div>
                </div>
            </div>
        </div>

        <div class="card shadow-sm border-0">
            <div class="card-header bg-white fw-bold py-3">
                📋 Existing Courses
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <asp:GridView ID="gvCourses" runat="server" CssClass="table table-hover mb-0 align-middle" 
                        AutoGenerateColumns="False" DataKeyNames="CourseID"
                        OnRowEditing="gvCourses_RowEditing" 
                        OnRowCancelingEdit="gvCourses_RowCancelingEdit" 
                        OnRowUpdating="gvCourses_RowUpdating"
                        OnRowDeleting="gvCourses_RowDeleting">
                        
                        <HeaderStyle CssClass="table-light" />
                        
                        <Columns>
                            <asp:BoundField DataField="CourseID" HeaderText="ID" ReadOnly="True" ItemStyle-CssClass="fw-bold ps-4" HeaderStyle-CssClass="ps-4" />
                            <asp:BoundField DataField="Title" HeaderText="Course Title" />
                            <asp:BoundField DataField="Category" HeaderText="Category" />
                            <asp:BoundField DataField="Instructor" HeaderText="Instructor" />
                            
                            <asp:TemplateField HeaderText="Material">
                                <ItemTemplate>
                                    <span class='<%# string.IsNullOrEmpty(Eval("ContentPath")?.ToString()) ? "text-danger" : "text-success" %>'>
                                        <%# string.IsNullOrEmpty(Eval("ContentPath")?.ToString()) ? "No File" : "PDF Attached" %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:CommandField ShowEditButton="True" ControlStyle-CssClass="btn btn-sm btn-outline-primary" />
                            <asp:CommandField ShowDeleteButton="True" ControlStyle-CssClass="btn btn-sm btn-outline-danger" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>

    </div>
</asp:Content>