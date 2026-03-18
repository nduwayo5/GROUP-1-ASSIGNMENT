<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../layout/header.jsp" %>
<div class="card">
    <div style="display:flex; justify-content:space-between; align-items:center;">
        <h2>Manage Courses</h2>
        <a href="/admin/dashboard" class="btn" style="background:#64748b;">Back to Dashboard</a>
    </div>

    <c:if test="${param.added != null}"><p class="badge badge-success" style="display:inline-block; margin-bottom:15px; padding:8px 12px;">Course created successfully</p></c:if>
    <c:if test="${param.deleted != null}"><p class="badge badge-warning" style="display:inline-block; margin-bottom:15px; padding:8px 12px;">Course deleted successfully</p></c:if>
    <c:if test="${param.assigned != null}"><p class="badge badge-success" style="display:inline-block; margin-bottom:15px; padding:8px 12px;">Teacher assigned</p></c:if>

    <div style="background:#f8fafc; padding:20px; border-radius:8px; margin-bottom:30px; border:1px solid #e2e8f0;">
        <h3 style="margin-top:0;">Add New Course</h3>
        <form action="/admin/courses" method="post" style="display:flex; gap:15px; align-items:flex-end; margin:0;">
            <div style="flex:2;">
                <label style="font-weight:500; display:block; margin-bottom:5px;">Course Name</label>
                <input type="text" name="name" required placeholder="e.g. Intro to Computer Science" style="margin:0;" />
            </div>
            <div style="flex:1;">
                <label style="font-weight:500; display:block; margin-bottom:5px;">Course Code</label>
                <input type="text" name="code" required placeholder="e.g. CS101" style="margin:0;" />
            </div>
            <button type="submit" class="btn btn-success" style="padding:12px 20px;">Add Course</button>
        </form>
    </div>

    <h3>Course List & Teacher Assignments</h3>
    <table>
        <tr>
            <th>Code</th>
            <th>Name</th>
            <th>Assign Teacher</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="course" items="${courses}">
            <tr>
                <td><strong>${course.code}</strong></td>
                <td>${course.name}</td>
                <td>
                    <form action="/admin/courses/assign" method="post" style="display:flex; gap:10px; margin:0;">
                        <input type="hidden" name="courseId" value="${course.id}" />
                        <select name="teacherId" style="margin:0; padding:8px; min-width:180px;" required>
                            <option value="" disabled selected>-- Select Teacher --</option>
                            <c:forEach var="t" items="${teachers}">
                                <option value="${t.id}">${t.fullName}</option>
                            </c:forEach>
                        </select>
                        <button type="submit" class="btn" style="padding:8px 16px;">Assign</button>
                    </form>
                </td>
                <td>
                    <form action="/admin/courses/delete/${course.id}" method="post" style="margin:0;">
                        <button type="submit" class="btn btn-danger" style="padding:8px 16px;" onclick="return confirm('Are you sure you want to delete this course?')">Delete</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<%@ include file="../layout/footer.jsp" %>
