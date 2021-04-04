package com.questboard.quest.repository;

import com.questboard.quest.entity.QuestRequirement;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;
import reactor.core.publisher.Flux;

public interface QuestRequirementRepository extends ReactiveCrudRepository<QuestRequirement, Integer> {
    Flux<QuestRequirement> findByQuestId(Integer questId);
}
