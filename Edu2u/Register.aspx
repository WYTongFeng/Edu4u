<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Assignment.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6 col-xl-5">
                <div class="card border-0 shadow-lg rounded-4 overflow-hidden">
                    
                    <div class="card-header bg-primary text-white text-center py-4 border-0">
                        <h4 class="mb-0 fw-bold">Join Edu2U</h4>
                        <p class="mb-0 small text-white-50">Create your account to start learning</p>
                    </div>

                    <div class="card-body p-4 p-md-5 bg-white">
                        <asp:Label ID="lblMessage" runat="server" CssClass="alert d-block rounded-3 mb-4" Visible="false"></asp:Label>

                        <div class="mb-3">
                            <label class="form-label fw-medium text-dark small" for="txtFullName">Full Name <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control bg-light" placeholder="e.g. John Doe"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName" ErrorMessage="Full Name is required." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="RegisterGroup"></asp:RequiredFieldValidator>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-medium text-dark small" for="txtEmail">Email Address <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control bg-light" TextMode="Email" placeholder="e.g. john@example.com"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="RegisterGroup"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Please enter a valid email address." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="RegisterGroup" ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"></asp:RegularExpressionValidator>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-medium text-dark small" for="txtUsername">Username <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control bg-light" placeholder="Choose a unique username"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername" ErrorMessage="Username is required." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="RegisterGroup"></asp:RequiredFieldValidator>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-medium text-dark small" for="txtPassword">Password <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control bg-light" TextMode="Password" placeholder="••••••••"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Required." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="RegisterGroup"></asp:RequiredFieldValidator>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-medium text-dark small" for="txtConfirmPassword">Confirm <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control bg-light" TextMode="Password" placeholder="••••••••"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" ErrorMessage="Required." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="RegisterGroup"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvPassword" runat="server" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword" ErrorMessage="Passwords do not match." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="RegisterGroup"></asp:CompareValidator>
                            </div>
                        </div>

                        <div class="form-check mb-4">
                            <input class="form-check-input shadow-none" type="checkbox" id="chkShowPassword" onclick="togglePasswordVisibility()">
                            <label class="form-check-label text-muted small" for="chkShowPassword">Show Passwords</label>
                        </div>

                        <div class="mb-4 p-3 border rounded-3 bg-light">
                            <label class="form-label fw-medium text-dark small" for="ddlRole">Account Type <span class="text-danger">*</span></label>
                            <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-select border-primary" onchange="toggleEducatorCode()">
                                <asp:ListItem Value="Student">Student Account</asp:ListItem>
                                <asp:ListItem Value="Educator">Educator Account</asp:ListItem>
                            </asp:DropDownList>
                            
                            <div id="educatorCodeDiv" style="display: none;" class="mt-3">
                                <label class="form-label fw-medium text-danger small">Educator Access Code <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtAccessCode" runat="server" CssClass="form-control border-danger" placeholder="Enter IT Department Code"></asp:TextBox>
                                <small class="text-muted d-block mt-1">Required to verify teacher identity.</small>
                            </div>
                        </div>

                        <asp:Button ID="btnRegister" runat="server" Text="Create Account" CssClass="btn btn-primary w-100 py-2 fw-bold mb-3 shadow-sm" OnClick="btnRegister_Click" ValidationGroup="RegisterGroup" />
                    </div>
                    
                    <div class="card-footer bg-light text-center py-3 border-0">
                        <span class="text-muted small">Already registered?</span> <a href="LoginPage.aspx" class="text-primary fw-semibold small text-decoration-none">Sign in here</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

<script type="text/javascript">
        // Toggle the Educator Access Code field
        function toggleEducatorCode() {
            var ddl = document.getElementById('<%= ddlRole.ClientID %>');
            var codeDiv = document.getElementById('educatorCodeDiv');
            
            if (ddl && ddl.value === 'Educator') {
                codeDiv.style.display = 'block';
            } else {
                if (codeDiv) codeDiv.style.display = 'none';
                
                // Clear the code if they switch back to student
                var accessCodeField = document.getElementById('<%= txtAccessCode.ClientID %>');
                if (accessCodeField) {
                    accessCodeField.value = '';
                }
            }
        }

        // Toggle Password Visibility
        function togglePasswordVisibility() {
            var passField = document.getElementById('<%= txtPassword.ClientID %>');
            var confirmField = document.getElementById('<%= txtConfirmPassword.ClientID %>');
            
            if (passField && confirmField) {
                if (passField.type === "password") {
                    passField.type = "text";
                    confirmField.type = "text";
                } else {
                    passField.type = "password";
                    confirmField.type = "password";
                }
            }
        }

        // Ensure proper display on page load if validation fails and reloads
        window.onload = function () {
            toggleEducatorCode();
        };
</script>
</asp:Content>