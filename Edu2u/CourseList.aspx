<%@ Page Title="Course Catalog" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CourseList.aspx.cs" Inherits="Assignment.CourseList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <style>
        .course-card {
            transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
        }
        .course-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important;
        }
        /* Ensures long course descriptions truncate gracefully instead of breaking the card height */
        .line-clamp-3 {
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;  
            overflow: hidden;
        }
    </style>

    <div class="container mt-4 mb-5">
        
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb bg-transparent p-0 mb-4">
                <li class="breadcrumb-item"><a href="HomePage.aspx" class="text-decoration-none">Home</a></li>
                <li class="breadcrumb-item active fw-semibold" aria-current="page">Course Catalog</li>
            </ol>
        </nav>
        
        <div class="row mb-4 align-items-center g-3">
            <div class="col-md-7 col-lg-8">
                <h2 class="text-primary fw-bold mb-0">Browse Learning Materials</h2>
                <p class="text-muted mt-1 mb-0">Discover courses tailored for your success at Edu2U.</p>
            </div>
            
            <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" CssClass="col-md-5 col-lg-4">
                <div class="input-group shadow-sm">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control border-primary" placeholder="Search courses..."></asp:TextBox>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary px-4" OnClick="btnSearch_Click" />
                </div>
            </asp:Panel>
        </div>

        <div class="row g-4">
            
            <asp:Repeater ID="rptCourses" runat="server">
                <ItemTemplate>
                    <div class="col-md-6 col-lg-4">
                        <div class="card h-100 shadow-sm border-0 course-card">
                            
                            <div class="bg-primary bg-opacity-10 text-center py-5 rounded-top">
                                <svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" fill="currentColor" class="text-primary opacity-75" viewBox="0 0 16 16">
                                  <path d="M1 2.828c.885-.37 2.154-.769 3.388-.893 1.33-.134 2.458.156 3.112.76.416.384.6.868.7 1.398h.02c.1-.53.284-1.014.7-1.398.654-.604 1.782-.894 3.112-.76 1.234.124 2.503.523 3.388.893V14.2c-.885-.37-2.154-.769-3.388-.893-1.33-.134-2.458.156-3.112.76-.416.384-.6.868-.7 1.398h-.02c-.1-.53-.284-1.014-.7-1.398-.654-.604-1.782-.894-3.112-.76-1.234.124-2.503.523-3.388.893V2.828zM8 4.5a.5.5 0 0 0 .5.5c1.25-.125 2.65-.5 3.96-1.05V12.1c-1.2-.55-2.5-1-3.6-1.15a.5.5 0 0 0-.86 0c-1.1.15-2.4.6-3.6 1.15V3.95c1.31.55 2.71.925 3.96 1.05a.5.5 0 0 0 .5-.5z"/>
                                </svg>
                            </div>

                            <div class="card-body d-flex flex-column p-4">
                                <span class="badge bg-secondary mb-3 align-self-start"><%# Eval("Category") %></span>
                                <h5 class="card-title fw-bold text-dark"><%# Eval("Title") %></h5>
                                
                                <p class="card-text text-muted small flex-grow-1 line-clamp-3"><%# Eval("Description") %></p>
                                
                                <div class="mt-4 border-top pt-3 d-flex justify-content-between align-items-center">
                                    <small class="text-muted text-truncate pe-2">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle me-1 mb-1 text-secondary" viewBox="0 0 16 16">
                                          <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
                                          <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
                                        </svg>
                                        <%# Eval("Instructor") %>
                                    </small>
                                    
                                    <a href='CourseDetails.aspx?id=<%# Eval("CourseID") %>' class="btn btn-sm btn-primary flex-shrink-0">Start Learning</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

        </div>

        <asp:Label ID="lblNoCourses" runat="server" CssClass="d-block text-center mt-5 p-5 bg-white shadow-sm rounded-3 border" Visible="false">
            <h4 class="text-muted fw-bold mb-2">No courses found</h4>
            <p class="text-muted mb-0">Try adjusting your search or check back later!</p>
        </asp:Label>

    </div>
</asp:Content>