package com.coursepulse.service;

import com.coursepulse.model.*;
import com.coursepulse.repository.*;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class RespondentService {

    private final SurveyRepository surveyRepository;
    private final QuestionRepository questionRepository;
    private final OptionRepository optionRepository;
    private final SurveyResponseRepository surveyResponseRepository;
    private final EmailService emailService;

    public RespondentService(SurveyRepository surveyRepository, QuestionRepository questionRepository, 
                             OptionRepository optionRepository, SurveyResponseRepository surveyResponseRepository,
                             EmailService emailService) {
        this.surveyRepository = surveyRepository;
        this.questionRepository = questionRepository;
        this.optionRepository = optionRepository;
        this.surveyResponseRepository = surveyResponseRepository;
        this.emailService = emailService;
    }

    public List<Survey> getAllSurveys() {
        return surveyRepository.findAll();
    }

    public Survey getSurveyById(Long id) {
        return surveyRepository.findById(id).orElseThrow();
    }

    public void submitResponse(Long surveyId, User respondent, String guestEmail, Map<Long, Long> answers) {
        Survey survey = getSurveyById(surveyId);

        SurveyResponse response = new SurveyResponse();
        response.setSurvey(survey);
        
        if (respondent != null) {
            response.setRespondent(respondent);
            guestEmail = respondent.getUsername(); // Send to mapped username
        } else {
            response.setGuestEmail(guestEmail);
        }

        for (Map.Entry<Long, Long> entry : answers.entrySet()) {
            Long questionId = entry.getKey();
            Long optionId = entry.getValue();

            Question question = questionRepository.findById(questionId).orElseThrow();
            Option option = optionRepository.findById(optionId).orElseThrow();

            ResponseAnswer answer = new ResponseAnswer();
            answer.setSurveyResponse(response);
            answer.setQuestion(question);
            answer.setSelectedOption(option);

            response.getAnswers().add(answer);
        }

        surveyResponseRepository.save(response);

        if (guestEmail != null && !guestEmail.isEmpty()) {
            emailService.sendConfirmationEmail(guestEmail, survey.getTitle());
        }
    }
}
