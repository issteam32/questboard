package com.questboard.quest.repository;

import com.questboard.quest.entity.QuestFlow;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;
import reactor.core.publisher.Flux;

public interface QuestFlowRepository extends ReactiveCrudRepository<QuestFlow, Integer> {
    Flux<QuestFlow> findByQuestId(Integer questId);
}
