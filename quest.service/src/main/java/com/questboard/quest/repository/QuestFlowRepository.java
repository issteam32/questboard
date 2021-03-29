package com.questboard.quest.repository;

import com.questboard.quest.entity.QuestFlow;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;

public interface QuestFlowRepository extends ReactiveCrudRepository<QuestFlow, Integer> {
}
