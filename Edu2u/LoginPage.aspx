<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="Assignment.LoginPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row justify-content-center align-items-center min-vh-100 mt-n5">
        <div class="col-md-6 col-lg-5 col-xl-4">
            <div class="card shadow border-0 rounded-3 mt-5">
                <div class="card-body p-4 p-md-5">
                    <h3 class="text-center mb-4 fw-bold text-primary">Welcome Back</h3>
                    
                    <asp:Label ID="lblMessage" runat="server" CssClass="alert d-block" Visible="false"></asp:Label>

                    <div class="mb-3">
                        <label class="form-label fw-semibold" for="txtUsername">Username</label>
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter your username"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername" 
                            ErrorMessage="Username is required." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="LoginGroup"></asp:RequiredFieldValidator>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold" for="txtPassword">Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" 
                            ErrorMessage="Password is required." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="LoginGroup"></asp:RequiredFieldValidator>
                    </div>

                    <div class="mb-4 form-check">
                        <asp:CheckBox ID="chkRememberMe" runat="server" CssClass="form-check-input" />
                        <label class="form-check-label text-muted" for="MainContent_chkRememberMe">Remember me</label>
                    </div>

                    <asp:Button ID="btnLogin" runat="server" Text="Log In" CssClass="btn btn-primary w-100 py-2 fw-bold" OnClick="btnLogin_Click" ValidationGroup="LoginGroup" />
                    
                    <div class="text-center mt-4 pt-3 border-top">
                        <span class="text-muted">Don't have an account yet?</span> <a href="Register.aspx" class="text-decoration-none fw-semibold">Register here</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>