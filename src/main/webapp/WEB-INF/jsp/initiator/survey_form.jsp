<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../layout/header.jsp" %>
<div class="card" style="max-width: 600px; margin: 40px auto; box-shadow: 0 20px 25px -5px rgba(0,0,0,0.1);">
    <h2 style="margin-bottom:20px; border-bottom:2px solid #e2e8f0; padding-bottom:10px;">Setup New Survey</h2>
    <form action="/initiator/survey/save" method="post">
        <label style="font-weight:600; display:block; margin-bottom:6px;">Survey Title</label>
        <input type="text" name="title" required placeholder="e.g. Midterm Course Evaluation" />
        
        <label style="font-weight:600; display:block; margin-bottom:6px;">Description / Instructions</label>
        <textarea name="description" rows="4" placeholder="Briefly describe the purpose of this survey..."></textarea>
        
        <label style="font-weight:600; display:block; margin-bottom:6px;">Link to Associated Course</label>
        <select name="courseId" required style="cursor:pointer;">
            <option value="" disabled selected>-- Select a Course --</option>
            <c:forEach var="course" items="${courses}">
                <option value="${course.id}">${course.name} (${course.code})</option>
            </c:forEach>
        </select>
        
        <div style="background:#f0f9ff; border:1px solid #bae6fd; padding:15px; border-radius:8px; margin: 25px 0;">
            <label style="display:flex; align-items:flex-start; gap: 12px; margin:0; cursor:pointer;">
                <input type="checkbox" name="requiresAuth" value="true" style="width:20px; height:20px; margin:2px 0 0 0;" />
                <div>
                    <strong style="color:#0369a1; display:block;">Require Respondent Login</strong>
                    <span style="font-size:0.85em; color:#0c4a6e;">If unchecked, anyone can participate anonymously (as a Guest) by providing an email for confirmation.</span>
                </div>
            </label>
        </div>
        
        <div style="display:flex; gap:15px; margin-top:30px;">
            <a href="/initiator/dashboard" class="btn" style="background:#94a3b8; text-align:center; padding:12px; flex:1;">Cancel</a>
            <button type="submit" class="btn btn-success" style="padding:12px; flex:2; font-size:1.1em;">Save & Build Questions</button>
        </div>
    </form>
</div>
<%@ include file="../layout/footer.jsp" %>
