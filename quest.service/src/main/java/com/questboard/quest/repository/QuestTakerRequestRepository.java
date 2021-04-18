package com.questboard.quest.repository;

import com.questboard.quest.entity.QuestTakerRequest;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

public interface QuestTakerRequestRepository extends ReactiveCrudRepository<QuestTakerRequest, Integer> {
    Flux<QuestTakerRequest> findByUsername(String username);
    Flux<QuestTakerRequest> findByUsernameAndQuestId(String username, Integer questId);
    Flux<QuestTakerRequest> findByStatus(String status);
    Flux<QuestTakerRequest> findByQuestId(Integer questId);
    @Query("SELECT CASE WHEN COUNT(c) > 0 THEN true ELSE false END FROM QuestTakerRequest q WHERE q.username= :username and q.questId = :questId")
    Mono<Boolean> existsByUsernameAndQuestId(@Param("username")String username, @Param("questId")Integer questId);
}
