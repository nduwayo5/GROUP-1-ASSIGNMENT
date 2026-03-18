package com.coursepulse.controller;

import com.coursepulse.model.User;
import com.coursepulse.model.Survey;
import com.coursepulse.service.TeacherService;
import com.coursepulse.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.core.Authentication;

@Controller
@RequestMapping("/teacher")
public class TeacherController {

    private final TeacherService teacherService;
    private final UserService userService;

    public TeacherController(TeacherService teacherService, UserService userService) {
        this.teacherService = teacherService;
        this.userService = userService;
    }

    private User getCurrentUser(Authentication authentication) {
        return userService.findByUsername(authentication.getName());
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model, Authentication authentication) {
        User user = getCurrentUser(authentication);
        model.addAttribute("courses", user.getCourses());
        model.addAttribute("surveys", teacherService.getSurveysForCourses(user.getCourses()));
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
        return "teacher/survey_results";
    }
}
