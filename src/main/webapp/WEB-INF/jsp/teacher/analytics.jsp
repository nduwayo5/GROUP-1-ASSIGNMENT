<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../layout/header.jsp" %>
<div class="card">
    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:30px; border-bottom:1px solid #e2e8f0; padding-bottom:15px;">
        <div>
            <h2 style="margin:0;">Detailed Analytics</h2>
            <p style="color:#64748b; margin:5px 0 0 0;">Comprehensive performance insights across all courses</p>
        </div>
        <a href="/teacher/dashboard" class="btn" style="background:#64748b;">Back to Dashboard</a>
    </div>

    <!-- Course Comparison Overview -->
    <h3 style="margin-bottom:20px; color:#374151;">Course Performance Comparison</h3>
    <div style="margin-bottom:30px;">
        <div style="background:#f0f9ff; border:1px solid #bae6fd; padding:15px; border-radius:8px; margin-bottom:20px;">
            <p style="margin:0; color:#0369a1; font-weight:600;">
                Department Average Rating: <span style="font-size:1.2rem; color:#0c4a6e;">${comparison.departmentAverage}</span>
            </p>
        </div>
        
        <div style="display:grid; grid-template-columns:repeat(auto-fit, minmax(300px, 1fr)); gap:20px;">
            <c:forEach var="courseData" items="${comparison.courses}">
                <div style="background:#fff; padding:20px; border-radius:10px; border:1px solid #e5e7eb; box-shadow:0 2px 4px rgba(0,0,0,0.05);">
                    <div style="display:flex; justify-content:space-between; align-items:start; margin-bottom:15px;">
                        <div>
                            <h4 style="margin:0; color:#1f2937;">${courseData.course.code}</h4>
                            <p style="margin:5px 0 0 0; color:#6b7280; font-size:0.9rem;">${courseData.course.name}</p>
                        </div>
                        <div style="text-align:right;">
                            <div style="font-size:1.5rem; font-weight:700; color:#059669;">${courseData.averageRating}</div>
                            <div style="font-size:0.8rem; color:#6b7280;">Avg Rating</div>
                        </div>
                    </div>
                    
                    <!-- Performance Metrics -->
                    <div style="display:grid; grid-template-columns:1fr 1fr; gap:15px; margin-bottom:15px;">
                        <div style="text-align:center; padding:10px; background:#f9fafb; border-radius:6px;">
                            <div style="font-size:1.2rem; font-weight:600; color:#374151;">${courseData.surveyCount}</div>
                            <div style="font-size:0.8rem; color:#6b7280;">Surveys</div>
                        </div>
                        <div style="text-align:center; padding:10px; background:#f9fafb; border-radius:6px;">
                            <div style="font-size:1.2rem; font-weight:600; color:#374151;">${courseData.responseCount}</div>
                            <div style="font-size:0.8rem; color:#6b7280;">Responses</div>
                        </div>
                    </div>
                    
                    <!-- Response Rate Bar -->
                    <div>
                        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:5px;">
                            <span style="color:#6b7280; font-size:0.85rem;">Response Rate</span>
                            <span style="color:#374151; font-size:0.85rem; font-weight:600;">${courseData.responseRate}%</span>
                        </div>
                        <div style="background:#e5e7eb; height:6px; border-radius:3px; overflow:hidden;">
                            <c:set var="rate" value="${courseData.responseRate}"/>
                            <div style="background:#10b981; height:100%; width:${rate}%;"></div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- Performance Insights -->
    <h3 style="margin-bottom:15px; color:#374151;">Key Insights</h3>
    <div style="background:#fff; padding:20px; border-radius:8px; border:1px solid #e5e7eb; margin-bottom:30px;">
        <div style="display:grid; grid-template-columns:repeat(auto-fit, minmax(250px, 1fr)); gap:20px;">
            <div style="display:flex; align-items:center; gap:15px;">
                <div style="width:40px; height:40px; background:#dcfce7; border-radius:50%; display:flex; align-items:center; justify-content:center;">
                    <span style="color:#16a34a; font-weight:bold;">↑</span>
                </div>
                <div>
                    <p style="margin:0; color:#374151; font-weight:600;">High Engagement</p>
                    <p style="margin:0; color:#6b7280; font-size:0.85rem;">Above-average response rates detected</p>
                </div>
            </div>
            
            <div style="display:flex; align-items:center; gap:15px;">
                <div style="width:40px; height:40px; background:#fef3c7; border-radius:50%; display:flex; align-items:center; justify-content:center;">
                    <span style="color:#d97706;">⚡</span>
                </div>
                <div>
                    <p style="margin:0; color:#374151; font-weight:600;">Consistent Performance</p>
                    <p style="margin:0; color:#6b7280; font-size:0.85rem;">Steady ratings across all courses</p>
                </div>
            </div>
            
            <div style="display:flex; align-items:center; gap:15px;">
                <div style="width:40px; height:40px; background:#dbeafe; border-radius:50%; display:flex; align-items:center; justify-content:center;">
                    <span style="color:#2563eb;">📊</span>
                </div>
                <div>
                    <p style="margin:0; color:#374151; font-weight:600;">Data Driven</p>
                    <p style="margin:0; color:#6b7280; font-size:0.85rem;">Comprehensive analytics available</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Recommendations Section -->
    <h3 style="margin-bottom:15px; color:#374151;">Recommendations</h3>
    <div style="background:#f8fafc; padding:20px; border-radius:8px; border:1px solid #e2e8f0;">
        <ul style="margin:0; padding-left:20px; color:#374151;">
            <li style="margin-bottom:10px;">Continue monitoring response rates to maintain student engagement</li>
            <li style="margin-bottom:10px;">Consider implementing mid-term surveys for more frequent feedback</li>
            <li style="margin-bottom:10px;">Share successful teaching strategies across courses with similar performance</li>
            <li style="margin-bottom:10px;">Set specific improvement goals based on current analytics trends</li>
            <li>Use detailed question analytics to identify specific areas for enhancement</li>
        </ul>
    </div>
</div>
<%@ include file="../layout/footer.jsp" %>
