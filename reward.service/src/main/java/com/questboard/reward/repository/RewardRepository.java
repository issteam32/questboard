package com.questboard.reward.repository;

import com.questboard.reward.entity.Reward;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.reactive.ReactiveSortingRepository;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;

@Repository
public interface RewardRepository extends ReactiveSortingRepository<Reward, Integer> {

    Flux<Reward> findByQuestId(Integer questId);
}
