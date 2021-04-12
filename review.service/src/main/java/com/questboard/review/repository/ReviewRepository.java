package com.questboard.review.repository;

import com.questboard.review.entity.Review;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.reactive.ReactiveSortingRepository;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;

@Repository
public interface ReviewRepository extends ReactiveSortingRepository<Review, Integer> {

    Flux<Review> findByQuestId(Integer quest_id, Pageable pageable);
    Flux<Review> findByQuestTaker(String quest_taker, Pageable pageable);
}
