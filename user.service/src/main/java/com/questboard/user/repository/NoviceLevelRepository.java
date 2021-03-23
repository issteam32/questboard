package com.questboard.user.repository;

import com.questboard.user.entity.NoviceLevel;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

public interface NoviceLevelRepository extends ReactiveCrudRepository<NoviceLevel, Integer> {
    public Mono<NoviceLevel> findByUserId(Integer userId);
    public Flux<NoviceLevel> findByTitleContainingIgnoreCase(String title);
}
