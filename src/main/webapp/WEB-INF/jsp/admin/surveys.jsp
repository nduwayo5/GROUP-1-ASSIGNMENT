<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../layout/header.jsp" %>
<div class="card">
    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:25px;">
        <h2>📋 Global Survey Overview</h2>
        <a href="/admin/dashboard" class="action-btn" style="padding: 10px 18px;">Back to Dashboard</a>
    </div>

    <c:choose>
        <c:when test="${empty surveys}">
            <p style="color:#64748b; text-align:center; padding:20px;">No surveys have been created in the system yet.</p>
        </c:when>
        <c:otherwise>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Survey Title</th>
                    <th>Course</th>
                    <th>Created By (Initiator)</th>
                    <th>Auth Required</th>
                </tr>
                <c:forEach var="survey" items="${surveys}">
                    <tr>
                        <td>${survey.id}</td>
                        <td><strong>${survey.title}</strong></td>
                        <td>${survey.course.name} (${survey.course.code})</td>
                        <td>${survey.initiator.fullName}</td>
                        <td>
                            <c:choose>
                                <c:when test="${survey.requiresAuth}">
                                    <span class="badge badge-success">Yes</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-warning">No (Public)</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>
</div>
<%@ include file="../layout/footer.jsp" %>
