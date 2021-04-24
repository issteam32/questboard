package com.questboard.reward.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;

@Data
@Table("reward")
public class Reward {
    @Id
    private Integer id;
    @Column("quest_id")
    private Integer questId;
    @Column("quest_giver")
    private String questGiver;
    @Column("quest_taker")
    private String questTaker;
    @Column("initial_amount")
    private Double initialAmount;
    @Column("proposed_amount")
    private Double proposedAmount;
    @Column("status")
    private Integer status;
    @Column("created_date")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createdDate;
    @Column("created_date")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updatedDate;

    public Reward() {
    }

    public Reward(Integer id, Integer questId, String questGiver, String questTaker, Double initialAmount,
                  Double proposedAmount, Integer status, LocalDateTime createdDate, LocalDateTime updatedDate) {
        this.id = id;
        this.questId = questId;
        this.questGiver = questGiver;
        this.questTaker = questTaker;
        this.initialAmount = initialAmount;
        this.proposedAmount = proposedAmount;
        this.status = status;
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

    public String getQuestGiver() {
        return questGiver;
    }

    public void setQuestGiver(String questGiver) {
        this.questGiver = questGiver;
    }

    public String getQuestTaker() {
        return questTaker;
    }

    public void setQuestTaker(String questTaker) {
        this.questTaker = questTaker;
    }

    public Double getInitialAmount() {
        return initialAmount;
    }

    public void setInitialAmount(Double initialAmount) {
        this.initialAmount = initialAmount;
    }

    public Double getProposedAmount() {
        return proposedAmount;
    }

    public void setProposedAmount(Double proposedAmount) {
        this.proposedAmount = proposedAmount;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
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
        return "Reward{" +
                "id=" + id +
                ", questId=" + questId +
                ", questGiver='" + questGiver + '\'' +
                ", questTaker='" + questTaker + '\'' +
                ", initialAmount=" + initialAmount +
                ", proposedAmount=" + proposedAmount +
                ", status=" + status +
                ", createdDate=" + createdDate +
                ", updatedDate=" + updatedDate +
                '}';
    }
}
