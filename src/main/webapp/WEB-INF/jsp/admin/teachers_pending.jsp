<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../layout/header.jsp" %>
<div class="card">
    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
        <h2>👨‍🏫 Teacher Approval Queue</h2>
        <a href="/admin/dashboard" class="btn" style="background:#64748b;">Back to Dashboard</a>
    </div>

    <c:if test="${param.approved != null}">
        <p class="badge badge-success" style="display:inline-block; margin-bottom:15px; padding:8px 12px;">Teacher approved successfully!</p>
    </c:if>

    <c:choose>
        <c:when test="${empty pendingTeachers}">
            <div style="text-align:center; padding:40px; background:#f8fafc; border-radius:10px; border:1px dashed #e2e8f0;">
                <p style="color:#64748b; font-size:1.1rem; margin:0;">All caught up! No teachers are currently awaiting approval.</p>
            </div>
        </c:when>
        <c:otherwise>
            <table>
                <tr>
                    <th>Full Name</th>
                    <th>Username / Email</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                <c:forEach var="teacher" items="${pendingTeachers}">
                    <tr>
                        <td><strong>${teacher.fullName}</strong></td>
                        <td>${teacher.username}</td>
                        <td><span class="badge badge-warning">Awaiting Approval</span></td>
                        <td>
                            <form action="/admin/approve/${teacher.id}" method="post" style="margin:0;">
                                <button type="submit" class="btn btn-success" style="padding:8px 16px;">Approve Access</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>
</div>
<%@ include file="../layout/footer.jsp" %>
