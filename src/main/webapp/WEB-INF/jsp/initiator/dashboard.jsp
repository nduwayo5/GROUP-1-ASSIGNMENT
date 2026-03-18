<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../layout/header.jsp" %>
<div class="card">
    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
        <h2>Initiator Dashboard</h2>
        <a href="/initiator/survey/new" class="btn btn-success">+ Create New Survey</a>
    </div>

    <c:if test="${param.deleted != null}">
        <p class="badge badge-warning" style="display:inline-block; margin-bottom:15px; padding:8px 12px;">Survey deleted successfully</p>
    </c:if>

    <h3>My Active Surveys</h3>
    <c:choose>
        <c:when test="${empty surveys}">
            <p style="color:#64748b; background:#f8fafc; padding:20px; border-radius:8px; text-align:center;">You haven't created any surveys yet. Click the button above to start.</p>
        </c:when>
        <c:otherwise>
            <table>
                <tr>
                    <th>Title</th>
                    <th>Course Code</th>
                    <th>Questions</th>
                    <th>Access Config</th>
                    <th>Actions</th>
                </tr>
                <c:forEach var="survey" items="${surveys}">
                    <tr>
                        <td><strong>${survey.title}</strong></td>
                        <td>${survey.course.code}</td>
                        <td><span class="badge ${survey.questions.size() > 0 ? 'badge-success' : 'badge-warning'}">${survey.questions.size()}</span></td>
                        <td>
                            <c:choose>
                                <c:when test="${survey.requiresAuth}">
                                    <span style="color:#0369a1; font-weight:500;">&#128274; Registered Only</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:#15803d; font-weight:500;">&#127760; Public (Guest allowed)</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <div style="display:flex; gap:8px;">
                                <a href="/initiator/survey/${survey.id}/edit" class="btn" style="padding:6px 12px; background:#f59e0b; color:#111;">Edit Setup</a>
                                <a href="/initiator/survey/${survey.id}/results" class="btn btn-success" style="padding:6px 12px;">Analytics</a>
                                <form action="/initiator/survey/${survey.id}/delete" method="post" style="margin:0;">
                                    <button type="submit" class="btn btn-danger" style="padding:6px 12px;" onclick="return confirm('Permanently delete this survey and all collected results?')">Delete</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>
</div>
<%@ include file="../layout/footer.jsp" %>
