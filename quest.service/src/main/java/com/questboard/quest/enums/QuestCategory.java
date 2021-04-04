package com.questboard.quest.enums;

public enum QuestCategory {
    PROFESSIONAL(1),
    EVERYDAY(0);

    public final Integer value;

    QuestCategory(Integer value) {
        this.value = value;
    }
}
