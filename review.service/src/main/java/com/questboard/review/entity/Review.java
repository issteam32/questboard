package com.questboard.review.entity;


import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;

@Data
@Table("review")
public class Review {
    @Id
    private Integer id;
    private Integer quest_id;
    private String reviewer;
    private String quest_taker;
    private String review_msg;
    private LocalDateTime created_date;
    private LocalDateTime updated_date;

    public Review() {
    }

    public Review(Integer id, Integer quest_id, String reviewer, String quest_taker, String review_msg, LocalDateTime created_date, LocalDateTime updated_date) {
        this.id = id;
        this.quest_id = quest_id;
        this.reviewer = reviewer;
        this.quest_taker = quest_taker;
        this.review_msg = review_msg;
        this.created_date = created_date;
        this.updated_date = updated_date;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getQuest_id() {
        return quest_id;
    }

    public void setQuest_id(Integer quest_id) {
        this.quest_id = quest_id;
    }

    public String getReviewer() {
        return reviewer;
    }

    public void setReviewer(String reviewer) {
        this.reviewer = reviewer;
    }

    public String getQuest_taker() {
        return quest_taker;
    }

    public void setQuest_taker(String quest_taker) {
        this.quest_taker = quest_taker;
    }

    public String getReview_msg() {
        return review_msg;
    }

    public void setReview_msg(String review_msg) {
        this.review_msg = review_msg;
    }

    public LocalDateTime getCreated_date() {
        return created_date;
    }

    public void setCreated_date(LocalDateTime created_date) {
        this.created_date = created_date;
    }

    public LocalDateTime getUpdated_date() {
        return updated_date;
    }

    public void setUpdated_date(LocalDateTime updated_date) {
        this.updated_date = updated_date;
    }

    @Override
    public String toString() {
        return "ReviewEntity{" +
                "id=" + id +
                ", quest_id=" + quest_id +
                ", reviewer=" + reviewer +
                ", quest_taker=" + quest_taker +
                ", review_msg=" + review_msg +
                ", created_date=" + created_date +
                ", updated_date=" + updated_date +
                '}';
    }
}
