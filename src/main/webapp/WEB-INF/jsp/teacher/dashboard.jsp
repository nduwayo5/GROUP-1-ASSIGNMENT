<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../layout/header.jsp" %>
<div class="card">
    <h2 style="margin-bottom:20px;">Teacher Analytics Dashboard</h2>
    
    <!-- Analytics Overview Cards -->
    <div style="display:grid; grid-template-columns:repeat(auto-fit, minmax(200px, 1fr)); gap:20px; margin-bottom:30px;">
        <div style="background:#f0f9ff; padding:20px; border-radius:10px; border-left:4px solid #0ea5e9;">
            <p style="margin:0; color:#0369a1; font-size:0.9rem; font-weight:600;">Total Courses</p>
            <h3 style="margin:5px 0 0 0; color:#0c4a6e; font-size:2rem;">${metrics.totalCourses}</h3>
        </div>
        <div style="background:#f0fdf4; padding:20px; border-radius:10px; border-left:4px solid #22c55e;">
            <p style="margin:0; color:#166534; font-size:0.9rem; font-weight:600;">Active Surveys</p>
            <h3 style="margin:5px 0 0 0; color:#15803d; font-size:2rem;">${metrics.totalSurveys}</h3>
        </div>
        <div style="background:#fef3c7; padding:20px; border-radius:10px; border-left:4px solid #f59e0b;">
            <p style="margin:0; color:#92400e; font-size:0.9rem; font-weight:600;">Total Responses</p>
            <h3 style="margin:5px 0 0 0; color:#78350f; font-size:2rem;">${metrics.totalResponses}</h3>
        </div>
        <div style="background:#f3f4f6; padding:20px; border-radius:10px; border-left:4px solid #6b7280;">
            <p style="margin:0; color:#374151; font-size:0.9rem; font-weight:600;">Avg Response Rate</p>
            <h3 style="margin:5px 0 0 0; color:#111827; font-size:2rem;">${metrics.averageResponseRate}%</h3>
        </div>
    </div>

    <!-- Recent Activity Timeline -->
    <div style="margin-bottom:30px;">
        <h3 style="margin-bottom:15px; color:#374151;">Recent Activity</h3>
        <c:choose>
            <c:when test="${empty metrics.recentActivity}">
                <div style="background:#f9fafb; padding:20px; border-radius:8px; text-align:center; color:#6b7280;">
                    No recent activity to display.
                </div>
            </c:when>
            <c:otherwise>
                <div style="background:#fff; padding:15px; border-radius:8px; border:1px solid #e5e7eb;">
                    <c:forEach var="activity" items="${metrics.recentActivity}" varStatus="status">
                        <div style="display:flex; align-items:center; padding:10px 0; border-bottom:1px solid #f3f4f6;">
                            <c:if test="${status.last}">
                                <style>div:last-child { border-bottom: none !important; }</style>
                            </c:if>
                            <div style="width:8px; height:8px; background:#10b981; border-radius:50%; margin-right:15px;"></div>
                            <div style="flex:1;">
                                <p style="margin:0; color:#374151; font-weight:500;">${activity.surveyTitle}</p>
                                <p style="margin:0; color:#6b7280; font-size:0.85rem;">${activity.courseName} - ${activity.submissionDate}</p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Course Performance Overview -->
    <div style="margin-bottom:30px;">
        <h3 style="margin-bottom:15px; color:#374151;">Course Performance</h3>
        <div style="display:grid; grid-template-columns:repeat(auto-fit, minmax(250px, 1fr)); gap:15px;">
            <c:forEach var="course" items="${courses}">
                <div style="background:#fff; padding:15px; border-radius:8px; border:1px solid #e5e7eb;">
                    <h4 style="margin:0 0 10px 0; color:#1f2937;">${course.code}</h4>
                    <p style="margin:0; color:#6b7280; font-size:0.9rem;">${course.name}</p>
                    <div style="margin-top:10px;">
                        <span style="color:#059669; font-weight:600;">${metrics.coursePerformance[course.code].surveyCount} surveys</span>
                        <span style="color:#6b7280; margin-left:10px;">Rating: ${metrics.coursePerformance[course.code].averageRating}</span>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- Analytics Link -->
    <div style="text-align:center; margin-top:20px;">
        <a href="/teacher/analytics" class="btn btn-primary" style="background:#3b82f6; padding:10px 20px; text-decoration:none; border-radius:6px; color:white;">
            View Detailed Analytics →
        </a>
    </div>

    <!-- Traditional Course List (Collapsible) -->
    <details style="margin-top:30px;">
        <summary style="cursor:pointer; padding:10px; background:#f9fafb; border-radius:6px; font-weight:600; color:#374151;">
            View Assigned Courses Details
        </summary>
        <div style="padding:15px 0;">
            <c:choose>
                <c:when test="${empty courses}">
                    <p style="color:#64748b;">You have not been assigned to any courses yet. Please wait for an Administrator.</p>
                </c:when>
                <c:otherwise>
                    <ul style="padding-left:20px; color:#475569;">
                        <c:forEach var="course" items="${courses}">
                            <li style="margin-bottom:8px; font-size:1.1em;"><strong>${course.code}</strong> - ${course.name}</li>
                        </c:forEach>
                    </ul>
                </c:otherwise>
            </c:choose>
        </div>
    </details>

    <!-- Survey List (Collapsible) -->
    <details style="margin-top:20px;">
        <summary style="cursor:pointer; padding:10px; background:#f9fafb; border-radius:6px; font-weight:600; color:#374151;">
            View Available Surveys
        </summary>
        <div style="padding:15px 0;">
            <c:if test="${param.error != null}">
                <p class="badge badge-warning" style="display:inline-block; margin-bottom:15px; padding:8px 12px; color:#b91c1c;">${param.error == 'access_denied' ? 'Access denied to this survey.' : 'An error occurred.'}</p>
            </c:if>
            <c:choose>
                <c:when test="${empty surveys}">
                    <p style="color:#64748b;">No surveys have been created for your courses yet.</p>
                </c:when>
                <c:otherwise>
                    <table style="width:100%;">
                        <tr>
                            <th>Survey Title</th>
                            <th>Related Course</th>
                            <th>Action</th>
                        </tr>
                        <c:forEach var="survey" items="${surveys}">
                            <tr>
                                <td><strong>${survey.title}</strong></td>
                                <td>${survey.course.name}</td>
                                <td>
                                    <a href="/teacher/survey/${survey.id}/results" class="btn btn-success" style="padding:6px 12px; font-size:0.9em;">View Results</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </details>
</div>
<%@ include file="../layout/footer.jsp" %>
