package com.coursepulse.service;

import com.coursepulse.model.Course;
import com.coursepulse.model.User;
import com.coursepulse.model.Role;
import com.coursepulse.repository.CourseRepository;
import com.coursepulse.repository.UserRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class AdminService {
    private final CourseRepository courseRepository;
    private final UserRepository userRepository;
    
    public AdminService(CourseRepository courseRepository, UserRepository userRepository) {
        this.courseRepository = courseRepository;
        this.userRepository = userRepository;
    }
    
    public List<Course> getAllCourses() {
        return courseRepository.findAll();
    }
    
    public void createCourse(Course course) {
        courseRepository.save(course);
    }
    
    public void deleteCourse(Long id) {
        courseRepository.deleteById(id);
    }
    
    public void assignTeacherToCourse(Long teacherId, Long courseId) {
        User teacher = userRepository.findById(teacherId).orElseThrow();
        Course course = courseRepository.findById(courseId).orElseThrow();
        
        if (teacher.getRole() == Role.TEACHER) {
            teacher.getCourses().add(course);
            userRepository.save(teacher);
        }
    }
    
    public void removeTeacherFromCourse(Long teacherId, Long courseId) {
        User teacher = userRepository.findById(teacherId).orElseThrow();
        Course course = courseRepository.findById(courseId).orElseThrow();
        teacher.getCourses().remove(course);
        userRepository.save(teacher);
    }
}
