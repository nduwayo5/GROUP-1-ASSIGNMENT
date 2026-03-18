package com.coursepulse.controller;

import com.coursepulse.model.User;
import com.coursepulse.model.Survey;
import com.coursepulse.service.TeacherService;
import com.coursepulse.service.TeacherAnalyticsService;
import com.coursepulse.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.core.Authentication;

import java.util.Map;

@Controller
@RequestMapping("/teacher")
public class TeacherController {

    private final TeacherService teacherService;
    private final UserService userService;
    private final TeacherAnalyticsService analyticsService;

    public TeacherController(TeacherService teacherService, UserService userService, TeacherAnalyticsService analyticsService) {
        this.teacherService = teacherService;
        this.userService = userService;
        this.analyticsService = analyticsService;
    }

    private User getCurrentUser(Authentication authentication) {
        return userService.findByUsername(authentication.getName());
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model, Authentication authentication) {
        User user = getCurrentUser(authentication);
        model.addAttribute("courses", user.getCourses());
        model.addAttribute("surveys", teacherService.getSurveysForCourses(user.getCourses()));
        
        // Add analytics data
        Map<String, Object> metrics = analyticsService.getDashboardMetrics(user);
        model.addAttribute("metrics", metrics);
        
        return "teacher/dashboard";
    }

    @GetMapping("/survey/{id}/results")
    public String viewResults(@PathVariable Long id, Model model, Authentication authentication) {
        User user = getCurrentUser(authentication);
        Survey survey = teacherService.getSurveyById(id);
        
        // Security check
        if(!user.getCourses().contains(survey.getCourse())) {
            return "redirect:/teacher/dashboard?error=access_denied";
        }
        
        model.addAttribute("survey", survey);
        model.addAttribute("responses", teacherService.getSurveyResults(id));
        
        // Add detailed analytics
        Map<String, Object> analytics = analyticsService.getSurveyAnalytics(id);
        model.addAttribute("analytics", analytics);
        
        return "teacher/survey_results";
    }

    @GetMapping("/analytics")
    public String analytics(Model model, Authentication authentication) {
        User user = getCurrentUser(authentication);
        
        Map<String, Object> comparison = analyticsService.getCourseComparisonAnalytics(user);
        model.addAttribute("comparison", comparison);
        model.addAttribute("courses", user.getCourses());
        
        return "teacher/analytics";
    }
}
