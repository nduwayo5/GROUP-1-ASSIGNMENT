<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../layout/header.jsp" %>
<div class="card">
    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:30px; border-bottom:1px solid #e2e8f0; padding-bottom:15px;">
        <div>
            <h2 style="margin:0;">Survey Results: ${survey.title}</h2>
            <p style="color:#64748b; margin:5px 0 0 0;">Course: ${survey.course.name}</p>
        </div>
        <a href="/teacher/dashboard" class="btn" style="background:#64748b;">Back to Dashboard</a>
    </div>

    <div style="background:#f0fdf4; border:1px solid #bbf7d0; padding:20px; border-radius:8px; display:inline-block; margin-bottom:30px;">
        <p style="margin:0; color:#166534; font-weight:600;">Total Student Responses</p>
        <h1 style="margin:5px 0 0 0; color:#15803d; font-size:2.5em;">${responses.size()}</h1>
    </div>

    <h3 style="margin-bottom:15px;">Participant Feedback</h3>
    <div>
        <c:forEach var="response" items="${responses}" varStatus="status">
            <div style="background:#fff; padding:20px; border-radius:8px; margin-bottom:20px; border:1px solid #e2e8f0; box-shadow:0 2px 4px rgba(0,0,0,0.02);">
                <h4 style="margin:0 0 15px 0; color:#1e3a8a; border-bottom:1px solid #f1f5f9; padding-bottom:10px;">Submission #${status.index + 1}</h4>
                <ul style="margin:0; padding-left:0; list-style:none; display:flex; flex-direction:column; gap:12px;">
                    <c:forEach var="answer" items="${response.answers}">
                        <li style="background:#f8fafc; padding:12px 15px; border-radius:6px; border-left:4px solid #10b981;">
                            <strong style="display:block; margin-bottom:5px; color:#475569;">${answer.question.text}</strong>
                            <span style="color:#0f172a; font-weight:500; font-size:1.05em;">${answer.selectedOption.text}</span>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </c:forEach>
        <c:if test="${empty responses}">
            <p style="color:#64748b; padding:20px; background:#f8fafc; border-radius:8px; text-align:center;">No feedback available yet.</p>
        </c:if>
    </div>
</div>
<%@ include file="../layout/footer.jsp" %>
