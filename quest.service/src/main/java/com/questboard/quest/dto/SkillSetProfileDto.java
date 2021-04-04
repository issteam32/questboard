package com.questboard.quest.dto;

public class SkillSetProfileDto {
    private Integer userId;
    private String skill;
    private Integer level;
    private String title;
    private Integer skillEndorsed;

    public SkillSetProfileDto(Integer userId, String skill, Integer level, String title, Integer skillEndorsed) {
        this.userId = userId;
        this.skill = skill;
        this.level = level;
        this.title = title;
        this.skillEndorsed = skillEndorsed;
    }

    public SkillSetProfileDto() {
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

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getSkillEndorsed() {
        return skillEndorsed;
    }

    public void setSkillEndorsed(Integer skillEndorsed) {
        this.skillEndorsed = skillEndorsed;
    }
}
