package com.coursepulse.controller;

import com.coursepulse.model.Course;
import com.coursepulse.model.Role;
import com.coursepulse.service.AdminService;
import com.coursepulse.service.InitiatorService;
import com.coursepulse.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private final AdminService adminService;
    private final UserService userService;
    private final InitiatorService initiatorService;

    public AdminController(AdminService adminService, UserService userService, InitiatorService initiatorService) {
        this.adminService = adminService;
        this.userService = userService;
        this.initiatorService = initiatorService;
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        model.addAttribute("totalStudents", userService.getCountByRole(Role.RESPONDENT));
        model.addAttribute("totalTeachers", userService.getCountByRole(Role.TEACHER));
        model.addAttribute("totalInitiators", userService.getCountByRole(Role.INITIATOR));
        model.addAttribute("totalCourses", adminService.getTotalCourses());
        model.addAttribute("totalSurveys", initiatorService.getTotalSurveysCount());
        model.addAttribute("pendingApprovals", userService.getPendingTeacherCount());
        return "admin/dashboard";
    }

    @GetMapping("/teachers/pending")
    public String pendingTeachers(Model model) {
        model.addAttribute("pendingTeachers", userService.getPendingTeachers());
        return "admin/teachers_pending";
    }

    @PostMapping("/approve/{id}")
    public String approveTeacher(@PathVariable Long id) {
        userService.approveTeacher(id);
        return "redirect:/admin/teachers/pending?approved";
    }

    @GetMapping("/courses")
    public String manageCourses(Model model) {
        model.addAttribute("courses", adminService.getAllCourses());
        model.addAttribute("newCourse", new Course());
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

    @GetMapping("/courses/assign")
    public String assignTeachersForm(Model model) {
        model.addAttribute("courses", adminService.getAllCourses());
        model.addAttribute("teachers", userService.findAllByRole(Role.TEACHER));
        return "admin/assign_teachers";
    }

    @PostMapping("/courses/assign")
    public String assignTeacher(@RequestParam Long teacherId, @RequestParam Long courseId) {
        adminService.assignTeacherToCourse(teacherId, courseId);
        return "redirect:/admin/courses/assign?assigned";
    }
    
    @PostMapping("/courses/unassign")
    public String unassignTeacher(@RequestParam Long teacherId, @RequestParam Long courseId) {
        adminService.removeTeacherFromCourse(teacherId, courseId);
        return "redirect:/admin/courses/assign?unassigned";
    }

    @GetMapping("/users")
    public String manageUsers(Model model) {
        model.addAttribute("users", adminService.getAllUsers());
        return "admin/users";
    }

    @GetMapping("/surveys")
    public String viewAllSurveys(Model model) {
        model.addAttribute("surveys", initiatorService.getAllSurveys());
        return "admin/surveys";
    }
}
