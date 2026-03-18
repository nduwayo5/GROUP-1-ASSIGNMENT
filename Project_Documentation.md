# Course Evaluation Survey System - Project Documentation

## 1. Project Overview and Scenario
At the end of each academic term, institutions collect feedback from students to evaluate the quality of courses and teaching. 
This project is a web-based **Course Evaluation Survey System** designed to simplify this process. It enables authorized users to create structured surveys linked to specific courses, allowing participants to submit feedback asynchronously. The system enforces role-based access control, automates teacher assignments, and processes survey submissions while optionally maintaining respondent anonymity.

## 2. User Roles and System Functionalities
The system enforces strict Spring Security role-based access control (RBAC) across four distinct user levels:

### Administrator (`ADMIN`)
*   **Approval Workflow:** Registers and approves pending `Teacher` accounts.
*   **Course Management:** Creates, deletes, and manages academic courses via the `/admin/courses` endpoints.
*   **Assignments:** Assigns and mathematically links approved Teachers to specific Courses for evaluation.

### Survey Initiator (`INITIATOR`)
*   **Survey Design:** Creates surveys with titles, descriptions, and authentication requirements (`requires_auth`).
*   **Question Configuration:** Dynamically attaches questions and multi-choice options to surveys.
*   **Publishing & Results:** Views comprehensive insights and tallies responses for completed surveys.

### Teacher (`TEACHER`)
*   **View Metrics:** Views courses they are assigned to and reads completed evaluation feedback directly related to their teaching.

### Respondent / Student (`RESPONDENT` & `GUEST`)
*   **Guest Access:** Can view explicitly open/public surveys without authentication.
*   **Authenticated Access:** Registers as a Respondent to track participated surveys.
*   **Submission & Receipts:** Selects answers for survey questionnaires and receives an automated confirmation email post-submission.

## 3. System Architecture (Spring MVC Structure)
This project implements a robust layered **Spring MVC Architecture** backed by an Embedded Tomcat Server.

### Controller Layer (`com.coursepulse.controller`)
Intercepts HTTP requests, performs parameter validation, and delegates business logic. 
*   `AdminController`, `InitiatorController`, `AuthController`, etc.

### Service Layer (`com.coursepulse.service`)
Handles transactional logic and business rules. 
*   `UserService`: Handles BCrypt password hashing and user approval logic.
*   `EmailService`: Asynchronously dispatches SMTP confirmations.

### Data Access / Repository Layer (`com.coursepulse.repository`)
Interfaces securely extending Spring Data JPA's `JpaRepository` for dynamic database querying (e.g., `findByRoleAndApproved`).

### View Layer (`WEB-INF/jsp/`)
JavaServer Pages (JSP) using the Jakarta EE Standard Tag Library (JSTL) integrated with Spring Security taglibs to conditionally render UI components based on the authenticated user's role.

### Security (`SecurityConfig.java`)
Manages authentication chains, implements `BCryptPasswordEncoder`, handles CSRF, and dictates endpoint accessibility via `authorizeHttpRequests`.

## 4. Database Design and ERD
The system implements a fully relational Database defined by JPA Hibernate Entities.

### Entity Relationship (ERD Mapping)
1.  **`users`**: Core table housing all accounts, their BCrypt passwords, enabled states, and approval status.
2.  **`courses`**: Academic modules containing name and code mappings.
3.  **`teacher_courses`**: Many-to-Many join table physically linking `users` (where role=TEACHER) to `courses`.
4.  **`surveys`**: Master table belonging to a `Course` and created by an `Initiator` (User).
5.  **`questions`**: Direct Many-to-One children of `surveys`.
6.  **`options`**: Direct Many-to-One children of `questions`.
7.  **`survey_responses`**: Records a completed submission linked to a `Survey`, capturing timestamps and optional guest emails.
8.  **`response_answers`**: Connects a `survey_response` to specific `questions` and the exact `selected_option_id`.

## 5. Explanation of Key Modules and Features

*   **Embedded CommandLineRunner Bootstrapping:** Automatically injects a hidden, powerful Administrator account (`admin@coursepulse.com`) upon application startup, preventing the need for hardcoded public SQL scripts.
*   **Security Interception:** The system intelligently loops unauthenticated users to `/login` and blocks internal unauthorized HTTP `FORWARD` dispatches natively relying on Spring Security 6 specifications.
*   **SMTP Mail Confirmation:** Leverages Spring Boot Starter Mail (`JavaMailSender`) to ping Google SMTP servers asynchronously upon successful survey submission.
*   **Dynamic JSTL Rendering:** The frontend inherently blocks non-authenticated UI elements and seamlessly routes users (via `switch(role)`) to their designated dashboard post-login.

## 6. Screenshots of the Implemented System
*(Note: Replace the placeholders below by actually taking screenshots of your local running system and inserting the image files here)*

*   **1. Login & Registration:**
    *   `![Registration Page](images/register.png)`
    *   `![Login Page](images/login.png)`

*   **2. Admin Dashboard (Teacher Approvals):**
    *   `![Admin Approvals](images/admin-dashboard.png)`

*   **3. Admin Course Assignments:**
    *   `![Course Assignment Dropdown](images/course-assign.png)`

*   **4. Survey Initiator Dashboard (Question Building):**
    *   `![Survey Creation](images/create-survey.png)`

*   **5. Respondent Public View & Submission:**
    *   `![Taking a Survey](images/take-survey.png)`
