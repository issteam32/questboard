package com.questboard.quest.dto;

import com.questboard.quest.entity.Quest;
import com.questboard.quest.entity.QuestProposal;
import com.questboard.quest.entity.QuestUserConcern;

import java.util.ArrayList;
import java.util.List;

public class QuestWithProposal {
    private Quest quest;
    private List<QuestProposal> questProposals;

    public QuestWithProposal(Quest quest, List<QuestProposal> questProposals) {
        this.quest = quest;
        this.questProposals = questProposals;
    }

    public QuestWithProposal() {
    }

    public Quest getQuest() {
        return quest;
    }

    public void setQuest(Quest quest) {
        this.quest = quest;
    }

    public List<QuestProposal> getQuestProposals() {
        return questProposals;
    }

    public void setQuestProposals(List<QuestProposal> questProposals) {
        this.questProposals = questProposals;
    }

    public void pushQuestUserConcern(QuestProposal questProposal) {
        if (questProposals.isEmpty()) {
            questProposals = new ArrayList<>();
        }
        questProposals.add(questProposal);
    }
}
