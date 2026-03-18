<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CoursePulse</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<nav>
    <div class="brand"><a href="/" style="margin:0; text-decoration:none;">CoursePulse</a></div>
    <div>
        <sec:authorize access="!isAuthenticated()">
            <a href="/login">Login</a>
            <a href="/register">Register</a>
            <a href="/guest/surveys">View Public Surveys</a>
        </sec:authorize>
        <sec:authorize access="isAuthenticated()">
            <sec:authorize access="hasAuthority('ADMIN')">
                <a href="/admin/dashboard">📊 Dashboard</a>
                <a href="/admin/courses">🏫 Courses</a>
                <a href="/admin/users">👥 Users</a>
                <a href="/admin/surveys">📋 Surveys</a>
            </sec:authorize>
            <sec:authorize access="!hasAuthority('ADMIN')">
                <a href="/dashboard">Dashboard</a>
            </sec:authorize>
            <form action="/logout" method="post" style="display:inline;">
                <button type="submit" class="btn btn-danger" style="padding: 6px 12px; margin: 0;">Logout</button>
            </form>
        </sec:authorize>
    </div>
</nav>
<div class="container">
