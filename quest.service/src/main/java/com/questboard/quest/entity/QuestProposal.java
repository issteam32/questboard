package com.questboard.quest.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;

@Table("quest_proposal")
public class QuestProposal {
    @Id
    private Integer id;
    @Column("quest_id")
    private Integer questId;
    @Column("username")
    private String username;
    @Column("proposal_json")
    private String proposalJson;
    @Column("proposal_details")
    private String proposalDetails;
    @Column("proposal_score")
    private Double proposalScore;
    @Column("created_date")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createdDate;

    @Column("updated_date")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updatedDate;

    public QuestProposal(Integer id, Integer questId, String username, String proposalJson, String proposalDetails,
                         Double proposalScore, LocalDateTime createdDate, LocalDateTime updatedDate) {
        this.id = id;
        this.questId = questId;
        this.username = username;
        this.proposalJson = proposalJson;
        this.proposalDetails = proposalDetails;
        this.proposalScore = proposalScore;
        this.createdDate = createdDate;
        this.updatedDate = updatedDate;
    }

    public QuestProposal() {
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

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getProposalJson() {
        return proposalJson;
    }

    public void setProposalJson(String proposalJson) {
        this.proposalJson = proposalJson;
    }

    public String getProposalDetails() {
        return proposalDetails;
    }

    public void setProposalDetails(String proposalDetails) {
        this.proposalDetails = proposalDetails;
    }

    public Double getProposalScore() {
        return proposalScore;
    }

    public void setProposalScore(Double proposalScore) {
        this.proposalScore = proposalScore;
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
}
