<%@ Page Title="User Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserManagement.aspx.cs" Inherits="Assignment.UserManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        
        <div class="row mb-4 align-items-center">
            <div class="col-md-8">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-1">
                        <li class="breadcrumb-item"><a href="AdminDashboard.aspx" class="text-decoration-none">Dashboard</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Manage Users</li>
                    </ol>
                </nav>
                <h2 class="text-danger fw-bold mb-0">👥 User Management</h2>
            </div>
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="alert d-block" Visible="false"></asp:Label>

        <div class="card shadow-sm border-0">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <asp:GridView ID="gvUsers" runat="server" CssClass="table table-hover mb-0 align-middle" 
                        AutoGenerateColumns="False" DataKeyNames="UserID"
                        OnRowEditing="gvUsers_RowEditing" 
                        OnRowCancelingEdit="gvUsers_RowCancelingEdit" 
                        OnRowUpdating="gvUsers_RowUpdating"
                        OnRowCommand="gvUsers_RowCommand">
                        
                        <HeaderStyle CssClass="table-light" />
                        
                        <Columns>
                            <asp:BoundField DataField="UserID" HeaderText="ID" ReadOnly="True" ItemStyle-CssClass="fw-bold ps-4" HeaderStyle-CssClass="ps-4" />
                            <asp:BoundField DataField="Username" HeaderText="Username" ReadOnly="True" />
                            
                            <asp:BoundField DataField="FullName" HeaderText="Full Name" />
                            <asp:BoundField DataField="Email" HeaderText="Email" />
                            
                            <asp:TemplateField HeaderText="Role">
                                <ItemTemplate>
                                    <span class="badge bg-secondary"><%# Eval("Role") %></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlRoleEdit" runat="server" CssClass="form-select form-select-sm" SelectedValue='<%# Bind("Role") %>'>
                                        <asp:ListItem Value="Student">Student</asp:ListItem>
                                        <asp:ListItem Value="Educator">Educator</asp:ListItem>
                                        <asp:ListItem Value="Administrator">Administrator</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class='<%# Convert.ToBoolean(Eval("IsActive")) ? "badge bg-success" : "badge bg-danger" %>'>
                                        <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Disabled" %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:CommandField ShowEditButton="True" ControlStyle-CssClass="btn btn-sm btn-outline-primary" />
                            
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button ID="btnToggleStatus" runat="server" 
                                        CommandName="ToggleStatus" 
                                        CommandArgument='<%# Container.DataItemIndex %>' 
                                        Text='<%# Convert.ToBoolean(Eval("IsActive")) ? "Disable" : "Enable" %>' 
                                        CssClass='<%# Convert.ToBoolean(Eval("IsActive")) ? "btn btn-sm btn-outline-danger" : "btn btn-sm btn-outline-success" %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>

    </div>
</asp:Content>