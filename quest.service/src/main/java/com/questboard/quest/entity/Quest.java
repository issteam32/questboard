package com.questboard.quest.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;

@Table("quest")
public class Quest {
    @Id
    private Integer id;

    @Column("title")
    private String title;

    @Column("description")
    private String description;

    @Column("category")
    private Integer category;

    @Column("skill_required")
    private String skillRequired;

    @Column("location")
    private String location;

    @Column("difficulty_level")
    private Integer difficultyLevel;

    @Column("status")
    private String status;

    @Column("awarded")
    private Boolean awarded;

    @Column("requestor")
    private Integer requestor;

    @Column("reward_type")
    private Integer rewardType;

    @Column("reward")
    private String reward;

    @Column("awarded_to")
    private Integer awardedTo;

    @Column("created_date")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createdDate;

    @Column("updated_date")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updatedDate;


    public Quest(Integer id, String title, String description, Integer category, String location, Integer difficultyLevel,
                 String status, Boolean awarded, Integer requestor, Integer rewardType, String reward, Integer awardedTo,
                 LocalDateTime createdDate, LocalDateTime updatedDate) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.category = category;
        this.location = location;
        this.difficultyLevel = difficultyLevel;
        this.status = status;
        this.awarded = awarded;
        this.requestor = requestor;
        this.rewardType = rewardType;
        this.reward = reward;
        this.awardedTo = awardedTo;
        this.createdDate = createdDate;
        this.updatedDate = updatedDate;
    }

    public Quest() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getCategory() {
        return category;
    }

    public void setCategory(Integer category) {
        this.category = category;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Integer getDifficultyLevel() {
        return difficultyLevel;
    }

    public void setDifficultyLevel(Integer difficultyLevel) {
        this.difficultyLevel = difficultyLevel;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Boolean getAwarded() {
        return awarded;
    }

    public void setAwarded(Boolean awarded) {
        this.awarded = awarded;
    }

    public Integer getRequestor() {
        return requestor;
    }

    public void setRequestor(Integer requestor) {
        this.requestor = requestor;
    }

    public Integer getRewardType() {
        return rewardType;
    }

    public void setRewardType(Integer rewardType) {
        this.rewardType = rewardType;
    }

    public String getReward() {
        return reward;
    }

    public void setReward(String reward) {
        this.reward = reward;
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

    public Integer getAwardedTo() {
        return awardedTo;
    }

    public void setAwardedTo(Integer awardedTo) {
        this.awardedTo = awardedTo;
    }

    public String getSkillRequired() {
        return skillRequired;
    }

    public void setSkillRequired(String skillRequired) {
        this.skillRequired = skillRequired;
    }
}
