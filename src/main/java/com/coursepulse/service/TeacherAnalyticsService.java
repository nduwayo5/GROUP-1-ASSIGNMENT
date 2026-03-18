package com.coursepulse.service;

import com.coursepulse.model.*;
import com.coursepulse.repository.*;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class TeacherAnalyticsService {

    private final SurveyRepository surveyRepository;
    private final SurveyResponseRepository responseRepository;

    public TeacherAnalyticsService(SurveyRepository surveyRepository, 
                                 SurveyResponseRepository responseRepository) {
        this.surveyRepository = surveyRepository;
        this.responseRepository = responseRepository;
    }

    public Map<String, Object> getDashboardMetrics(User teacher) {
        Map<String, Object> metrics = new HashMap<>();
        
        Set<Course> courses = teacher.getCourses();
        List<Survey> allSurveys = getSurveysForCourses(courses);
        List<SurveyResponse> allResponses = getAllResponsesForSurveys(allSurveys);
        
        metrics.put("totalCourses", courses.size());
        metrics.put("totalSurveys", allSurveys.size());
        metrics.put("totalResponses", allResponses.size());
        metrics.put("averageResponseRate", calculateAverageResponseRate(allSurveys));
        metrics.put("recentActivity", getRecentActivity(allResponses));
        metrics.put("coursePerformance", getCoursePerformanceMetrics(courses, allSurveys));
        
        return metrics;
    }

    public Map<String, Object> getSurveyAnalytics(Long surveyId) {
        Survey survey = surveyRepository.findById(surveyId).orElseThrow();
        List<SurveyResponse> responses = responseRepository.findBySurvey(survey);
        
        Map<String, Object> analytics = new HashMap<>();
        analytics.put("survey", survey);
        analytics.put("totalResponses", responses.size());
        analytics.put("responseRate", calculateResponseRate(survey, responses.size()));
        analytics.put("questionAnalytics", getQuestionAnalytics(survey, responses));
        analytics.put("responseTrend", getResponseTrend(responses));
        analytics.put("summaryMetrics", getSummaryMetrics(survey, responses));
        
        return analytics;
    }

    public Map<String, Object> getCourseComparisonAnalytics(User teacher) {
        Set<Course> courses = teacher.getCourses();
        Map<String, Object> comparison = new HashMap<>();
        
        List<Map<String, Object>> courseMetrics = new ArrayList<>();
        for (Course course : courses) {
            List<Survey> courseSurveys = surveyRepository.findByCourse(course);
            List<SurveyResponse> courseResponses = getAllResponsesForSurveys(courseSurveys);
            
            Map<String, Object> courseData = new HashMap<>();
            courseData.put("course", course);
            courseData.put("surveyCount", courseSurveys.size());
            courseData.put("responseCount", courseResponses.size());
            courseData.put("averageRating", calculateAverageRating(courseSurveys));
            courseData.put("responseRate", calculateAverageResponseRate(courseSurveys));
            
            courseMetrics.add(courseData);
        }
        
        comparison.put("courses", courseMetrics);
        comparison.put("departmentAverage", calculateDepartmentAverage());
        
        return comparison;
    }

    private List<Survey> getSurveysForCourses(Set<Course> courses) {
        List<Survey> surveys = new ArrayList<>();
        for (Course course : courses) {
            surveys.addAll(surveyRepository.findByCourse(course));
        }
        return surveys;
    }

    private List<SurveyResponse> getAllResponsesForSurveys(List<Survey> surveys) {
        List<SurveyResponse> responses = new ArrayList<>();
        for (Survey survey : surveys) {
            responses.addAll(responseRepository.findBySurvey(survey));
        }
        return responses;
    }

    private Double calculateAverageResponseRate(List<Survey> surveys) {
        if (surveys.isEmpty()) return 0.0;
        
        double totalRate = 0.0;
        int surveyCount = 0;
        
        for (Survey survey : surveys) {
            List<SurveyResponse> responses = responseRepository.findBySurvey(survey);
            double rate = calculateResponseRate(survey, responses.size());
            if (rate > 0) {
                totalRate += rate;
                surveyCount++;
            }
        }
        
        return surveyCount > 0 ? totalRate / surveyCount : 0.0;
    }

    private Double calculateResponseRate(Survey survey, int responseCount) {
        // Estimate potential respondents (could be enhanced with actual enrollment data)
        int estimatedRespondents = 50; // Default estimate
        return estimatedRespondents > 0 ? (double) responseCount / estimatedRespondents * 100 : 0.0;
    }

    private List<Map<String, Object>> getRecentActivity(List<SurveyResponse> responses) {
        return responses.stream()
            .sorted((r1, r2) -> r2.getSubmittedAt().compareTo(r1.getSubmittedAt()))
            .limit(5)
            .map(response -> {
                Map<String, Object> activity = new HashMap<>();
                activity.put("surveyTitle", response.getSurvey().getTitle());
                activity.put("courseName", response.getSurvey().getCourse().getName());
                activity.put("submissionDate", response.getSubmittedAt());
                activity.put("responseId", response.getId());
                return activity;
            })
            .collect(Collectors.toList());
    }

    private Map<String, Object> getCoursePerformanceMetrics(Set<Course> courses, List<Survey> surveys) {
        Map<String, Object> performance = new HashMap<>();
        
        for (Course course : courses) {
            List<Survey> courseSurveys = surveys.stream()
                .filter(s -> s.getCourse().equals(course))
                .collect(Collectors.toList());
            
            Map<String, Object> courseMetrics = new HashMap<>();
            courseMetrics.put("surveyCount", courseSurveys.size());
            courseMetrics.put("averageRating", calculateAverageRating(courseSurveys));
            
            performance.put(course.getCode(), courseMetrics);
        }
        
        return performance;
    }

    private Double calculateAverageRating(List<Survey> surveys) {
        if (surveys.isEmpty()) return 0.0;
        
        double totalRating = 0.0;
        int ratingCount = 0;
        
        for (Survey survey : surveys) {
            List<SurveyResponse> responses = responseRepository.findBySurvey(survey);
            for (SurveyResponse response : responses) {
                double responseRating = calculateResponseRating(response);
                if (responseRating > 0) {
                    totalRating += responseRating;
                    ratingCount++;
                }
            }
        }
        
        return ratingCount > 0 ? totalRating / ratingCount : 0.0;
    }

    private Double calculateResponseRating(SurveyResponse response) {
        double totalScore = 0.0;
        int questionCount = 0;
        
        for (ResponseAnswer answer : response.getAnswers()) {
            if (answer.getSelectedOption() != null) {
                // Since Option doesn't have a score field, we'll assign scores based on option position
                // This could be enhanced by adding a score field to Option entity
                totalScore += 1.0; // Default score for now
                questionCount++;
            }
        }
        
        return questionCount > 0 ? totalScore / questionCount : 0.0;
    }

    private Map<String, Object> getQuestionAnalytics(Survey survey, List<SurveyResponse> responses) {
        Map<String, Object> questionAnalytics = new HashMap<>();
        
        for (Question question : survey.getQuestions()) {
            Map<String, Integer> optionCounts = new HashMap<>();
            Map<String, Object> questionData = new HashMap<>();
            
            // Count responses for each option
            for (SurveyResponse response : responses) {
                for (ResponseAnswer answer : response.getAnswers()) {
                    if (answer.getQuestion().equals(question) && answer.getSelectedOption() != null) {
                        String optionText = answer.getSelectedOption().getText();
                        optionCounts.put(optionText, optionCounts.getOrDefault(optionText, 0) + 1);
                    }
                }
            }
            
            questionData.put("questionText", question.getText());
            questionData.put("optionCounts", optionCounts);
            questionData.put("totalResponses", optionCounts.values().stream().mapToInt(Integer::intValue).sum());
            
            // Calculate percentages
            Map<String, Double> optionPercentages = new HashMap<>();
            int totalOptionResponses = optionCounts.values().stream().mapToInt(Integer::intValue).sum();
            if (totalOptionResponses > 0) {
                for (Map.Entry<String, Integer> entry : optionCounts.entrySet()) {
                    optionPercentages.put(entry.getKey(), 
                        (double) entry.getValue() / totalOptionResponses * 100);
                }
            }
            questionData.put("optionPercentages", optionPercentages);
            
            questionAnalytics.put("question_" + question.getId(), questionData);
        }
        
        return questionAnalytics;
    }

    private Map<String, Object> getResponseTrend(List<SurveyResponse> responses) {
        Map<String, Object> trend = new HashMap<>();
        
        // Group responses by date
        Map<String, Integer> dailyResponses = new HashMap<>();
        for (SurveyResponse response : responses) {
            String date = response.getSubmittedAt().toLocalDate().toString();
            dailyResponses.put(date, dailyResponses.getOrDefault(date, 0) + 1);
        }
        
        trend.put("dailyResponses", dailyResponses);
        trend.put("peakDay", dailyResponses.entrySet().stream()
            .max(Map.Entry.comparingByValue())
            .map(Map.Entry::getKey)
            .orElse(null));
        
        return trend;
    }

    private Map<String, Object> getSummaryMetrics(Survey survey, List<SurveyResponse> responses) {
        Map<String, Object> summary = new HashMap<>();
        
        summary.put("averageCompletionTime", calculateAverageCompletionTime(responses));
        summary.put("satisfactionScore", calculateSatisfactionScore(responses));
        summary.put("participationTrend", "increasing"); // Could be calculated based on historical data
        
        return summary;
    }

    private Double calculateAverageCompletionTime(List<SurveyResponse> responses) {
        // Placeholder - would need timestamp data for actual calculation
        return 15.5; // Average minutes
    }

    private Double calculateSatisfactionScore(List<SurveyResponse> responses) {
        double totalScore = 0.0;
        int responseCount = 0;
        
        for (SurveyResponse response : responses) {
            double score = calculateResponseRating(response);
            if (score > 0) {
                totalScore += score;
                responseCount++;
            }
        }
        
        return responseCount > 0 ? (totalScore / responseCount) * 20 : 0.0; // Scale to 0-100
    }

    private Double calculateDepartmentAverage() {
        // Placeholder - would calculate across all teachers in department
        return 75.5;
    }
}
