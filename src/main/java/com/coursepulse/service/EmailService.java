package com.coursepulse.service;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    private final JavaMailSender emailSender;

    public EmailService(JavaMailSender emailSender) {
        this.emailSender = emailSender;
    }

    public void sendConfirmationEmail(String to, String surveyTitle) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom("noreply@coursepulse.com");
            message.setTo(to);
            message.setSubject("Survey Submission Confirmation");
            message.setText("Thank you for submitting your responses for the survey: " + surveyTitle);
            emailSender.send(message);
        } catch (Exception e) {
            System.err.println("Failed to send email to " + to + ": " + e.getMessage());
        }
    }
}
