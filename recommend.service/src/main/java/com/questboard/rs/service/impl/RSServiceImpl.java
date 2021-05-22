package com.questboard.rs.service.impl;

import com.questboard.rs.model.Quest;
import com.questboard.rs.repository.RSRepository;
import com.questboard.rs.service.RSService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class RSServiceImpl implements RSService {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private RSRepository rsRepository;

    @Override
    public List<Quest> getRecommendedQuests(String skill) {
        Iterable<Quest> quests = rsRepository.findRecommendedQuestBySkill(skill);
        List<Quest> questList = new ArrayList<>();
        for (Quest q: quests) {
            questList.add(q);
        }
        return  questList;
    }

    @Override
    public Boolean pushNewQuest(Quest quest) {
        this.rsRepository.appendQuestList(quest);
        return true;
    }

//    @Override
//    public Optional<Quest> getQuestById(String key) {
//        return this.rsRepository(key);
//    }

    @Override
    public Boolean appendToQuestList(Quest quest) {
        this.rsRepository.appendQuestList(quest);
        return true;
    }

    @Override
    public Optional<List<Quest>> getQuestListByKey(String key) {
        return this.rsRepository.findQuestListByKey(key);
    }
}
