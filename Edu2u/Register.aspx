<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Assignment.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row justify-content-center align-items-center min-vh-100 mt-n5">
        <div class="col-md-8 col-lg-6 col-xl-5">
            <div class="card shadow border-0 rounded-3 mt-5">
                <div class="card-body p-4 p-md-5">
                    <h3 class="text-center mb-4 fw-bold text-primary">Create an Account</h3>
                    
                    <asp:Label ID="lblMessage" runat="server" CssClass="alert d-block" Visible="false"></asp:Label>

                    <div class="mb-3">
                        <label class="form-label fw-semibold" for="txtFullName">Full Name</label>
                        <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="e.g., John Doe"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName" 
                            ErrorMessage="Full Name is required." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="RegisterGroup">
                        </asp:RequiredFieldValidator>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold" for="txtEmail">Email Address</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="e.g., john@example.com"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                            ErrorMessage="Email is required." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="RegisterGroup">
                        </asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                            ErrorMessage="Please enter a valid email address." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="RegisterGroup"
                            ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$">
                        </asp:RegularExpressionValidator>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold" for="txtUsername">Username</label>
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Choose a unique username"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername" 
                            ErrorMessage="Username is required." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="RegisterGroup">
                        </asp:RequiredFieldValidator>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold" for="txtPassword">Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" 
                            ErrorMessage="Password is required." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="RegisterGroup">
                        </asp:RequiredFieldValidator>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold" for="txtConfirmPassword">Confirm Password</label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" 
                            ErrorMessage="Please confirm your password." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="RegisterGroup">
                        </asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="cvPassword" runat="server" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword"
                            ErrorMessage="Passwords do not match." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="RegisterGroup">
                        </asp:CompareValidator>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold" for="ddlRole">Account Role</label>
                        <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-select">
                            <asp:ListItem Value="Student">Student</asp:ListItem>
                            <asp:ListItem Value="Educator">Educator</asp:ListItem>
                        </asp:DropDownList>
                        <small class="text-muted mt-1 d-block"><i class="bi bi-info-circle"></i> Administrators must be created manually by IT.</small>
                    </div>

                    <asp:Button ID="btnRegister" runat="server" Text="Sign Up" CssClass="btn btn-primary w-100 py-2 fw-bold" OnClick="btnRegister_Click" ValidationGroup="RegisterGroup" />
                    
                    <div class="text-center mt-4 pt-3 border-top">
                        <span class="text-muted">Already have an account?</span> <a href="LoginPage.aspx" class="text-decoration-none fw-semibold">Log in here</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>