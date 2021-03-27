package com.questboard.user.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;

@Table("social_account")
public class SocialAccount {

    @Id
    Integer id;

    @Column("social_account")
    Integer socialPlatform;

    @Column("social_acct_link")
    String socialAcctLink;

    @Column("user_id")
    Integer userId;

    @Column("created_date")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createdDate;

    @Column("updated_date")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updatedDate;

    public SocialAccount() {
    }

    public SocialAccount(Integer id, Integer socialPlatform, String socialAcctLink, Integer userId, LocalDateTime createdDate, LocalDateTime updatedDate) {
        this.id = id;
        this.socialPlatform = socialPlatform;
        this.socialAcctLink = socialAcctLink;
        this.userId = userId;
        this.createdDate = createdDate;
        this.updatedDate = updatedDate;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getSocialPlatform() {
        return socialPlatform;
    }

    public void setSocialPlatform(Integer socialPlatform) {
        this.socialPlatform = socialPlatform;
    }

    public String getSocialAcctLink() {
        return socialAcctLink;
    }

    public void setSocialAcctLink(String socialAcctLink) {
        this.socialAcctLink = socialAcctLink;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
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
