<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../layout/header.jsp" %>
<div class="card">
    <h2>Admin Dashboard</h2>
    <div style="margin-bottom:30px;">
        <a href="/admin/courses" class="btn">Manage Courses & Assignments</a>
    </div>

    <h3>Pending Teacher Approvals</h3>
    <c:choose>
        <c:when test="${empty pendingTeachers}">
            <p style="color:#64748b;">No teachers waiting for approval.</p>
        </c:when>
        <c:otherwise>
            <table>
                <tr><th>Name</th><th>Email (Username)</th><th>Action</th></tr>
                <c:forEach var="teacher" items="${pendingTeachers}">
                    <tr>
                        <td>${teacher.fullName}</td>
                        <td>${teacher.username}</td>
                        <td>
                            <form action="/admin/approve/${teacher.id}" method="post" style="margin:0;">
                                <button type="submit" class="btn btn-success" style="padding:6px 12px;">Approve</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>
</div>
<%@ include file="../layout/footer.jsp" %>
