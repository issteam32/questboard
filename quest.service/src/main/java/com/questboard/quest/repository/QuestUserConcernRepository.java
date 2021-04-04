package com.questboard.quest.repository;

import com.questboard.quest.entity.QuestUserConcern;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.List;

public interface QuestUserConcernRepository extends ReactiveCrudRepository<QuestUserConcern, Integer> {
    public Flux<QuestUserConcern> findByQuestId(Integer id);
}
