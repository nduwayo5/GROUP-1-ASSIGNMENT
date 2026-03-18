package com.coursepulse.controller;

import com.coursepulse.model.Survey;
import com.coursepulse.model.User;
import com.coursepulse.service.RespondentService;
import com.coursepulse.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.core.Authentication;

import java.util.HashMap;
import java.util.Map;

@Controller
public class RespondentController {

    private final RespondentService respondentService;
    private final UserService userService;

    public RespondentController(RespondentService respondentService, UserService userService) {
        this.respondentService = respondentService;
        this.userService = userService;
    }

    private User getCurrentUser(Authentication authentication) {
        if (authentication == null || authentication.getName().equals("anonymousUser")) {
            return null;
        }
        return userService.findByUsername(authentication.getName());
    }

    @GetMapping({"/respondent/surveys", "/guest/surveys"})
    public String listSurveys(Model model) {
        model.addAttribute("surveys", respondentService.getAllSurveys());
        return "respondent/surveys";
    }

    @GetMapping({"/respondent/survey/{id}", "/guest/survey/{id}"})
    public String takeSurvey(@PathVariable Long id, Model model, Authentication authentication) {
        Survey survey = respondentService.getSurveyById(id);
        User user = getCurrentUser(authentication);
        
        if (survey.isRequiresAuth() && user == null) {
            return "redirect:/login?required";
        }
        
        model.addAttribute("survey", survey);
        return "respondent/take_survey";
    }

    @PostMapping({"/respondent/survey/{id}/submit", "/guest/survey/{id}/submit"})
    public String submitSurvey(@PathVariable Long id, 
                               @RequestParam(required = false) String guestEmail,
                               HttpServletRequest request,
                               Authentication authentication) {
        Survey survey = respondentService.getSurveyById(id);
        User user = getCurrentUser(authentication);
        
        if (survey.isRequiresAuth() && user == null) {
            return "redirect:/login?required";
        }
        
        Map<Long, Long> answers = new HashMap<>();
        for (com.coursepulse.model.Question question : survey.getQuestions()) {
            String paramName = "question_" + question.getId();
            String optionIdStr = request.getParameter(paramName);
            if (optionIdStr != null) {
                answers.put(question.getId(), Long.valueOf(optionIdStr));
            }
        }
        
        respondentService.submitResponse(id, user, guestEmail, answers);
        
        if(user == null) {
            return "redirect:/guest/surveys?success";
        } else {
            return "redirect:/respondent/surveys?success";
        }
    }
}
