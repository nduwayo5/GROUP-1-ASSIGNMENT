<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="../layout/header.jsp" %>
<div class="card" style="max-width:850px; margin:20px auto; padding:40px; box-shadow:0 10px 25px -5px rgba(0,0,0,0.1);">
    <div style="margin-bottom:35px; border-bottom:2px solid #e2e8f0; padding-bottom:25px;">
        <h2 style="margin:0 0 10px 0; font-size:2.2em; color:#1e3a8a;">${survey.title}</h2>
        <span style="background:#e0f2fe; color:#0369a1; padding:6px 12px; border-radius:20px; font-weight:600; font-size:0.9em;">
            Related Course: ${survey.course.name}
        </span>
        <c:if test="${not empty survey.description}">
            <div style="background:#f8fafc; padding:20px; border-radius:8px; color:#334155; margin-top:20px; border-left:5px solid #3b82f6; font-size:1.1em; line-height:1.6;">
                ${survey.description}
            </div>
        </c:if>
    </div>

    <c:choose>
        <c:when test="${empty survey.questions}">
            <div style="text-align:center; padding:50px; color:#b91c1c; background:#fef2f2; border-radius:12px; border:2px dashed #f87171;">
                <span style="font-size:3em; display:block; margin-bottom:15px;">&#9888;&#65039;</span>
                <p style="font-size:1.3em; margin:0; font-weight:500;">Notice: This survey is currently empty and has no questions.</p>
                <p style="color:#ef4444; margin-top:10px;">Please contact the survey initiator or administrator.</p>
            </div>
        </c:when>
        <c:otherwise>
            <form action="/guest/survey/${survey.id}/submit" method="post">
                <sec:authorize access="!isAuthenticated()">
                    <div style="background:#f0f9ff; padding:25px; border-radius:12px; margin-bottom:40px; border:1px solid #bae6fd; box-shadow:0 4px 6px rgba(14,165,233,0.05);">
                        <h4 style="margin:0 0 15px 0; color:#0369a1; font-size:1.2em; display:flex; align-items:center; gap:8px;">
                            <span style="font-size:1.2em;">&#128100;</span> Guest Participant Information
                        </h4>
                        <label style="font-weight:600; color:#0c4a6e; display:block; margin-bottom:10px; font-size:1.05em;">Your Email Address (For Submission Receipt):</label>
                        <input type="email" name="guestEmail" required placeholder="you@example.com" style="margin:0; width:100%; max-width:500px; padding:12px; border:2px solid #bae6fd; border-radius:6px; font-size:1.05em;" />
                    </div>
                </sec:authorize>
                
                <c:forEach var="question" items="${survey.questions}" varStatus="qStatus">
                    <div style="margin-bottom:40px; background:#fff; padding:25px; border-radius:12px; border:1px solid #e2e8f0; box-shadow:0 2px 4px rgba(0,0,0,0.02);">
                        <h4 style="font-size:1.25em; color:#0f172a; margin:0 0 20px 0;">
                            <span style="color:#3b82f6; margin-right:5px;">Q${qStatus.index + 1}.</span> ${question.text}
                        </h4>
                        <div style="display:flex; flex-direction:column; gap:12px;">
                            <c:forEach var="option" items="${question.options}">
                                <label style="display:flex; align-items:center; gap:15px; cursor:pointer; background:#f8fafc; padding:15px 20px; border-radius:8px; border:2px solid transparent; transition:all 0.2s; box-shadow:inset 0 0 0 1px #e2e8f0;">
                                    <input type="radio" name="question_${question.id}" value="${option.id}" required style="width:22px; height:22px; margin:0; cursor:pointer;" />
                                    <span style="font-size:1.15em; color:#334155;">${option.text}</span>
                                </label>
                            </c:forEach>
                        </div>
                    </div>
                </c:forEach>

                <div style="margin-top:50px; border-top:2px solid #f1f5f9; padding-top:30px; text-align:center;">
                    <p style="color:#64748b; margin-bottom:20px;">By submitting, you confirm that your responses are accurate.</p>
                    <button type="submit" class="btn btn-success" style="padding:18px 40px; font-size:1.3em; border-radius:50px; font-weight:600; box-shadow:0 4px 10px rgba(16,185,129,0.3); width:100%; max-width:400px;">Submit All Responses &rarr;</button>
                </div>
            </form>
        </c:otherwise>
    </c:choose>
</div>
<style>
/* Add hover effect dynamically inside the view */
label:hover {
    background-color: #f1f5f9 !important;
    box-shadow: inset 0 0 0 2px #cbd5e1 !important;
}
input[type="radio"]:checked + span {
    font-weight: 600;
    color: #1e3a8a !important;
}
</style>
<%@ include file="../layout/footer.jsp" %>
