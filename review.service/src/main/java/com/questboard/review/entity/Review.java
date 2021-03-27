package com.questboard.review.entity;


import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;
import java.util.Date;

@Data
@Table("review")
public class Review {
    @Id
    private Integer review_id;
    private Integer quest_id;
    private Integer reviewer_id;
    private Integer quest_taker_id;
    private String review_msg;
    private LocalDateTime created_date;
    private LocalDateTime updated_date;
    private Integer last_update_id;

    public Review() {
    }

    public Review(Integer review_id, Integer quest_id, Integer reviewer_id, Integer quest_taker_id, String review_msg, LocalDateTime created_date, LocalDateTime updated_date, Integer last_update_id) {
        this.review_id = review_id;
        this.quest_id = quest_id;
        this.reviewer_id = reviewer_id;
        this.quest_taker_id = quest_taker_id;
        this.review_msg = review_msg;
        this.created_date = created_date;
        this.updated_date = updated_date;
        this.last_update_id = last_update_id;
    }

    public Integer getReview_id() {
        return review_id;
    }

    public void setReview_id(Integer review_id) {
        this.review_id = review_id;
    }

    public Integer getQuest_id() {
        return quest_id;
    }

    public void setQuest_id(Integer quest_id) {
        this.quest_id = quest_id;
    }

    public Integer getReviewer_id() {
        return reviewer_id;
    }

    public void setReviewer_id(Integer reviewer_id) {
        this.reviewer_id = reviewer_id;
    }

    public Integer getQuest_taker_id() {
        return quest_taker_id;
    }

    public void setQuest_taker_id(Integer quest_taker_id) {
        this.quest_taker_id = quest_taker_id;
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

    public Integer getLast_update_id() {
        return last_update_id;
    }

    public void setLast_update_id(Integer last_update_id) {
        this.last_update_id = last_update_id;
    }

    @Override
    public String toString() {
        return "ReviewEntity{" +
                "review_id=" + review_id +
                ", quest_id=" + quest_id +
                ", reviewer_id=" + reviewer_id +
                ", quest_taker_id=" + quest_taker_id +
                ", review_msg=" + review_msg +
                ", created_date=" + created_date +
                ", updated_date=" + updated_date +
                ", last_update_id=" + last_update_id +
                '}';
    }
}
