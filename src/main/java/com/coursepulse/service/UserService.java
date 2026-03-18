package com.coursepulse.service;

import com.coursepulse.model.User;
import com.coursepulse.model.Role;
import com.coursepulse.repository.UserRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public void registerUser(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        
        if (user.getRole() == Role.TEACHER) {
            user.setApproved(false); // Needs admin approval
        } else {
            user.setApproved(true);
        }
        
        userRepository.save(user);
    }
    
    public User findByUsername(String username) {
        return userRepository.findByUsername(username).orElse(null);
    }
    
    public List<User> getPendingTeachers() {
        return userRepository.findByRoleAndApproved(Role.TEACHER, false);
    }
    
    public void approveTeacher(Long teacherId) {
        User teacher = userRepository.findById(teacherId).orElseThrow();
        teacher.setApproved(true);
        userRepository.save(teacher);
    }
    
    public List<User> findAllByRole(Role role) {
        return userRepository.findByRole(role);
    }
}
