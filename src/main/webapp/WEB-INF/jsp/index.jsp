<%@ include file="layout/header.jsp" %>
<div class="card" style="text-align: center; margin-top: 60px; padding: 60px 20px;">
    <h1 style="font-size: 2.5rem; margin-bottom: 10px;">Welcome to CoursePulse</h1>
    <p style="font-size: 1.2rem; color: #475569; max-width: 600px; margin: 0 auto 30px auto;">A reliable and modern system for collecting, managing, and analyzing course evaluations.</p>
    <div>
        <sec:authorize access="!isAuthenticated()">
            <a href="/login" class="btn" style="margin: 0 10px;">Login Here</a>
            <a href="/register" class="btn btn-success" style="margin: 0 10px;">Create an Account</a>
            <a href="/guest/surveys" class="btn" style="background:#64748b; margin: 0 10px;">Take a Public Survey</a>
        </sec:authorize>
        <sec:authorize access="isAuthenticated()">
            <a href="/dashboard" class="btn btn-success">Go to Dashboard</a>
        </sec:authorize>
    </div>
</div>
<%@ include file="layout/footer.jsp" %>
