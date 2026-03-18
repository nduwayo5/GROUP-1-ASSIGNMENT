<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../layout/header.jsp" %>
<div class="card">
    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:30px; border-bottom:1px solid #e2e8f0; padding-bottom:15px;">
        <div>
            <h2 style="margin:0;">Analysis: ${survey.title}</h2>
            <p style="color:#64748b; margin:5px 0 0 0;">Review raw submission data</p>
        </div>
        <a href="/initiator/dashboard" class="btn" style="background:#64748b;">Back to Dashboard</a>
    </div>

    <div style="display:flex; gap:20px; margin-bottom:30px;">
        <div style="background:#f0fdf4; border:1px solid #bbf7d0; padding:20px; border-radius:8px; flex:1; text-align:center;">
            <p style="margin:0; color:#166534; font-weight:600; font-size:1.1em;">Total Submissions</p>
            <h1 style="margin:10px 0 0 0; color:#15803d; font-size:3em;">${responses.size()}</h1>
        </div>
        <div style="background:#f8fafc; border:1px solid #e2e8f0; padding:20px; border-radius:8px; flex:2;">
            <h3 style="margin-top:0;">Access Details</h3>
            <ul style="color:#475569; padding-left:20px;">
               <li><strong>Authentication Rule:</strong> ${survey.requiresAuth ? 'Strict Login Mode' : 'Guest Allow Mode'}</li>
               <li><strong>Course Connected:</strong> ${survey.course.name} (${survey.course.code})</li>
               <li><strong>Question Count:</strong> ${survey.questions.size()}</li>
            </ul>
        </div>
    </div>

    <h3 style="margin-bottom:15px;">Detailed Respondent Submissions</h3>
    <div>
        <c:forEach var="response" items="${responses}" varStatus="status">
            <div style="background:#fff; padding:20px; border-radius:8px; margin-bottom:20px; border:2px solid #f1f5f9; box-shadow:0 2px 5px rgba(0,0,0,0.02);">
                <div style="display:flex; justify-content:space-between; border-bottom:1px solid #f1f5f9; padding-bottom:10px; margin-bottom:15px;">
                    <h4 style="margin:0; color:#1e3a8a;">Submission #${status.index + 1}</h4>
                    <span style="font-size:0.9em; color:#64748b; font-weight:500;">
                        Participant: <strong style="color:#0f172a;">${response.respondent != null ? response.respondent.fullName : response.guestEmail}</strong>
                        | Timestamp: ${response.submittedAt}
                    </span>
                </div>
                <ul style="margin:0; padding-left:0; list-style:none; display:flex; flex-direction:column; gap:12px;">
                    <c:forEach var="answer" items="${response.answers}">
                        <li style="background:#f8fafc; padding:10px 15px; border-radius:6px; border-left:4px solid #3b82f6;">
                            <strong style="display:block; margin-bottom:5px; color:#475569;">${answer.question.text}</strong>
                            <span style="color:#1e40af; font-weight:600; font-size:1.1em;">${answer.selectedOption.text}</span>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </c:forEach>
        <c:if test="${empty responses}">
            <div style="text-align:center; padding:40px; color:#94a3b8; border:1px solid #e2e8f0; border-radius:8px; background:#f8fafc;">
                <span style="font-size:3em;">&#128196;</span>
                <p style="font-size:1.2em; font-weight:500;">Awaiting first participant submission.</p>
            </div>
        </c:if>
    </div>
</div>
<%@ include file="../layout/footer.jsp" %>
