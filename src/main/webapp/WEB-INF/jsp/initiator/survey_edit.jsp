<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../layout/header.jsp" %>
<div class="card">
    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom: 25px;">
        <div>
            <h2 style="margin:0;">Edit Survey Wizard: <span style="color:#1d4ed8;">${survey.title}</span></h2>
            <p style="color:#64748b; margin:5px 0 0 0;">Add questions and options for this evaluation.</p>
        </div>
        <a href="/initiator/dashboard" class="btn" style="background:#10b981; font-weight:bold; font-size:1.1em;">&#10003; Done Editing</a>
    </div>
    
    <div style="background:#eff6ff; padding:25px; border-radius:10px; margin-bottom:35px; border:2px dashed #bfdbfe;">
        <h3 style="margin-top:0; color:#1e3a8a;">Add New Question</h3>
        <form action="/initiator/survey/${survey.id}/question" method="post" style="display:flex; gap:15px; align-items:center; margin:0;">
            <input type="text" name="text" required placeholder="Type your question text here (e.g. How would you rate the instructor?)" style="margin:0; flex:1; font-size:1.1em;" />
            <button type="submit" class="btn btn-success" style="padding:12px 25px; font-size:1.1em;">+ Add Question</button>
        </form>
    </div>

    <h3 style="border-bottom:2px solid #f1f5f9; padding-bottom:10px;">Generated Questions Sequence</h3>
    <c:forEach var="question" items="${survey.questions}" varStatus="status">
        <div style="border:1px solid #e2e8f0; padding:20px; border-radius:10px; margin-bottom:20px; box-shadow:0 2px 4px rgba(0,0,0,0.02);">
            <h4 style="margin:0 0 15px 0; font-size:1.2em; color:#0f172a;">Q${status.index + 1}: ${question.text}</h4>
            
            <div style="margin-bottom:15px;">
                <c:choose>
                    <c:when test="${not empty question.options}">
                        <ul style="padding-left:0; list-style:none; margin:0; display:flex; flex-direction:column; gap:8px;">
                            <c:forEach var="option" items="${question.options}">
                                <li style="background:#f8fafc; padding:10px 15px; border-radius:6px; border:1px solid #cbd5e1; display:flex; align-items:center;">
                                    <span style="display:inline-block; width:16px; height:16px; border-radius:50%; border:2px solid #94a3b8; margin-right:10px;"></span>
                                    ${option.text}
                                </li>
                            </c:forEach>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <p style="color:#ef4444; font-weight:500; font-style:italic;">&uarr; This question currently has no options available for respondents!</p>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <form action="/initiator/question/${question.id}/option" method="post" style="display:flex; gap:10px; align-items:center; background:#f1f5f9; padding:10px; border-radius:6px; margin:0;">
                <input type="hidden" name="surveyId" value="${survey.id}" />
                <span style="font-weight:600; color:#475569; font-size:0.9em; text-transform:uppercase;">Add Option:</span>
                <input type="text" name="text" required placeholder="e.g. Strongly Agree" style="margin:0; max-width:350px; padding:8px;" />
                <button type="submit" class="btn" style="background:#64748b; padding:8px 16px;">Insert</button>
            </form>
        </div>
    </c:forEach>
    <c:if test="${empty survey.questions}">
        <div style="text-align:center; padding:40px; color:#94a3b8; border:2px dashed #cbd5e1; border-radius:10px;">
            <h2 style="margin:0; font-weight:400;">No questions designed yet.</h2>
            <p>Use the blue area above to start crafting your survey.</p>
        </div>
    </c:if>
</div>
<%@ include file="../layout/footer.jsp" %>
