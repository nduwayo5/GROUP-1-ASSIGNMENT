package com.coursepulse.repository;

import com.coursepulse.model.SurveyResponse;
import com.coursepulse.model.Survey;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface SurveyResponseRepository extends JpaRepository<SurveyResponse, Long> {
    List<SurveyResponse> findBySurvey(Survey survey);
}
