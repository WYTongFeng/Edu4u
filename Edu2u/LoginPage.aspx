<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="Assignment.LoginPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5 col-xl-4">
                <div class="card border-0 shadow-lg rounded-4 overflow-hidden mt-5">
                    
                    <div class="card-header bg-primary text-white text-center py-4 border-0">
                        <h4 class="mb-0 fw-bold">Welcome Back</h4>
                        <p class="mb-0 small text-white-50">Sign in to continue to Edu2U</p>
                    </div>

                    <div class="card-body p-4 p-md-5 bg-white">
                        <asp:Label ID="lblMessage" runat="server" CssClass="alert d-block rounded-3 mb-4" Visible="false"></asp:Label>

                        <div class="mb-3">
                            <label class="form-label fw-medium text-dark small" for="txtUsername">Username</label>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control bg-light py-2" placeholder="Enter your username"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername" ErrorMessage="Username is required." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="LoginGroup"></asp:RequiredFieldValidator>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-medium text-dark small" for="txtPassword">Password</label>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control bg-light py-2" TextMode="Password" placeholder="••••••••"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="LoginGroup"></asp:RequiredFieldValidator>
                        </div>

                        <div class="form-check mb-4">
                            <input class="form-check-input shadow-none" type="checkbox" id="chkShowPassword" onclick="togglePasswordVisibility()">
                            <label class="form-check-label text-muted small" for="chkShowPassword">Show Password</label>
                        </div>

                        <asp:Button ID="btnLogin" runat="server" Text="Log In" CssClass="btn btn-primary w-100 py-2 fw-bold mb-3 shadow-sm" OnClick="btnLogin_Click" ValidationGroup="LoginGroup" />
                    </div>
                    
                    <div class="card-footer bg-light text-center py-3 border-0">
                        <span class="text-muted small">Don't have an account yet?</span> <a href="Register.aspx" class="text-primary fw-semibold small text-decoration-none">Register here</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        // Toggle Password Visibility
        function togglePasswordVisibility() {
            var passField = document.getElementById('<%= txtPassword.ClientID %>');
            
            if (passField) {
                if (passField.type === "password") {
                    passField.type = "text";
                } else {
                    passField.type = "password";
                }
            }
        }
    </script>
</asp:Content>