<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../layout/header.jsp" %>
<div class="card">
    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:30px; border-bottom:1px solid #e2e8f0; padding-bottom:15px;">
        <div>
            <h2 style="margin:0;">Survey Results: ${survey.title}</h2>
            <p style="color:#64748b; margin:5px 0 0 0;">Course: ${survey.course.name}</p>
        </div>
        <a href="/teacher/dashboard" class="btn" style="background:#64748b;">Back to Dashboard</a>
    </div>

    <!-- Enhanced Analytics Overview -->
    <div style="display:grid; grid-template-columns:repeat(auto-fit, minmax(200px, 1fr)); gap:20px; margin-bottom:30px;">
        <div style="background:#f0fdf4; border:1px solid #bbf7d0; padding:20px; border-radius:8px; text-align:center;">
            <p style="margin:0; color:#166534; font-weight:600;">Total Responses</p>
            <h1 style="margin:5px 0 0 0; color:#15803d; font-size:2.5em;">${analytics.totalResponses}</h1>
        </div>
        <div style="background:#fef3c7; border:1px solid #fde68a; padding:20px; border-radius:8px; text-align:center;">
            <p style="margin:0; color:#92400e; font-weight:600;">Response Rate</p>
            <h1 style="margin:5px 0 0 0; color:#78350f; font-size:2.5em;">${analytics.responseRate}%</h1>
        </div>
        <div style="background:#f0f9ff; border:1px solid #bae6fd; padding:20px; border-radius:8px; text-align:center;">
            <p style="margin:0; color:#0369a1; font-weight:600;">Avg Completion Time</p>
            <h1 style="margin:5px 0 0 0; color:#0c4a6e; font-size:2.5em;">${analytics.summaryMetrics.averageCompletionTime}m</h1>
        </div>
        <div style="background:#f3f4f6; border:1px solid #d1d5db; padding:20px; border-radius:8px; text-align:center;">
            <p style="margin:0; color:#374151; font-weight:600;">Satisfaction Score</p>
            <h1 style="margin:5px 0 0 0; color:#111827; font-size:2.5em;">${analytics.summaryMetrics.satisfactionScore}</h1>
        </div>
    </div>

    <!-- Question-by-Question Analytics -->
    <h3 style="margin-bottom:20px; color:#374151;">Question Analytics</h3>
    <div style="margin-bottom:30px;">
        <c:forEach var="questionEntry" items="${analytics.questionAnalytics}">
            <div style="background:#fff; padding:20px; border-radius:8px; margin-bottom:20px; border:1px solid #e5e7eb; box-shadow:0 2px 4px rgba(0,0,0,0.02);">
                <h4 style="margin:0 0 15px 0; color:#1e3a8a; font-size:1.1rem;">${questionEntry.value.questionText}</h4>
                
                <!-- Response Distribution -->
                <div style="margin-bottom:15px;">
                    <p style="margin:0 0 10px 0; color:#6b7280; font-size:0.9rem;">Response Distribution (${questionEntry.value.totalResponses} responses)</p>
                    <c:forEach var="option" items="${questionEntry.value.optionCounts}">
                        <div style="margin-bottom:8px;">
                            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:4px;">
                                <span style="color:#374151; font-size:0.9rem;">${option.key}</span>
                                <span style="color:#6b7280; font-size:0.85rem;">
                                    ${option.value} (${questionEntry.value.optionPercentages[option.key]}%)
                                </span>
                            </div>
                            <div style="background:#e5e7eb; height:8px; border-radius:4px; overflow:hidden;">
                                <c:set var="percentage" value="${questionEntry.value.optionPercentages[option.key]}"/>
                                <div style="background:#3b82f6; height:100%; width:${percentage}%;"></div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- Response Trend Analysis -->
    <c:if test="${not empty analytics.responseTrend.dailyResponses}">
        <h3 style="margin-bottom:15px; color:#374151;">Response Trend</h3>
        <div style="background:#fff; padding:20px; border-radius:8px; margin-bottom:30px; border:1px solid #e5e7eb;">
            <p style="margin:0 0 15px 0; color:#6b7280;">
                Peak submission day: <strong>${analytics.responseTrend.peakDay}</strong>
            </p>
            <div style="display:grid; grid-template-columns:repeat(auto-fit, minmax(100px, 1fr)); gap:10px;">
                <c:forEach var="day" items="${analytics.responseTrend.dailyResponses}">
                    <div style="text-align:center; padding:10px; background:#f9fafb; border-radius:6px;">
                        <div style="font-size:0.8rem; color:#6b7280;">${day.key}</div>
                        <div style="font-size:1.2rem; font-weight:600; color:#374151;">${day.value}</div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </c:if>

    <!-- Individual Responses (Collapsible) -->
    <details style="margin-top:20px;">
        <summary style="cursor:pointer; padding:10px; background:#f9fafb; border-radius:6px; font-weight:600; color:#374151;">
            View Individual Responses (${responses.size()})
        </summary>
        <div style="padding:15px 0;">
            <div>
                <c:forEach var="response" items="${responses}" varStatus="status">
                    <div style="background:#fff; padding:20px; border-radius:8px; margin-bottom:20px; border:1px solid #e2e8f0; box-shadow:0 2px 4px rgba(0,0,0,0.02);">
                        <h4 style="margin:0 0 15px 0; color:#1e3a8a; border-bottom:1px solid #f1f5f9; padding-bottom:10px;">Submission #${status.index + 1}</h4>
                        <ul style="margin:0; padding-left:0; list-style:none; display:flex; flex-direction:column; gap:12px;">
                            <c:forEach var="answer" items="${response.answers}">
                                <li style="background:#f8fafc; padding:12px 15px; border-radius:6px; border-left:4px solid #10b981;">
                                    <strong style="display:block; margin-bottom:5px; color:#475569;">${answer.question.text}</strong>
                                    <span style="color:#0f172a; font-weight:500; font-size:1.05em;">${answer.selectedOption.text}</span>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:forEach>
                <c:if test="${empty responses}">
                    <p style="color:#64748b; padding:20px; background:#f8fafc; border-radius:8px; text-align:center;">No feedback available yet.</p>
                </c:if>
            </div>
        </div>
    </details>
</div>
<%@ include file="../layout/footer.jsp" %>
