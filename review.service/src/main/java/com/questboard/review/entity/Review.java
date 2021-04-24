package com.questboard.review.entity;


import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;

@Data
@Table("review")
public class Review {
    @Id
    private Integer id;
    @Column("quest_id")
    private Integer questId;
    @Column("reviewer")
    private String reviewer;
    @Column("quest_taker")
    private String questTaker;
    @Column("review_msg")
    private String reviewMsg;
    @Column("created_date")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createdDate;
    @Column("updated_date")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updatedDate;

    public Review() {
    }

    public Review(Integer id, Integer questId, String reviewer, String questTaker, String reviewMsg, LocalDateTime createdDate, LocalDateTime updatedDate) {
        this.id = id;
        this.questId = questId;
        this.reviewer = reviewer;
        this.questTaker = questTaker;
        this.reviewMsg = reviewMsg;
        this.createdDate = createdDate;
        this.updatedDate = updatedDate;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getQuestId() {
        return questId;
    }

    public void setQuestId(Integer questId) {
        this.questId = questId;
    }

    public String getReviewer() {
        return reviewer;
    }

    public void setReviewer(String reviewer) {
        this.reviewer = reviewer;
    }

    public String getQuestTaker() {
        return questTaker;
    }

    public void setQuestTaker(String questTaker) {
        this.questTaker = questTaker;
    }

    public String getReviewMsg() {
        return reviewMsg;
    }

    public void setReviewMsg(String reviewMsg) {
        this.reviewMsg = reviewMsg;
    }

    public LocalDateTime getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(LocalDateTime createdDate) {
        this.createdDate = createdDate;
    }

    public LocalDateTime getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(LocalDateTime updatedDate) {
        this.updatedDate = updatedDate;
    }

    @Override
    public String toString() {
        return "Review{" +
                "id=" + id +
                ", questId=" + questId +
                ", reviewer='" + reviewer +
                ", questTaker='" + questTaker +
                ", reviewMsg='" + reviewMsg +
                ", createdDate=" + createdDate +
                ", updatedDate=" + updatedDate +
                '}';
    }
}