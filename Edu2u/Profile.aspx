<%@ Page Title="My Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Assignment.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4 mb-5">
        
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb bg-transparent p-0 mb-4">
                <li class="breadcrumb-item"><a href="HomePage.aspx" class="text-decoration-none">Home</a></li>
                <li class="breadcrumb-item active fw-semibold" aria-current="page">My Profile</li>
            </ol>
        </nav>

        <div class="d-flex align-items-center mb-5">
            <div class="icon-circle bg-warning bg-opacity-10 text-warning me-3" style="width: 60px; height: 60px; border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                <i class="fas fa-user-shield fs-3"></i>
            </div>
            <div>
                <h2 class="fw-bold mb-1">Account Settings</h2>
                <p class="text-muted mb-0">Manage your personal information and account security.</p>
            </div>
        </div>

        <div class="row g-4">
            
            <div class="col-md-6">
                <div class="card shadow-sm border-0 rounded-4 h-100 profile-card">
                    <div class="card-header bg-white border-bottom fw-bold py-3 d-flex align-items-center text-dark border-0 pt-4 px-4">
                        <i class="fas fa-id-card text-primary fs-5 me-2"></i>
                        Personal Details
                    </div>
                    <div class="card-body p-4 d-flex flex-column">
                        <asp:Label ID="lblProfileMessage" runat="server" CssClass="alert d-block rounded-3" Visible="false"></asp:Label>

                        <div class="mb-3">
                            <label class="form-label text-muted small fw-semibold">Username <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control bg-light text-muted" ReadOnly="true" ToolTip="Usernames cannot be changed."></asp:TextBox>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Full Name</label>
                            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName" 
                                ErrorMessage="Full Name is required." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="ProfileGroup"></asp:RequiredFieldValidator>
                        </div>

                        <div class="mb-4 flex-grow-1">
                            <label class="form-label fw-semibold">Email Address</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                                ErrorMessage="Email is required." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="ProfileGroup"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                                ErrorMessage="Please enter a valid email address." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="ProfileGroup"
                                ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"></asp:RegularExpressionValidator>
                        </div>

                        <asp:Button ID="btnUpdateProfile" runat="server" Text="Save Profile Changes" CssClass="btn btn-primary w-100 fw-bold mt-auto py-2 rounded-3" OnClick="btnUpdateProfile_Click" ValidationGroup="ProfileGroup" />
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="card shadow-sm border-0 rounded-4 h-100 profile-card">
                    <div class="card-header bg-white border-bottom fw-bold py-3 d-flex align-items-center text-dark border-0 pt-4 px-4">
                        <i class="fas fa-lock text-danger fs-5 me-2"></i>
                        Change Password
                    </div>
                    <div class="card-body p-4 d-flex flex-column">
                        <asp:Label ID="lblPasswordMessage" runat="server" CssClass="alert d-block rounded-3" Visible="false"></asp:Label>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Current Password</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtCurrentPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                <button class="btn btn-outline-secondary toggle-password" type="button">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                            <asp:RequiredFieldValidator ID="rfvCurrent" runat="server" ControlToValidate="txtCurrentPassword" 
                                ErrorMessage="Current password required." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="PasswordGroup"></asp:RequiredFieldValidator>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">New Password</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                <button class="btn btn-outline-secondary toggle-password" type="button">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                            <asp:RequiredFieldValidator ID="rfvNew" runat="server" ControlToValidate="txtNewPassword" 
                                ErrorMessage="New password required." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="PasswordGroup"></asp:RequiredFieldValidator>
                        </div>

                        <div class="mb-4 flex-grow-1">
                            <label class="form-label fw-semibold">Confirm New Password</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                <button class="btn btn-outline-secondary toggle-password" type="button">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                            <asp:RequiredFieldValidator ID="rfvConfirm" runat="server" ControlToValidate="txtConfirmPassword" 
                                ErrorMessage="Please confirm your new password." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="PasswordGroup"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="cvPassword" runat="server" ControlToValidate="txtConfirmPassword" ControlToCompare="txtNewPassword"
                                ErrorMessage="Passwords do not match." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="PasswordGroup"></asp:CompareValidator>
                        </div>

                        <asp:Button ID="btnChangePassword" runat="server" Text="Update Password" CssClass="btn btn-outline-danger w-100 fw-bold mt-auto py-2 rounded-3" OnClick="btnChangePassword_Click" ValidationGroup="PasswordGroup" />
                    </div>
                </div>
            </div>

        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const toggleButtons = document.querySelectorAll('.toggle-password');
            
            toggleButtons.forEach(button => {
                button.addEventListener('click', function () {
                    // Target the text box directly before this button in the input group
                    const input = this.previousElementSibling;
                    const icon = this.querySelector('i');
                    
                    if (input.type === 'password') {
                        input.type = 'text';
                        icon.classList.remove('fa-eye');
                        icon.classList.add('fa-eye-slash');
                    } else {
                        input.type = 'password';
                        icon.classList.remove('fa-eye-slash');
                        icon.classList.add('fa-eye');
                    }
                });
            });
        });
    </script>

    <style>
        .profile-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .profile-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 .5rem 1.5rem rgba(0,0,0,.10)!important;
        }
        
        /* Ensures the eye icon button aligns perfectly with the input */
        .toggle-password {
            border-color: #ced4da;
            background-color: #f8f9fa;
        }
        
        .toggle-password:hover {
            background-color: #e2e6ea;
            border-color: #dae0e5;
            color: #495057;
        }
    </style>
</asp:Content>