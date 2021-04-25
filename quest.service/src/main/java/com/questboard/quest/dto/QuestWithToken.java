package com.questboard.quest.dto;

import com.questboard.quest.entity.Quest;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;

public class QuestWithToken {
    private Quest quest;
    private String token;

    public QuestWithToken(Quest quest, String token) {
        this.quest = quest;
        this.token = token;
    }

    public QuestWithToken() {
    }

    public Quest getQuest() {
        return quest;
    }

    public void setQuest(Quest quest) {
        this.quest = quest;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }
}
