package com.questboard.rs.repository;

import com.questboard.rs.model.Quest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Component
public class RSRepository {

//    @Autowired
//    private RedisTemplate<String, Quest> redisQuestTemplate;

    @Autowired
    private RedisTemplate<String, List<Quest>> redisListTemplate;

//    public void save(Quest quest) {
//        redisQuestTemplate.opsForValue()
//                .set("queue", quest);
//    }

    public void appendQuestList(Quest quest) {
        List<Quest> questList;
        if (! redisListTemplate.hasKey("inQ")) {
            questList = new ArrayList<>();
            redisListTemplate.opsForValue().set("inQ", questList);
        } else {
            questList =redisListTemplate.opsForValue().get("inQ");
        }
        questList.add(quest);
        redisListTemplate.opsForValue()
                .set("inQ", questList);
    }
//
//    public Optional<Quest> findById(String key) {
//        return Optional.ofNullable(redisQuestTemplate.opsForValue()
//                .get(key));
//    }

    public Optional<List<Quest>> findQuestListByKey(String key) {
        if (! redisListTemplate.hasKey("inQ")) {
            return Optional.empty();
        }
        return Optional.ofNullable(redisListTemplate.opsForValue()
                .get(key));
    }

    public List<Quest> findRecommendedQuestBySkill(String skill) {
//        return redisTemplate.opsForValue()
        return null;
    }
}
