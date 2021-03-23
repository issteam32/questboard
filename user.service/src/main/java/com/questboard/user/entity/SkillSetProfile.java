package com.questboard.user.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;

@Table("skillset_profile")
public class SkillSetProfile {
    @Id
    private Integer id;
    @Column("user_id")
    private Integer userId;
    @Column("skill")
    private String skill;
    @Column("skill_desc")
    private String skillDesc;
    @Column("skill_endorsed")
    private Long skillEndorsed;
    @Column("display")
    private Boolean display;
    @Column("created_date")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createdDate;
    @Column("updated_date")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updatedDate;

    public SkillSetProfile() {
    }

    public SkillSetProfile(Integer id, Integer userId, String skill, String skillDesc, Long skillEndorsed,
                           Boolean display, LocalDateTime createdDate, LocalDateTime updatedDate) {
        this.id = id;
        this.userId = userId;
        this.skill = skill;
        this.skillDesc = skillDesc;
        this.skillEndorsed = skillEndorsed;
        this.display = display;
        this.createdDate = createdDate;
        this.updatedDate = updatedDate;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getSkill() {
        return skill;
    }

    public void setSkill(String skill) {
        this.skill = skill;
    }

    public String getSkillDesc() {
        return skillDesc;
    }

    public void setSkillDesc(String skillDesc) {
        this.skillDesc = skillDesc;
    }

    public Long getSkillEndorsed() {
        return skillEndorsed;
    }

    public void setSkillEndorsed(Long skillEndorsed) {
        this.skillEndorsed = skillEndorsed;
    }

    public Boolean getDisplay() {
        return display;
    }

    public void setDisplay(Boolean display) {
        this.display = display;
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
