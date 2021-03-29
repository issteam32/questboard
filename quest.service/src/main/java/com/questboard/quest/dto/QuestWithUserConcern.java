package com.questboard.quest.dto;

import com.questboard.quest.entity.Quest;
import com.questboard.quest.entity.QuestUserConcern;

import java.util.ArrayList;
import java.util.List;

public class QuestWithUserConcern {
    private Quest quest;
    private List<QuestUserConcern> questUserConcernList;

    public QuestWithUserConcern(Quest quest, List<QuestUserConcern> questUserConcern) {
        this.quest = quest;
        this.questUserConcernList = questUserConcern;
    }

    public QuestWithUserConcern() {
    }

    public Quest getQuest() {
        return quest;
    }

    public void setQuest(Quest quest) {
        this.quest = quest;
    }

    public List<QuestUserConcern> getQuestUserConcern() {
        return questUserConcernList;
    }

    public void setQuestUserConcern(List<QuestUserConcern> questUserConcern) {
        this.questUserConcernList = questUserConcern;
    }

    public void pushQuestUserConcern(QuestUserConcern questUserConcern) {
        if (questUserConcernList.isEmpty()) {
            questUserConcernList = new ArrayList<>();
        }
        questUserConcernList.add(questUserConcern);
    }
}
