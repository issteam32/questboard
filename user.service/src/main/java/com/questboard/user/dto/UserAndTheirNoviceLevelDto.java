package com.questboard.user.dto;

import com.questboard.user.entity.NoviceLevel;
import com.questboard.user.entity.User;

public class UserAndTheirNoviceLevelDto {
    User user;
    NoviceLevel noviceLevel;

    public UserAndTheirNoviceLevelDto(User user, NoviceLevel noviceLevel) {
        this.user = user;
        this.noviceLevel = noviceLevel;
    }

    public UserAndTheirNoviceLevelDto() {
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public NoviceLevel getNoviceLevel() {
        return noviceLevel;
    }

    public void setNoviceLevel(NoviceLevel noviceLevel) {
        this.noviceLevel = noviceLevel;
    }
}
