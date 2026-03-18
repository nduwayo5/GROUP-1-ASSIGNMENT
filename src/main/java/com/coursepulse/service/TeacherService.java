package com.coursepulse.service;

import com.coursepulse.model.Course;
import com.coursepulse.model.Survey;
import com.coursepulse.model.SurveyResponse;
import com.coursepulse.repository.SurveyRepository;
import com.coursepulse.repository.SurveyResponseRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@Service
public class TeacherService {

    private final SurveyRepository surveyRepository;
    private final SurveyResponseRepository responseRepository;

    public TeacherService(SurveyRepository surveyRepository, SurveyResponseRepository responseRepository) {
        this.surveyRepository = surveyRepository;
        this.responseRepository = responseRepository;
    }

    public List<Survey> getSurveysForCourses(Set<Course> courses) {
        List<Survey> allSurveys = new ArrayList<>();
        for (Course course : courses) {
            allSurveys.addAll(surveyRepository.findByCourse(course));
        }
        return allSurveys;
    }

    public Survey getSurveyById(Long surveyId) {
        return surveyRepository.findById(surveyId).orElseThrow();
    }

    public List<SurveyResponse> getSurveyResults(Long surveyId) {
        Survey survey = getSurveyById(surveyId);
        return responseRepository.findBySurvey(survey);
    }
}
