<%@ Page Title="Upload Content" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UploadContent.aspx.cs" Inherits="Assignment.UploadContent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4 mb-5">
        
        <div class="row mb-4 align-items-center">
            <div class="col-md-8">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-1">
                        <li class="breadcrumb-item"><a href="Dashboard.aspx" class="text-decoration-none">Dashboard</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Upload Material</li>
                    </ol>
                </nav>
                <h2 class="text-info fw-bold mb-0">📤 Upload Learning Material</h2>
                <p class="text-muted mt-1">Create a new course and upload your PDF resources for students.</p>
            </div>
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="alert d-block" Visible="false"></asp:Label>

        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card shadow-sm border-0 border-top border-info border-4">
                    <div class="card-body p-4 p-md-5">
                        
                        <div class="mb-4 text-center">
                            <div class="display-1 text-info mb-3">📄</div>
                            <h4>Course Details</h4>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Course Title</label>
                            <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control form-control-lg" placeholder="e.g. Introduction to Programming"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ControlToValidate="txtTitle" ErrorMessage="A course title is required" CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Category</label>
                            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select form-select-lg">
                                <asp:ListItem Value="">-- Select a Category --</asp:ListItem>
                                <asp:ListItem Value="Programming">Programming</asp:ListItem>
                                <asp:ListItem Value="Security">Cyber Security</asp:ListItem>
                                <asp:ListItem Value="Data Science">Data Science</asp:ListItem>
                                <asp:ListItem Value="Networking">Networking</asp:ListItem>
                                <asp:ListItem Value="General Computing">General Computing</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="ddlCategory" ErrorMessage="Please select a category" CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold">Course Description</label>
                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" placeholder="Briefly describe what students will learn..."></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvDesc" runat="server" ControlToValidate="txtDescription" ErrorMessage="A description is required" CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <hr class="my-4" />

                        <div class="mb-4 bg-light p-4 rounded text-center border border-dashed">
                            <label class="form-label fw-bold d-block mb-3">Upload PDF Material</label>
                            <asp:FileUpload ID="fileUploadMaterial" runat="server" CssClass="form-control mb-2" accept=".pdf" />
                            <small class="text-muted d-block mt-2">Only .PDF files are supported. Ensure your file is not password protected.</small>
                            <asp:RequiredFieldValidator ID="rfvFile" runat="server" ControlToValidate="fileUploadMaterial" ErrorMessage="You must upload a learning material" CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <div class="d-grid mt-5">
                            <asp:Button ID="btnUpload" runat="server" Text="Publish Course" CssClass="btn btn-info btn-lg text-white fw-bold" OnClick="btnUpload_Click" />
                        </div>

                    </div>
                </div>
            </div>
        </div>

    </div>

    <style>
        .border-dashed { border-style: dashed !important; border-width: 2px !important; border-color: #ccc !important; }
    </style>
</asp:Content>