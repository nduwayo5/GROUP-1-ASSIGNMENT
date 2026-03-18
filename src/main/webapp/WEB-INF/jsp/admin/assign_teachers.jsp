<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../layout/header.jsp" %>
<div class="card">
    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:25px;">
        <h2>🔗 Assign Teachers to Courses</h2>
        <a href="/admin/dashboard" class="action-btn" style="padding: 10px 18px;">Back to Dashboard</a>
    </div>

    <c:if test="${param.assigned != null}">
        <p class="badge badge-success" style="display:inline-block; margin-bottom:15px; padding:8px 12px;">Teacher successfully assigned to course!</p>
    </c:if>
    <c:if test="${param.unassigned != null}">
        <p class="badge badge-warning" style="display:inline-block; margin-bottom:15px; padding:8px 12px;">Teacher unassigned from course.</p>
    </c:if>

    <div style="background:#f8fafc; padding:25px; border-radius:12px; margin-bottom:30px; border:1px solid #e2e8f0; box-shadow:0 1px 3px rgba(0,0,0,0.05);">
        <h3 style="margin-top:0;">Create New Assignment</h3>
        <form action="/admin/courses/assign" method="post" style="display:grid; grid-template-columns: 1fr 1fr auto; gap:20px; align-items:flex-end; margin:0;">
            <div>
                <label style="font-weight:600; display:block; margin-bottom:8px;">Select Teacher</label>
                <select name="teacherId" required style="width:100%; padding:10px; border:1px solid #cbd5e1; border-radius:6px;">
                    <option value="" disabled selected>-- Select Teacher --</option>
                    <c:forEach var="t" items="${teachers}">
                        <option value="${t.id}">${t.fullName} (${t.username})</option>
                    </c:forEach>
                </select>
            </div>
            <div>
                <label style="font-weight:600; display:block; margin-bottom:8px;">Select Course</label>
                <select name="courseId" required style="width:100%; padding:10px; border:1px solid #cbd5e1; border-radius:6px;">
                    <option value="" disabled selected>-- Select Course --</option>
                    <c:forEach var="c" items="${courses}">
                        <option value="${c.id}">${c.name} (${c.code})</option>
                    </c:forEach>
                </select>
            </div>
            <button type="submit" class="btn btn-success" style="padding:12px 25px; font-weight:600;">Link Teacher</button>
        </form>
    </div>

    <h3>Current Assignments</h3>
    <table>
        <tr>
            <th>Course</th>
            <th>Assigned Teachers</th>
        </tr>
        <c:forEach var="course" items="${courses}">
            <tr>
                <td><strong>${course.name}</strong> (${course.code})</td>
                <td>
                    <div style="display:flex; flex-wrap:wrap; gap:10px;">
                        <c:forEach var="teacher" items="${teachers}">
                             <%-- Manual check for many-to-many relationship in JSP --%>
                             <c:set var="isAssigned" value="false" />
                             <c:forEach var="tc" items="${teacher.courses}">
                                 <c:if test="${tc.id == course.id}"><c:set var="isAssigned" value="true" /></c:if>
                             </c:forEach>
                             
                             <c:if test="${isAssigned}">
                                 <div style="background:#e2e8f0; padding:5px 10px; border-radius:20px; display:flex; align-items:center; gap:8px;">
                                     <span style="font-size:0.875rem;">${teacher.fullName}</span>
                                     <form action="/admin/courses/unassign" method="post" style="margin:0; display:flex;">
                                         <input type="hidden" name="teacherId" value="${teacher.id}" />
                                         <input type="hidden" name="courseId" value="${course.id}" />
                                         <button type="submit" style="background:none; border:none; color:#ef4444; cursor:pointer; font-weight:bold; padding:0 2px;">×</button>
                                     </form>
                                 </div>
                             </c:if>
                        </c:forEach>
                    </div>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<%@ include file="../layout/footer.jsp" %>
