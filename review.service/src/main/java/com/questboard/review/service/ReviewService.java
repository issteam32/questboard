package com.questboard.review.service;

import com.questboard.review.entity.Review;
import org.springframework.data.domain.Pageable;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

public interface ReviewService {

    public Boolean isValid(final Review review);

    public Flux<Review> getAllReview();

    public Mono<Review> getReviewById(int id);

    public Flux<Review> getReviewByQuestId(Integer quest_id, Pageable paging);

    public Flux<Review> getReviewByQuestTaker(String quest_taker, Pageable paging);

    public Mono<Review> createReview(final Review review);

    public Mono<Review> updateReview(int id, Review review);

    public Mono<Void> deleteReview(int id);
}
