<%@ Page Title="My Progress" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Progress.aspx.cs" Inherits="Assignment.Progress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4 mb-5">
        
        <div class="row mb-4">
            <div class="col-12">
                <h2 class="text-success fw-bold d-flex align-items-center">
                    <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" class="bi bi-graph-up-arrow me-2" viewBox="0 0 16 16">
                      <path fill-rule="evenodd" d="M0 0h1v15h15v1H0zm10 3.5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-1 0V4.9l-3.613 4.417a.5.5 0 0 1-.74.037L7.06 6.767l-3.656 5.027a.5.5 0 0 1-.808-.588l4-5.5a.5.5 0 0 1 .758-.06l2.609 2.61L13.445 4H10.5a.5.5 0 0 1-.5-.5"/>
                    </svg>
                    My Learning Progress
                </h2>
                <p class="text-muted mt-1">Track your achievements and review the courses you have completed.</p>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-md-5 col-lg-4">
                <div class="card text-white shadow-sm border-0 rounded-3" style="background: linear-gradient(135deg, #198754 0%, #146c43 100%);">
                    <div class="card-body text-center py-4">
                        <h1 class="display-3 fw-bold mb-0">
                            <asp:Label ID="lblTotalCompleted" runat="server" Text="0"></asp:Label>
                        </h1>
                        <h5 class="mt-2 mb-0 fw-light opacity-75">Total Courses Completed</h5>
                    </div>
                </div>
            </div>
        </div>

        <div class="card shadow-sm border-0 rounded-3 overflow-hidden">
            <div class="card-header bg-white fw-bold py-3 d-flex align-items-center border-bottom">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-award text-warning me-2" viewBox="0 0 16 16">
                  <path d="M9.669.864 8 0 6.331.864l-1.858.282-.842 1.68-1.337 1.32L2.6 6l-.306 1.854 1.337 1.32.842 1.68 1.858.282L8 12l1.669-.864 1.858-.282.842-1.68 1.337-1.32L13.4 6l.306-1.854-1.337-1.32-.842-1.68zm1.196 1.193.684 1.365 1.086 1.072L12.387 6l.248 1.506-1.086 1.072-.684 1.365-1.51.229L8 10.874l-1.355-.702-1.51-.229-.684-1.365-1.086-1.072L3.614 6l-.25-1.506 1.087-1.072.684-1.365 1.51-.229L8 1.126l1.356.702z"/>
                  <path d="M4 11.794V16l4-1 4 1v-4.206l-2.018.306L8 13.126 6.018 12.1z"/>
                </svg>
                Completion History
            </div>
            <div class="card-body p-0">
                
                <asp:Repeater ID="rptProgress" runat="server">
                    <HeaderTemplate>
                        <div class="table-responsive">
                            <table class="table table-hover mb-0 align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th class="ps-4 py-3">Course Title</th>
                                        <th class="py-3">Category</th>
                                        <th class="py-3">Instructor</th>
                                        <th class="py-3">Completion Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td class="ps-4 fw-semibold text-dark"><%# Eval("Title") %></td>
                            <td><span class="badge bg-secondary px-2 py-1"><%# Eval("Category") %></span></td>
                            <td class="text-muted"><%# Eval("Instructor") %></td>
                            <td class="text-success fw-medium">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-check-circle-fill me-1 mb-1" viewBox="0 0 16 16">
                                  <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
                                </svg>
                                <%# Convert.ToDateTime(Eval("CompletedAt")).ToString("dd MMM yyyy, hh:mm tt") %>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                                </tbody>
                            </table>
                        </div>
                    </FooterTemplate>
                </asp:Repeater>

                <asp:Panel ID="pnlNoProgress" runat="server" CssClass="text-center text-muted w-100 d-block py-5 bg-light" Visible="false">
                    <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" fill="currentColor" class="bi bi-journal-x mb-3 text-secondary opacity-50" viewBox="0 0 16 16">
                      <path fill-rule="evenodd" d="M6.146 6.146a.5.5 0 0 1 .708 0L8 7.293l1.146-1.147a.5.5 0 1 1 .708.708L8.707 8l1.147 1.146a.5.5 0 0 1-.708.708L8 8.707 6.854 9.854a.5.5 0 0 1-.708-.708L7.293 8 6.146 6.854a.5.5 0 0 1 0-.708z"/>
                      <path d="M3 0h10a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-1h1v1a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1v1H1V2a2 2 0 0 1 2-2z"/>
                      <path d="M1 5v-.5a.5.5 0 0 1 1 0V5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0V8h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0v.5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1z"/>
                    </svg>
                    <h4 class="mb-3 fw-semibold text-dark">You haven't completed any courses yet!</h4>
                    <a href="CourseList.aspx" class="btn btn-primary px-4">Browse Courses</a>
                </asp:Panel>

            </div>
        </div>

    </div>
</asp:Content>