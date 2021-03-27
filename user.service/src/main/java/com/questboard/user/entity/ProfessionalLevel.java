package com.questboard.user.entity;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

@Table("professional_level")
public class ProfessionalLevel {
    @Id
    private Integer id;
    @Column("user_id")
    private Integer userId;
    @Column("lvl")
    private Integer level;
    @Column("exp")
    private Integer exp;
    @Column("title")
    private String title;
    @Column("skillset_profile_id")
    private Integer skillsetProfileId;

    public ProfessionalLevel() {
    }

    public ProfessionalLevel(Integer id, Integer userId, Integer level, Integer exp, String title, Integer skillsetProfileId) {
        this.id = id;
        this.userId = userId;
        this.level = level;
        this.exp = exp;
        this.title = title;
        this.skillsetProfileId = skillsetProfileId;
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

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public Integer getExp() {
        return exp;
    }

    public void setExp(Integer exp) {
        this.exp = exp;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getSkillsetProfileId() {
        return skillsetProfileId;
    }

    public void setSkillsetProfileId(Integer skillsetProfileId) {
        this.skillsetProfileId = skillsetProfileId;
    }

    public void levelUp() {
        this.level += 1;
    }
}
