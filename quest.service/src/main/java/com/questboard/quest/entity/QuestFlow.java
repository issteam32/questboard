package com.questboard.quest.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;

@Table("quest_flow")
public class QuestFlow {
    @Id
    private Integer id;
    @Column("quest_id")
    private Integer questId;
    @Column("stage")
    private Integer stage;
    @Column("requestor_remarks")
    private String requestorRemarks;
    @Column("taker_remarks")
    private String takerRemarks;
    @Column("created_date")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createdDate;
    @Column("updated_date")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updatedDate;

    public QuestFlow(Integer id, Integer questId, Integer stage, String requestorRemarks, String takerRemarks,
                     LocalDateTime createdDate, LocalDateTime updatedDate) {
        this.id = id;
        this.questId = questId;
        this.stage = stage;
        this.requestorRemarks = requestorRemarks;
        this.takerRemarks = takerRemarks;
        this.createdDate = createdDate;
        this.updatedDate = updatedDate;
    }

    public QuestFlow() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }


    public Integer getStage() {
        return stage;
    }

    public void setStage(Integer stage) {
        this.stage = stage;
    }

    public String getRequestorRemarks() {
        return requestorRemarks;
    }

    public void setRequestorRemarks(String requestorRemarks) {
        this.requestorRemarks = requestorRemarks;
    }

    public String getTakerRemarks() {
        return takerRemarks;
    }

    public void setTakerRemarks(String takerRemarks) {
        this.takerRemarks = takerRemarks;
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

    public Integer getQuestId() {
        return questId;
    }

    public void setQuestId(Integer questId) {
        this.questId = questId;
    }
}
