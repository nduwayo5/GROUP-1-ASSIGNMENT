<%@ include file="layout/header.jsp" %>
<div class="card" style="max-width: 450px; margin: 50px auto;">
    <h2>Create an Account</h2>
    <c:if test="${error != null}">
        <p style="color:#dc2626; background:#fef2f2; padding:10px; border-radius:4px;">${error}</p>
    </c:if>
    <form action="/register" method="post">
        <label style="font-weight:500;">Username (Email Address)</label>
        <input type="email" name="username" required placeholder="user@example.com" />
        
        <label style="font-weight:500;">Password</label>
        <input type="password" name="password" required placeholder="Create a secure password" />
        
        <label style="font-weight:500;">Full Name</label>
        <input type="text" name="fullName" required placeholder="John Doe" />
        
        <label style="font-weight:500;">Select Your Role</label>
        <select name="role">
            <option value="RESPONDENT">Respondent (Student Participant)</option>
            <option value="TEACHER">Course Teacher</option>
            <option value="INITIATOR">Survey Initiator</option>
        </select>
        
        <div style="font-size:0.85em; color:#64748b; margin-bottom: 20px;">
            * Note: If you register as a <strong>Teacher</strong>, your account will require Administrator approval before you can access your dashboard.
        </div>
        
        <button type="submit" class="btn btn-success" style="width:100%;">Complete Registration</button>
    </form>
</div>
<%@ include file="layout/footer.jsp" %>
