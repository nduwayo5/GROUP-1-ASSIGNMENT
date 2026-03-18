<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../layout/header.jsp" %>
<div class="card">
    <h2>📊 System Overview & Statistics</h2>
    <div class="stats-grid">
        <div class="stat-card blue">
            <h4>Total Students</h4>
            <div class="stat-value">${totalStudents}</div>
        </div>
        <div class="stat-card green">
            <h4>Total Teachers</h4>
            <div class="stat-value">${totalTeachers}</div>
        </div>
        <div class="stat-card yellow">
            <h4>Initiators</h4>
            <div class="stat-value">${totalInitiators}</div>
        </div>
        <div class="stat-card purple">
            <h4>Total Courses</h4>
            <div class="stat-value">${totalCourses}</div>
        </div>
        <div class="stat-card pink">
            <h4>Total Surveys</h4>
            <div class="stat-value">${totalSurveys}</div>
        </div>
        <div class="stat-card orange">
            <h4>Pending Approvals</h4>
            <div class="stat-value">${pendingApprovals}</div>
            <a href="/admin/teachers/pending" style="font-size:0.875rem; color:#f97316; font-weight: 600; text-decoration: none;">View Pending →</a>
        </div>
    </div>
    
    <div class="action-grid">
        <a href="/admin/courses" class="action-btn primary">🏫 Manage Courses</a>
        <a href="/admin/users" class="action-btn">👥 Manage Users</a>
        <a href="/admin/surveys" class="action-btn">📋 View All Surveys</a>
    </div>
</div>
<%@ include file="../layout/footer.jsp" %>
