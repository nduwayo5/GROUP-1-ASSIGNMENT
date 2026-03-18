<%@ include file="layout/header.jsp" %>
<div class="card" style="max-width: 400px; margin: 60px auto;">
    <h2>Login Account</h2>
    <c:if test="${param.error != null}">
        <p style="color:#dc2626; background:#fef2f2; padding:10px; border-radius:4px;">Invalid username or password, or account pending approval.</p>
    </c:if>
    <c:if test="${param.logout != null}">
        <p style="color:#166534; background:#f0fdf4; padding:10px; border-radius:4px;">You have been logged out successfully.</p>
    </c:if>
    <c:if test="${param.registered != null}">
        <p style="color:#1d4ed8; background:#eff6ff; padding:10px; border-radius:4px;">Registration successful! You can now login.</p>
    </c:if>
    <form action="/login" method="post">
        <label style="font-weight:500;">Username (Email)</label>
        <input type="text" name="username" required placeholder="Enter your email" />
        
        <label style="font-weight:500;">Password</label>
        <input type="password" name="password" required placeholder="Enter password" />
        
        <button type="submit" class="btn" style="width:100%; margin-top: 10px;">Secure Login</button>
    </form>
</div>
<%@ include file="layout/footer.jsp" %>
