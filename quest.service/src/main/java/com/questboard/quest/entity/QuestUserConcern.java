package com.questboard.quest.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;
@Table("quest_user_concern")
public class QuestUserConcern {
    @Id
    private Integer id;
    @Column("context")
    private String context;
    @Column("concern_validation")
    private String concernValidation;
    @Column("quest_id")
    private Integer questId;
    @Column("created_date")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createdDate;
    @Column("updated_date")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updatedDate;

    public QuestUserConcern(Integer id, String context, String concernValidation, Integer questId,
                            LocalDateTime createdDate, LocalDateTime updatedDate) {
        this.id = id;
        this.context = context;
        this.concernValidation = concernValidation;
        this.questId = questId;
        this.createdDate = createdDate;
        this.updatedDate = updatedDate;
    }

    public QuestUserConcern() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getContext() {
        return context;
    }

    public void setContext(String context) {
        this.context = context;
    }

    public String getConcernValidation() {
        return concernValidation;
    }

    public void setConcernValidation(String concernValidation) {
        this.concernValidation = concernValidation;
    }

    public Integer getQuestId() {
        return questId;
    }

    public void setQuestId(Integer questId) {
        this.questId = questId;
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
