package com.questboard.quest.dto;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.time.LocalDateTime;

@JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.ANY)
public class UserDto {
    private Integer id;
    private String userName;
    private String ssoUid;
    private String email;
    private int registerType;
    private Boolean active;
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createdDate;
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updatedDate;

    public UserDto() {
    }

    public UserDto(Integer id, String userName, String ssoUid, String email, int registerType, Boolean active,
                LocalDateTime createdDate, LocalDateTime updatedDate) {
        this.id = id;
        this.userName = userName;
        this.ssoUid = ssoUid;
        this.email = email;
        this.registerType = registerType;
        this.active = active;
        this.createdDate = createdDate;
        this.updatedDate = updatedDate;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getSsoUid() {
        return ssoUid;
    }

    public void setSsoUid(String ssoUid) {
        this.ssoUid = ssoUid;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getRegisterType() {
        return registerType;
    }

    public void setRegisterType(int registerType) {
        this.registerType = registerType;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
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
