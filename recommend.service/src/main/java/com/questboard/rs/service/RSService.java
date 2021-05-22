package com.questboard.rs.service;

import com.questboard.rs.model.Quest;

import java.util.List;
import java.util.Optional;

public interface RSService {
    public List<Quest> getRecommendedQuests(String skill);
    public Boolean pushNewQuest(Quest quest);
//    public Optional<Quest> getQuestById(String key);
    public Boolean appendToQuestList(Quest quest);
    public Optional<List<Quest>> getQuestListByKey(String key);
}
