package com.questboard.user.dto;

import com.questboard.user.entity.SkillSetProfile;
import com.questboard.user.entity.User;

public class UserSkillSetProfileDto {
    User user;
    SkillSetProfileAndLevelDto skillSetProfile;

    public UserSkillSetProfileDto(User user, SkillSetProfileAndLevelDto skillSetProfile) {
        this.user = user;
        this.skillSetProfile = skillSetProfile;
    }

    public UserSkillSetProfileDto() {
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public SkillSetProfileAndLevelDto getSkillSetProfile() {
        return skillSetProfile;
    }

    public void setSkillSetProfile(SkillSetProfileAndLevelDto skillSetProfile) {
        this.skillSetProfile = skillSetProfile;
    }
}
