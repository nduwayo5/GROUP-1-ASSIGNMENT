<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../layout/header.jsp" %>
<div class="card">
    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:25px;">
        <h2>👥 System User Management</h2>
        <a href="/admin/dashboard" class="action-btn" style="padding: 10px 18px;">Back to Dashboard</a>
    </div>

    <table>
        <tr>
            <th>ID</th>
            <th>Full Name</th>
            <th>Username</th>
            <th>Role</th>
            <th>Status</th>
        </tr>
        <c:forEach var="user" items="${users}">
            <tr>
                <td>${user.id}</td>
                <td><strong>${user.fullName}</strong></td>
                <td>${user.username}</td>
                <td>
                    <span class="badge" style="background: ${user.role == 'ADMIN' ? '#ef4444' : (user.role == 'TEACHER' ? '#10b981' : (user.role == 'INITIATOR' ? '#f59e0b' : '#3b82f6'))}; color:white;">
                        ${user.role}
                    </span>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${user.approved}">
                            <span class="badge badge-success">Active</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge badge-warning">Pending</span>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<%@ include file="../layout/footer.jsp" %>
