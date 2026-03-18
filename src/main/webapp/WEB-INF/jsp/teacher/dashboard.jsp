<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../layout/header.jsp" %>
<div class="card">
    <h2 style="margin-bottom:20px;">Teacher Dashboard</h2>
    
    <h3>My Assigned Courses</h3>
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

    <h3 style="margin-top:40px;">Evaluations for my Courses</h3>
    <c:if test="${param.error != null}">
        <p class="badge badge-warning" style="display:inline-block; margin-bottom:15px; padding:8px 12px; color:#b91c1c;">${param.error == 'access_denied' ? 'Access denied to this survey.' : 'An error occurred.'}</p>
    </c:if>
    <c:choose>
        <c:when test="${empty surveys}">
            <p style="color:#64748b;">No surveys have been created for your courses yet.</p>
        </c:when>
        <c:otherwise>
            <table>
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
<%@ include file="../layout/footer.jsp" %>
