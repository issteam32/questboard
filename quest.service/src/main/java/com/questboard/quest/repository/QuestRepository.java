package com.questboard.quest.repository;

import com.questboard.quest.entity.Quest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;
import reactor.core.publisher.Flux;

public interface QuestRepository extends ReactiveCrudRepository<Quest, Integer> {
    public Flux<Quest> findByCategory(Integer category);
    public Flux<Quest> findByAwardedTo(Integer userId);
    public Flux<Quest> findByRequestor(Integer userId);
    public Flux<Quest> findByDescriptionContainingIgnoreCase(String desc);
    public Flux<Quest> findByCategoryOrderByUpdatedDate(Integer category, Pageable pageable);
}
