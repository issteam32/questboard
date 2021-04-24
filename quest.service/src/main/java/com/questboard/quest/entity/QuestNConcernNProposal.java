package com.questboard.quest.entity;

import java.util.List;

public class QuestNConcernNProposal {
    private Quest quest;
    private List<QuestUserConcern> questUserConcern;
    private List<QuestProposal> questProposal;

    public QuestNConcernNProposal(Quest quest, List<QuestUserConcern> questUserConcern, List<QuestProposal> questProposal) {
        this.quest = quest;
        this.questUserConcern = questUserConcern;
        this.questProposal = questProposal;
    }

    public QuestNConcernNProposal() {
    }

    public Quest getQuest() {
        return quest;
    }

    public void setQuest(Quest quest) {
        this.quest = quest;
    }

    public List<QuestUserConcern> getQuestUserConcern() {
        return questUserConcern;
    }

    public void setQuestUserConcern(List<QuestUserConcern> questUserConcern) {
        this.questUserConcern = questUserConcern;
    }

    public List<QuestProposal> getQuestProposal() {
        return questProposal;
    }

    public void setQuestProposal(List<QuestProposal> questProposal) {
        this.questProposal = questProposal;
    }
}
