package com.coursepulse.controller;

import com.coursepulse.model.User;
import com.coursepulse.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.core.Authentication;

@Controller
public class AuthController {
    
    private final UserService userService;
    
    public AuthController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/")
    public String index() {
        return "index";
    }

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }
    
    @GetMapping("/register")
    public String registerPage(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }
    
    @PostMapping("/register")
    public String processRegister(@ModelAttribute("user") User user, Model model) {
        try {
            userService.registerUser(user);
            return "redirect:/login?registered";
        } catch (Exception e) {
            model.addAttribute("error", "Registration failed: username might already exist.");
            return "register";
        }
    }
    
    @GetMapping("/dashboard")
    public String dashboard(Authentication authentication) {
        if (authentication == null) return "redirect:/login";
        String role = authentication.getAuthorities().iterator().next().getAuthority();
        switch (role) {
            case "ADMIN":
                return "redirect:/admin/dashboard";
            case "INITIATOR":
                return "redirect:/initiator/dashboard";
            case "TEACHER":
                return "redirect:/teacher/dashboard";
            case "RESPONDENT":
                return "redirect:/respondent/surveys";
            default:
                return "redirect:/login";
        }
    }
}
