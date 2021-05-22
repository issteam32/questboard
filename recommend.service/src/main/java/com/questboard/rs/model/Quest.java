package com.questboard.rs.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.*;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@ToString
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
public class Quest implements Serializable {
    private Integer id;
    private String title;
    private String description;
    private Integer category;
    private String categoryDesc;
    private String skillRequired;
    private String location;
    private Integer difficultyLevel;
    private String status;
    private Boolean awarded;
    private String requestor;
    private Integer rewardType;
    private String reward;
    private String awardedTo;
    private Boolean inQueue;
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createdDate;

    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updatedDate;
}
