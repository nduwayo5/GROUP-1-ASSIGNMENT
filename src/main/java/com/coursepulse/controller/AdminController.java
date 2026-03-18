package com.coursepulse.controller;

import com.coursepulse.model.Course;
import com.coursepulse.model.Role;
import com.coursepulse.service.AdminService;
import com.coursepulse.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private final AdminService adminService;
    private final UserService userService;

    public AdminController(AdminService adminService, UserService userService) {
        this.adminService = adminService;
        this.userService = userService;
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        model.addAttribute("pendingTeachers", userService.getPendingTeachers());
        return "admin/dashboard";
    }

    @PostMapping("/approve/{id}")
    public String approveTeacher(@PathVariable Long id) {
        userService.approveTeacher(id);
        return "redirect:/admin/dashboard?approved";
    }

    @GetMapping("/courses")
    public String manageCourses(Model model) {
        model.addAttribute("courses", adminService.getAllCourses());
        model.addAttribute("newCourse", new Course());
        model.addAttribute("teachers", userService.findAllByRole(Role.TEACHER));
        return "admin/courses";
    }

    @PostMapping("/courses")
    public String createCourse(@ModelAttribute Course course) {
        adminService.createCourse(course);
        return "redirect:/admin/courses?added";
    }

    @PostMapping("/courses/delete/{id}")
    public String deleteCourse(@PathVariable Long id) {
        adminService.deleteCourse(id);
        return "redirect:/admin/courses?deleted";
    }

    @PostMapping("/courses/assign")
    public String assignTeacher(@RequestParam Long teacherId, @RequestParam Long courseId) {
        adminService.assignTeacherToCourse(teacherId, courseId);
        return "redirect:/admin/courses?assigned";
    }
    
    @PostMapping("/courses/unassign")
    public String unassignTeacher(@RequestParam Long teacherId, @RequestParam Long courseId) {
        adminService.removeTeacherFromCourse(teacherId, courseId);
        return "redirect:/admin/courses?unassigned";
    }
}
