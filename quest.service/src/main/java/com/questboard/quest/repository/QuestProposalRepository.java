package com.questboard.quest.repository;

import com.questboard.quest.entity.QuestProposal;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;
import reactor.core.publisher.Flux;

public interface QuestProposalRepository extends ReactiveCrudRepository<QuestProposal, Integer> {
    Flux<QuestProposal> findByQuestId(Integer questId);
    Flux<QuestProposal> findByUsername(String username);
}
