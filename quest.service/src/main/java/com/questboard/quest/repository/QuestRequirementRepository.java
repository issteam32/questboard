package com.questboard.quest.repository;

import com.questboard.quest.entity.QuestRequirement;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;

public interface QuestRequirementRepository extends ReactiveCrudRepository<QuestRequirement, Integer> {
}
