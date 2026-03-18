package com.coursepulse.service;

import com.coursepulse.model.*;
import com.coursepulse.repository.*;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class InitiatorService {
    private final SurveyRepository surveyRepository;
    private final QuestionRepository questionRepository;
    private final OptionRepository optionRepository;
    private final SurveyResponseRepository responseRepository;
    private final CourseRepository courseRepository;
    
    public InitiatorService(SurveyRepository surveyRepository, QuestionRepository questionRepository, 
                            OptionRepository optionRepository, SurveyResponseRepository responseRepository,
                            CourseRepository courseRepository) {
        this.surveyRepository = surveyRepository;
        this.questionRepository = questionRepository;
        this.optionRepository = optionRepository;
        this.responseRepository = responseRepository;
        this.courseRepository = courseRepository;
    }
    
    public List<Survey> getSurveysByInitiator(User initiator) {
        return surveyRepository.findByInitiator(initiator);
    }
    
    public void createSurvey(Survey survey) {
        surveyRepository.save(survey);
    }
    
    public Survey getSurveyById(Long id) {
        return surveyRepository.findById(id).orElseThrow();
    }
    
    public void deleteSurvey(Long id) {
        surveyRepository.deleteById(id);
    }
    
    public void addQuestionToSurvey(Long surveyId, Question question) {
        Survey survey = getSurveyById(surveyId);
        question.setSurvey(survey);
        questionRepository.save(question);
    }
    
    public void addOptionToQuestion(Long questionId, Option option) {
        Question question = questionRepository.findById(questionId).orElseThrow();
        option.setQuestion(question);
        optionRepository.save(option);
    }

    public List<Course> getAllCourses() {
        return courseRepository.findAll();
    }
    
    public List<SurveyResponse> getSurveyResults(Long surveyId) {
        Survey survey = getSurveyById(surveyId);
        return responseRepository.findBySurvey(survey);
    }

    public List<Survey> getAllSurveys() {
        return surveyRepository.findAll();
    }

    public long getTotalSurveysCount() {
        return surveyRepository.count();
    }
}
