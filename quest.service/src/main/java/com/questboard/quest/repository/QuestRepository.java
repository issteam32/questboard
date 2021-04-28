package com.questboard.quest.repository;

import com.questboard.quest.entity.Quest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;
import reactor.core.publisher.Flux;

public interface QuestRepository extends ReactiveCrudRepository<Quest, Integer> {
    public Flux<Quest> findByCategory(Integer category);
    public Flux<Quest> findByAwardedTo(String username);
    public Flux<Quest> findByRequestor(String username);
    public Flux<Quest> findByDescriptionContainingIgnoreCase(String desc);
    public Flux<Quest> findByCategoryOrderByUpdatedDate(Integer category, Pageable pageable);

    @Query("select q.* from quest q join quest_proposal qp where q.id = qp.quest_id and qp.username = :username ")
    public Flux<Quest> findProposedQuestByUsername(@Param("username") String username);
}
