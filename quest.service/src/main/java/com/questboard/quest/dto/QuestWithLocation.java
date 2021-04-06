package com.questboard.quest.dto;

import com.questboard.quest.entity.Location;
import com.questboard.quest.entity.Quest;

public class QuestWithLocation {
    private Quest quest;
    private Location location;

    public QuestWithLocation(Quest quest, Location location) {
        this.quest = quest;
        this.location = location;
    }

    public QuestWithLocation() {
    }

    public Quest getQuest() {
        return quest;
    }

    public void setQuest(Quest quest) {
        this.quest = quest;
    }

    public Location getLocation() {
        return location;
    }

    public void setLocation(Location location) {
        this.location = location;
    }
}
