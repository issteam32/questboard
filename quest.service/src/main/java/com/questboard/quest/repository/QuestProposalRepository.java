package com.questboard.quest.repository;

import com.questboard.quest.entity.QuestProposal;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;

public interface QuestProposalRepository extends ReactiveCrudRepository<QuestProposal, Integer> {
}
