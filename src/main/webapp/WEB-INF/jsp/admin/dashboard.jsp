<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../layout/header.jsp" %>
<div class="card">
    <h2>📊 System Overview & Statistics</h2>
    <div class="stats-grid" style="display:grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap:20px; margin-top:20px;">
        <div class="stat-card" style="background:#f8fafc; padding:20px; border-radius:10px; border-left:5px solid #3b82f6; box-shadow:0 2px 4px rgba(0,0,0,0.05);">
            <h4 style="margin:0; color:#64748b;">Total Students</h4>
            <div style="font-size:2rem; font-weight:700; color:#1e293b;">${totalStudents}</div>
        </div>
        <div class="stat-card" style="background:#f8fafc; padding:20px; border-radius:10px; border-left:5px solid #10b981; box-shadow:0 2px 4px rgba(0,0,0,0.05);">
            <h4 style="margin:0; color:#64748b;">Total Teachers</h4>
            <div style="font-size:2rem; font-weight:700; color:#1e293b;">${totalTeachers}</div>
        </div>
        <div class="stat-card" style="background:#f8fafc; padding:20px; border-radius:10px; border-left:5px solid #f59e0b; box-shadow:0 2px 4px rgba(0,0,0,0.05);">
            <h4 style="margin:0; color:#64748b;">Initiators</h4>
            <div style="font-size:2rem; font-weight:700; color:#1e293b;">${totalInitiators}</div>
        </div>
        <div class="stat-card" style="background:#f8fafc; padding:20px; border-radius:10px; border-left:5px solid #8b5cf6; box-shadow:0 2px 4px rgba(0,0,0,0.05);">
            <h4 style="margin:0; color:#64748b;">Total Courses</h4>
            <div style="font-size:2rem; font-weight:700; color:#1e293b;">${totalCourses}</div>
        </div>
        <div class="stat-card" style="background:#f8fafc; padding:20px; border-radius:10px; border-left:5px solid #ec4899; box-shadow:0 2px 4px rgba(0,0,0,0.05);">
            <h4 style="margin:0; color:#64748b;">Total Surveys</h4>
            <div style="font-size:2rem; font-weight:700; color:#1e293b;">${totalSurveys}</div>
        </div>
        <div class="stat-card" style="background:#fff7ed; padding:20px; border-radius:10px; border-left:5px solid #f97316; box-shadow:0 2px 4px rgba(0,0,0,0.05);">
            <h4 style="margin:0; color:#c2410c;">Pending Approvals</h4>
            <div style="font-size:2rem; font-weight:700; color:#9a3412;">${pendingApprovals}</div>
            <a href="/admin/teachers/pending" style="font-size:0.875rem; color:#f97316;">View Pending →</a>
        </div>
    </div>
    
    <div style="margin-top:40px; display:flex; gap:20px; flex-wrap:wrap;">
        <a href="/admin/courses" class="btn" style="padding:15px 25px;">🏫 Manage Courses</a>
        <a href="/admin/users" class="btn" style="padding:15px 25px; background:#64748b;">👥 Manage Users</a>
        <a href="/admin/surveys" class="btn" style="padding:15px 25px; background:#64748b;">📋 View All Surveys</a>
    </div>
</div>
<%@ include file="../layout/footer.jsp" %>
