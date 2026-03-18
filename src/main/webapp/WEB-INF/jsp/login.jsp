<%@ include file="layout/header.jsp" %>
<div class="card" style="max-width: 420px; margin: 80px auto;">
    <div style="text-align: center; margin-bottom: 30px;">
        <h2 style="margin-bottom: 8px;">Welcome Back</h2>
        <p style="color: #64748b; font-size: 0.95rem;">Please enter your credentials to access your account</p>
    </div>
    
    <c:if test="${param.error != null}">
        <div style="color:#b91c1c; background:#fee2e2; padding:12px 16px; border-radius:10px; margin-bottom: 20px; font-size: 0.9rem; border: 1px solid #fecaca;">
            Invalid username or password, or account pending approval.
        </div>
    </c:if>
    <c:if test="${param.logout != null}">
        <div style="color:#15803d; background:#dcfce7; padding:12px 16px; border-radius:10px; margin-bottom: 20px; font-size: 0.9rem; border: 1px solid #bbf7d0;">
            You have been logged out successfully.
        </div>
    </c:if>
    <c:if test="${param.registered != null}">
        <div style="color:#1d4ed8; background:#dbeafe; padding:12px 16px; border-radius:10px; margin-bottom: 20px; font-size: 0.9rem; border: 1px solid #bfdbfe;">
            Registration successful! You can now login.
        </div>
    </c:if>

    <form action="/login" method="post">
        <div style="margin-bottom: 20px;">
            <label style="font-weight:600; font-size: 0.85rem; color: #475569; text-transform: uppercase; letter-spacing: 0.025em;">Username (Email)</label>
            <input type="text" name="username" required placeholder="name@example.com" />
        </div>
        
        <div style="margin-bottom: 10px;">
            <label style="font-weight:600; font-size: 0.85rem; color: #475569; text-transform: uppercase; letter-spacing: 0.025em;">Password</label>
            <input type="password" name="password" required placeholder="••••••••" />
        </div>
        
        <button type="submit" class="btn" style="width:100%; margin-top: 20px; padding: 14px;">Secure Login</button>
    </form>
    
    <div style="text-align: center; margin-top: 30px; font-size: 0.9rem; color: #64748b;">
        Don't have an account? <a href="/register" style="color: #3b82f6; text-decoration: none; font-weight: 600;">Sign up now</a>
    </div>
</div>

<%@ include file="layout/footer.jsp" %>
