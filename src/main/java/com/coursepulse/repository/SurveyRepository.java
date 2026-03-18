package com.coursepulse.repository;

import com.coursepulse.model.Survey;
import com.coursepulse.model.Course;
import com.coursepulse.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface SurveyRepository extends JpaRepository<Survey, Long> {
    List<Survey> findByCourse(Course course);
    List<Survey> findByInitiator(User initiator);
}
