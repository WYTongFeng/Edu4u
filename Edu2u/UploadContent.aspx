<%@ Page Title="Add Quiz Question" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UploadContent.aspx.cs" Inherits="Assignment.UploadContent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-4">
        
        <div class="row mb-4">
            <div class="col-md-12">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-2">
                        <li class="breadcrumb-item">
                            <a href='<%= (Session["Role"] != null && Session["Role"].ToString() == "Administrator") ? "AdminDashboard.aspx" : "Dashboard.aspx" %>' class="text-decoration-none">Dashboard</a>
                        </li>
                        <li class="breadcrumb-item active" aria-current="page">Quiz Management</li>
                    </ol>
                </nav>
                <h3 class="fw-semibold text-dark mb-1">Add Quiz Question</h3>
                <p class="text-secondary mb-0">Create multiple-choice questions for your courses.</p>
            </div>
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="alert d-block rounded-3 mb-4" Visible="false"></asp:Label>

        <div class="row">
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm rounded-3">
                    <div class="card-header bg-white border-bottom-0 pt-4 pb-0 px-4">
                        <h5 class="fw-semibold text-dark mb-0">Question Details</h5>
                    </div>
                    <div class="card-body p-4">
                        
                        <div class="row mb-4">
                            <div class="col-md-12">
                                <label class="form-label fw-medium text-dark small">Select Course <span class="text-danger">*</span></label>
                                <asp:DropDownList ID="ddlCourse" runat="server" CssClass="form-select">
                                    <asp:ListItem Value="">-- Select a Course --</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvCourse" runat="server" ControlToValidate="ddlCourse" ErrorMessage="Please select a course." CssClass="text-danger small mt-1 d-block" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="row mb-4">
                            <div class="col-md-12">
                                <label class="form-label fw-medium text-dark small">Question Text <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtQuestion" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Enter the question here..."></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvQuestion" runat="server" ControlToValidate="txtQuestion" ErrorMessage="Question text is required." CssClass="text-danger small mt-1 d-block" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="bg-light p-4 rounded-3 border mb-4">
                            <h6 class="fw-semibold text-dark mb-3">Answers</h6>
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-medium text-dark small">Option A <span class="text-danger">*</span></label>
                                    <asp:TextBox ID="txtOptionA" runat="server" CssClass="form-control" placeholder="Option A"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvOptA" runat="server" ControlToValidate="txtOptionA" ErrorMessage="Required" CssClass="text-danger small mt-1 d-block" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                                
                                <div class="col-md-6">
                                    <label class="form-label fw-medium text-dark small">Option B <span class="text-danger">*</span></label>
                                    <asp:TextBox ID="txtOptionB" runat="server" CssClass="form-control" placeholder="Option B"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvOptB" runat="server" ControlToValidate="txtOptionB" ErrorMessage="Required" CssClass="text-danger small mt-1 d-block" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-medium text-dark small">Option C <span class="text-danger">*</span></label>
                                    <asp:TextBox ID="txtOptionC" runat="server" CssClass="form-control" placeholder="Option C"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvOptC" runat="server" ControlToValidate="txtOptionC" ErrorMessage="Required" CssClass="text-danger small mt-1 d-block" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-medium text-dark small">Option D <span class="text-danger">*</span></label>
                                    <asp:TextBox ID="txtOptionD" runat="server" CssClass="form-control" placeholder="Option D"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvOptD" runat="server" ControlToValidate="txtOptionD" ErrorMessage="Required" CssClass="text-danger small mt-1 d-block" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <hr class="my-3" />

                            <div class="row">
                                <div class="col-md-6">
                                    <label class="form-label fw-medium text-dark small">Correct Option <span class="text-danger">*</span></label>
                                    <asp:DropDownList ID="ddlCorrectOption" runat="server" CssClass="form-select border-primary">
                                        <asp:ListItem Value="">-- Select Correct Answer --</asp:ListItem>
                                        <asp:ListItem Value="A">Option A</asp:ListItem>
                                        <asp:ListItem Value="B">Option B</asp:ListItem>
                                        <asp:ListItem Value="C">Option C</asp:ListItem>
                                        <asp:ListItem Value="D">Option D</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvCorrect" runat="server" ControlToValidate="ddlCorrectOption" ErrorMessage="Select the correct option." CssClass="text-danger small mt-1 d-block" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end">
                            <asp:Button ID="btnSaveQuestion" runat="server" Text="Save Question" CssClass="btn btn-primary px-4 py-2 fw-medium" OnClick="btnSaveQuestion_Click" />
                        </div>

                    </div>
                </div>
            </div>
            
            <div class="col-lg-4 d-none d-lg-block">
                <div class="card border-0 shadow-sm rounded-3 bg-light">
                    <div class="card-body p-4">
                        <h6 class="fw-semibold text-dark border-bottom pb-2 mb-3">Quiz Tips</h6>
                        <ul class="text-secondary small ps-3 mb-0" style="line-height: 1.8;">
                            <li>Ensure that questions are clear and unambiguous.</li>
                            <li>Make sure only one option is completely correct.</li>
                            <li>Questions will be immediately available to students taking the assigned course.</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>