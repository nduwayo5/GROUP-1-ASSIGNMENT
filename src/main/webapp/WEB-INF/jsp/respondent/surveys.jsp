<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../layout/header.jsp" %>
<div class="card">
    <h2 style="margin-bottom:25px; color:#1e3a8a;">Available Surveys</h2>
    
    <c:if test="${param.success != null}">
        <p class="badge badge-success" style="display:block; margin-bottom:25px; padding:15px 20px; font-size:1.1em; background:#dcfce7; color:#166534; border:1px solid #bbf7d0;">
            <strong>&check; Success!</strong> Thank you, your response has been submitted successfully and recorded securely.
        </p>
    </c:if>

    <c:choose>
        <c:when test="${empty surveys}">
             <p style="text-align:center; color:#64748b; padding:40px; background:#f8fafc; border-radius:8px; border:2px dashed #cbd5e1; font-size:1.1em;">No surveys are currently available to take.</p>
        </c:when>
        <c:otherwise>
            <div style="display:grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap:25px;">
                <c:forEach var="survey" items="${surveys}">
                    <div style="border:1px solid #e2e8f0; border-radius:12px; padding:25px; background:#fff; box-shadow:0 4px 6px -1px rgba(0,0,0,0.05); display:flex; flex-direction:column; justify-content:space-between; transition:transform 0.2s, box-shadow 0.2s;">
                        <div style="flex:1;">
                            <h3 style="margin-top:0; color:#0f172a; font-size:1.3em;">${survey.title}</h3>
                            <p style="color:#475569; font-size:0.95em; margin-bottom:12px; display:inline-block; background:#f1f5f9; padding:4px 8px; border-radius:4px;">
                                Course: <strong>${survey.course.name}</strong>
                            </p>
                            <p style="color:#64748b; font-size:1em; margin-bottom:25px; line-height:1.5;">
                                <c:choose>
                                    <c:when test="${not empty survey.description}">${survey.description}</c:when>
                                    <c:otherwise><i>No additional instructions provided.</i></c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        
                        <div style="padding-top:20px; border-top:1px solid #f1f5f9; display:flex; justify-content:space-between; align-items:center;">
                            <span class="badge ${survey.requiresAuth ? 'badge-warning' : 'badge-success'}">
                                ${survey.requiresAuth ? '&#128274; Login Required' : '&#128101; Public Access'}
                            </span>
                            <a href="/guest/survey/${survey.id}" class="btn" style="padding:10px 18px; font-weight:600; box-shadow:0 2px 4px rgba(37,99,235,0.2);">Take Survey &rarr;</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>
<%@ include file="../layout/footer.jsp" %>
