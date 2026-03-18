package com.coursepulse;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import com.coursepulse.model.Role;
import com.coursepulse.model.User;
import com.coursepulse.repository.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.password.PasswordEncoder;

@SpringBootApplication
public class CoursePulseApplication {

    public static void main(String[] args) {
        SpringApplication.run(CoursePulseApplication.class, args);
    }

    @Bean
    public CommandLineRunner initAdmin(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        return args -> {
            if (userRepository.findByUsername("admin@coursepulse.com").isEmpty()) {
                User admin = new User();
                admin.setUsername("admin@coursepulse.com");
                admin.setPassword(passwordEncoder.encode("admin123"));
                admin.setFullName("System Administrator");
                admin.setRole(Role.ADMIN);
                admin.setEnabled(true);
                admin.setApproved(true);
                userRepository.save(admin);
            }
        };
    }

}
