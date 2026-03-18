<%@ Page Title="My Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Assignment.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4 mb-5">
        
        <div class="row mb-4">
            <div class="col-12">
                <h2 class="text-primary fw-bold d-flex align-items-center">
                    <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" class="bi bi-person-circle me-2" viewBox="0 0 16 16">
                      <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
                      <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
                    </svg>
                    My Profile
                </h2>
                <p class="text-muted mt-1">Manage your personal information and account security.</p>
            </div>
        </div>

        <div class="row g-4">
            
            <div class="col-md-6">
                <div class="card shadow-sm border-0 rounded-3 h-100">
                    <div class="card-header bg-white border-bottom fw-bold py-3 d-flex align-items-center text-dark">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-person-vcard text-primary me-2" viewBox="0 0 16 16">
                          <path d="M5 8a2 2 0 1 0 0-4 2 2 0 0 0 0 4Zm4-2.5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1h-4a.5.5 0 0 1-.5-.5ZM9 8a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1h-4A.5.5 0 0 1 9 8Zm1 2.5a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 0 1h-3a.5.5 0 0 1-.5-.5Z"/>
                          <path d="M2 2a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V4a2 2 0 0 0-2-2H2ZM1 4a1 1 0 0 1 1-1h12a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1H8.96c.026-.163.04-.33.04-.5C9 10.567 7.21 9 5 9c-2.086 0-3.8 1.398-3.984 3.181A1.006 1.006 0 0 1 1 12V4Z"/>
                        </svg>
                        Personal Details
                    </div>
                    <div class="card-body p-4 p-xl-5 d-flex flex-column">
                        <asp:Label ID="lblProfileMessage" runat="server" CssClass="alert d-block" Visible="false"></asp:Label>

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

                        <asp:Button ID="btnUpdateProfile" runat="server" Text="Save Profile Changes" CssClass="btn btn-primary w-100 fw-bold mt-auto" OnClick="btnUpdateProfile_Click" ValidationGroup="ProfileGroup" />
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="card shadow-sm border-0 rounded-3 h-100">
                    <div class="card-header bg-white border-bottom fw-bold py-3 d-flex align-items-center text-dark">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-shield-lock text-danger me-2" viewBox="0 0 16 16">
                          <path d="M5.338 1.59a61.44 61.44 0 0 0-2.837.856.481.481 0 0 0-.328.39c-.554 4.157.726 7.19 2.253 9.188a10.725 10.725 0 0 0 2.287 2.233c.346.244.652.42.893.533.12.057.218.095.293.118a.55.55 0 0 0 .101.025.615.615 0 0 0 .1-.025c.076-.023.174-.061.294-.118.24-.113.547-.29.893-.533a10.726 10.726 0 0 0 2.287-2.233c1.527-1.997 2.807-5.031 2.253-9.188a.48.48 0 0 0-.328-.39c-.651-.213-1.75-.56-2.837-.855C9.552 1.29 8.531 1.067 8 1.067c-.53 0-1.552.223-2.662.524zM5.072.56C6.157.265 7.31 0 8 0s1.843.265 2.928.56c1.11.3 2.229.655 2.887.87a1.54 1.54 0 0 1 1.044 1.262c.596 4.477-.787 7.795-2.465 9.99a11.775 11.775 0 0 1-2.517 2.453 7.159 7.159 0 0 1-1.048.625c-.28.132-.581.24-.829.24s-.548-.108-.829-.24a7.158 7.158 0 0 1-1.048-.625 11.777 11.777 0 0 1-2.517-2.453C1.928 10.487.545 7.169 1.141 2.692A1.54 1.54 0 0 1 2.185 1.43 62.456 62.456 0 0 1 5.072.56z"/>
                          <path d="M9.5 6.5a1.5 1.5 0 0 1-1 1.415l.385 1.99a.5.5 0 0 1-.491.595h-.788a.5.5 0 0 1-.49-.595l.384-1.99a1.5 1.5 0 1 1 2-1.415z"/>
                        </svg>
                        Change Password
                    </div>
                    <div class="card-body p-4 p-xl-5 d-flex flex-column">
                        <asp:Label ID="lblPasswordMessage" runat="server" CssClass="alert d-block" Visible="false"></asp:Label>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Current Password</label>
                            <asp:TextBox ID="txtCurrentPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvCurrent" runat="server" ControlToValidate="txtCurrentPassword" 
                                ErrorMessage="Current password required." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="PasswordGroup"></asp:RequiredFieldValidator>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">New Password</label>
                            <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNew" runat="server" ControlToValidate="txtNewPassword" 
                                ErrorMessage="New password required." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="PasswordGroup"></asp:RequiredFieldValidator>
                        </div>

                        <div class="mb-4 flex-grow-1">
                            <label class="form-label fw-semibold">Confirm New Password</label>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvConfirm" runat="server" ControlToValidate="txtConfirmPassword" 
                                ErrorMessage="Please confirm your new password." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="PasswordGroup"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="cvPassword" runat="server" ControlToValidate="txtConfirmPassword" ControlToCompare="txtNewPassword"
                                ErrorMessage="Passwords do not match." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="PasswordGroup"></asp:CompareValidator>
                        </div>

                        <asp:Button ID="btnChangePassword" runat="server" Text="Update Password" CssClass="btn btn-outline-danger w-100 fw-bold mt-auto" OnClick="btnChangePassword_Click" ValidationGroup="PasswordGroup" />
                    </div>
                </div>
            </div>

        </div>
    </div>
</asp:Content>