<%@ Page Title="User Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserManagement.aspx.cs" Inherits="Assignment.UserManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4 mb-5">
        
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb bg-transparent p-0 mb-4">
                <li class="breadcrumb-item"><a href="AdminDashboard.aspx" class="text-decoration-none">Dashboard</a></li>
                <li class="breadcrumb-item active fw-semibold" aria-current="page">User Management</li>
            </ol>
        </nav>

        <div class="d-flex align-items-center justify-content-between mb-4">
            <div class="d-flex align-items-center">
                <div class="icon-circle bg-primary bg-opacity-10 text-primary me-3" style="width: 60px; height: 60px; border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                    <i class="fas fa-users-cog fs-3"></i>
                </div>
                <div>
                    <h2 class="fw-bold mb-1">User Management</h2>
                    <p class="text-muted mb-0">View, edit, create, or delete users across the platform.</p>
                </div>
            </div>
            
            <button class="btn btn-primary fw-bold px-4 py-2 rounded-pill shadow-sm" type="button" data-bs-toggle="collapse" data-bs-target="#addUserForm" aria-expanded="false" aria-controls="addUserForm">
                <i class="fas fa-user-plus me-2"></i> Add New User
            </button>
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="alert d-block rounded-3 shadow-sm mb-4" Visible="false"></asp:Label>

        <div class="collapse mb-4" id="addUserForm">
            <div class="card shadow-sm border-0 rounded-4">
                <div class="card-header bg-white border-bottom border-0 pt-4 px-4 pb-0 fw-bold text-dark">
                    <i class="fas fa-user-plus text-primary me-2"></i> Create Account
                </div>
                <div class="card-body p-4">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-medium text-dark small">Full Name <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtNewFullName" runat="server" CssClass="form-control bg-light" placeholder="e.g. Jane Doe"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNewFullName" runat="server" ControlToValidate="txtNewFullName" ErrorMessage="Required." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="AddUserGroup"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-medium text-dark small">Email Address <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtNewEmail" runat="server" CssClass="form-control bg-light" TextMode="Email" placeholder="jane@example.com"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNewEmail" runat="server" ControlToValidate="txtNewEmail" ErrorMessage="Required." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="AddUserGroup"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-medium text-dark small">Username <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtNewUsername" runat="server" CssClass="form-control bg-light" placeholder="Choose a username"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNewUsername" runat="server" ControlToValidate="txtNewUsername" ErrorMessage="Required." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="AddUserGroup"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-medium text-dark small">Temporary Password <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control bg-light" placeholder="Enter temporary password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNewPassword" runat="server" ControlToValidate="txtNewPassword" ErrorMessage="Required." CssClass="text-danger small mt-1 d-block" Display="Dynamic" ValidationGroup="AddUserGroup"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-medium text-dark small">Account Role <span class="text-danger">*</span></label>
                            <asp:DropDownList ID="ddlNewRole" runat="server" CssClass="form-select border-primary">
                                <asp:ListItem Value="Student">Student</asp:ListItem>
                                <asp:ListItem Value="Educator">Educator</asp:ListItem>
                                <asp:ListItem Value="Administrator">Administrator</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="d-flex justify-content-end mt-4">
                        <asp:Button ID="btnAddUser" runat="server" Text="Create User" CssClass="btn btn-primary px-4 fw-bold rounded-pill shadow-sm" OnClick="btnAddUser_Click" ValidationGroup="AddUserGroup" />
                    </div>
                </div>
            </div>
        </div>

        <div class="card shadow-sm border-0 rounded-4">
            <div class="card-header bg-white border-bottom border-0 pt-4 px-4 pb-3 fw-bold text-dark d-flex align-items-center justify-content-between">
                <span><i class="fas fa-list text-primary me-2"></i> Registered Accounts</span>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <asp:GridView ID="gvUsers" runat="server" CssClass="table table-hover align-middle mb-0 border-bottom-0" 
                        AutoGenerateColumns="False" DataKeyNames="UserID" GridLines="None"
                        OnRowEditing="gvUsers_RowEditing" 
                        OnRowCancelingEdit="gvUsers_RowCancelingEdit" 
                        OnRowUpdating="gvUsers_RowUpdating" 
                        OnRowDeleting="gvUsers_RowDeleting">
                        
                        <HeaderStyle CssClass="table-light text-muted small fw-semibold text-uppercase" />
                        
                        <Columns>
                            <asp:BoundField DataField="UserID" HeaderText="ID" ReadOnly="True" ItemStyle-CssClass="ps-4 fw-semibold text-dark border-light" HeaderStyle-CssClass="ps-4 py-3 border-bottom-0" />
                            
                            <asp:TemplateField HeaderText="Username" ItemStyle-CssClass="text-secondary border-light" HeaderStyle-CssClass="py-3 border-bottom-0">
                                <ItemTemplate><%# Eval("Username") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEditUsername" runat="server" Text='<%# Bind("Username") %>' CssClass="form-control form-control-sm"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            
                            <asp:TemplateField HeaderText="Full Name" ItemStyle-CssClass="fw-medium text-dark border-light" HeaderStyle-CssClass="py-3 border-bottom-0">
                                <ItemTemplate><%# Eval("FullName") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEditFullName" runat="server" Text='<%# Bind("FullName") %>' CssClass="form-control form-control-sm"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Email Address" ItemStyle-CssClass="text-secondary border-light" HeaderStyle-CssClass="py-3 border-bottom-0">
                                <ItemTemplate><%# Eval("Email") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEditEmail" runat="server" Text='<%# Bind("Email") %>' CssClass="form-control form-control-sm" TextMode="Email"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Role" ItemStyle-CssClass="border-light" HeaderStyle-CssClass="py-3 border-bottom-0">
                                <ItemTemplate>
                                    <span class="badge bg-secondary rounded-pill px-2 py-1"><%# Eval("Role") %></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlEditRole" runat="server" CssClass="form-select form-select-sm" SelectedValue='<%# Bind("Role") %>'>
                                        <asp:ListItem Value="Student">Student</asp:ListItem>
                                        <asp:ListItem Value="Educator">Educator</asp:ListItem>
                                        <asp:ListItem Value="Administrator">Administrator</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-end pe-4 border-light" HeaderStyle-CssClass="text-end pe-4 py-3 border-bottom-0">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CssClass="btn btn-sm btn-outline-primary rounded-pill px-3 me-1 fw-semibold">
                                        <i class="fas fa-edit me-1"></i> Edit
                                    </asp:LinkButton>
                                    
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CssClass="btn btn-sm btn-outline-danger rounded-pill px-3 fw-semibold" OnClientClick="return confirm('Are you sure you want to permanently delete this user?');">
                                        <i class="fas fa-trash-alt me-1"></i> Delete
                                    </asp:LinkButton>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" CssClass="btn btn-sm btn-success rounded-pill px-3 me-1 fw-semibold">
                                        <i class="fas fa-save me-1"></i> Save
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" CssClass="btn btn-sm btn-secondary rounded-pill px-3 fw-semibold">
                                        <i class="fas fa-times me-1"></i> Cancel
                                    </asp:LinkButton>
                                </EditItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        
                        <EmptyDataTemplate>
                            <div class="text-center py-5 text-muted">
                                <i class="fas fa-users fs-1 opacity-50 mb-3"></i>
                                <h5 class="fw-semibold text-dark">No users found</h5>
                                <p class="mb-0">There are currently no users registered in the system.</p>
                            </div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>