package com.coursepulse.controller;

import com.coursepulse.model.*;
import com.coursepulse.service.InitiatorService;
import com.coursepulse.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.core.Authentication;

@Controller
@RequestMapping("/initiator")
public class InitiatorController {
    
    private final InitiatorService initiatorService;
    private final UserService userService;
    
    public InitiatorController(InitiatorService initiatorService, UserService userService) {
        this.initiatorService = initiatorService;
        this.userService = userService;
    }
    
    private User getCurrentUser(Authentication authentication) {
        return userService.findByUsername(authentication.getName());
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model, Authentication authentication) {
        User user = getCurrentUser(authentication);
        model.addAttribute("surveys", initiatorService.getSurveysByInitiator(user));
        return "initiator/dashboard";
    }

    @GetMapping("/survey/new")
    public String createSurveyForm(Model model) {
        model.addAttribute("survey", new Survey());
        model.addAttribute("courses", initiatorService.getAllCourses());
        return "initiator/survey_form";
    }

    @PostMapping("/survey/save")
    public String saveSurvey(@ModelAttribute Survey survey, @RequestParam Long courseId, Authentication authentication) {
        User user = getCurrentUser(authentication);
        survey.setInitiator(user);
        
        Course course = new Course();
        course.setId(courseId);
        survey.setCourse(course);
        
        initiatorService.createSurvey(survey);
        return "redirect:/initiator/survey/" + survey.getId() + "/edit";
    }

    @GetMapping("/survey/{id}/edit")
    public String editSurvey(@PathVariable Long id, Model model) {
        model.addAttribute("survey", initiatorService.getSurveyById(id));
        model.addAttribute("newQuestion", new Question());
        model.addAttribute("newOption", new Option());
        return "initiator/survey_edit";
    }

    @PostMapping("/survey/{id}/delete")
    public String deleteSurvey(@PathVariable Long id) {
        initiatorService.deleteSurvey(id);
        return "redirect:/initiator/dashboard?deleted";
    }

    @PostMapping("/survey/{id}/question")
    public String addQuestion(@PathVariable Long id, @ModelAttribute Question question) {
        initiatorService.addQuestionToSurvey(id, question);
        return "redirect:/initiator/survey/" + id + "/edit";
    }

    @PostMapping("/question/{qId}/option")
    public String addOption(@PathVariable Long qId, @RequestParam Long surveyId, @ModelAttribute Option option) {
        initiatorService.addOptionToQuestion(qId, option);
        return "redirect:/initiator/survey/" + surveyId + "/edit";
    }
    
    @GetMapping("/survey/{id}/results")
    public String viewResults(@PathVariable Long id, Model model) {
        model.addAttribute("survey", initiatorService.getSurveyById(id));
        model.addAttribute("responses", initiatorService.getSurveyResults(id));
        return "initiator/survey_results";
    }
}
