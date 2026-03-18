<%@ Page Title="Course Quiz" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Quiz.aspx.cs" Inherits="Assignment.Quiz" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4 mb-5">
        
        <div class="row mb-4">
            <div class="col-12">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-1">
                        <li class="breadcrumb-item"><a href="HomePage.aspx" class="text-decoration-none">Home</a></li>
                        <li class="breadcrumb-item"><a href="QuizList.aspx" class="text-decoration-none">Quizzes</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Take Quiz</li>
                    </ol>
                </nav>
                <h2 class="text-primary fw-bold">📝 Knowledge Check</h2>
                <p class="text-muted">Test your understanding of <asp:Label ID="lblCourseName" runat="server" CssClass="fw-bold"></asp:Label>.</p>
            </div>
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="alert d-block" Visible="false"></asp:Label>

        <div class="row" id="quizContainer" runat="server">
            <div class="col-md-8 mx-auto">
                <div class="card shadow-sm border-0 border-top border-primary border-4">
                    <div class="card-body p-4 p-md-5">
                        
                        <asp:Repeater ID="rptQuestions" runat="server">
                            <ItemTemplate>
                                <div class="mb-5 question-block">
                                    <h5 class="fw-bold mb-3"><%# Container.ItemIndex + 1 %>. <%# Eval("QuestionText") %></h5>
                                    
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="radio" name='q_<%# Eval("QuestionID") %>' id='q_<%# Eval("QuestionID") %>_A' value="A" required>
                                        <label class="form-check-label" for='q_<%# Eval("QuestionID") %>_A'><%# Eval("OptionA") %></label>
                                    </div>
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="radio" name='q_<%# Eval("QuestionID") %>' id='q_<%# Eval("QuestionID") %>_B' value="B">
                                        <label class="form-check-label" for='q_<%# Eval("QuestionID") %>_B'><%# Eval("OptionB") %></label>
                                    </div>
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="radio" name='q_<%# Eval("QuestionID") %>' id='q_<%# Eval("QuestionID") %>_C' value="C">
                                        <label class="form-check-label" for='q_<%# Eval("QuestionID") %>_C'><%# Eval("OptionC") %></label>
                                    </div>
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="radio" name='q_<%# Eval("QuestionID") %>' id='q_<%# Eval("QuestionID") %>_D' value="D">
                                        <label class="form-check-label" for='q_<%# Eval("QuestionID") %>_D'><%# Eval("OptionD") %></label>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>

                        <div class="d-grid mt-4">
                            <asp:Button ID="btnSubmitQuiz" runat="server" Text="Submit Answers" CssClass="btn btn-primary btn-lg" OnClick="btnSubmitQuiz_Click" />
                        </div>

                    </div>
                </div>
            </div>
        </div>

    </div>
</asp:Content>