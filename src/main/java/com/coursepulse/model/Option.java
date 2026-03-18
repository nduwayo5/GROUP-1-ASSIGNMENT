package com.coursepulse.model;

import jakarta.persistence.*;

@Entity
@Table(name = "options")
public class Option {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String text;
    
    @ManyToOne
    @JoinColumn(name = "question_id", nullable = false)
    private Question question;

    public Option() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getText() { return text; }
    public void setText(String text) { this.text = text; }

    public Question getQuestion() { return question; }
    public void setQuestion(Question question) { this.question = question; }
}
