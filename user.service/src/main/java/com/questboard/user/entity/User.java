package com.questboard.user.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;

@Table("app_user")
public class User {
    @Id
    private Integer id;
    @Column("username")
    private String userName;
    @Column("sso_uid")
    private String ssoUid;
    @Column("email")
    private String email;
    @Column("register_type")
    private int registerType;
    @Column("active")
    private Boolean active;
    @Column("created_date")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createdDate;
    @Column("updated_date")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updatedDate;

    public User() {
    }

    public User(Integer id, String userName, String ssoUid, String email, int registerType, Boolean active,
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
