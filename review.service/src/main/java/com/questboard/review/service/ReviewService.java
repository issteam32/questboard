package com.questboard.review.service;

import com.questboard.review.entity.Review;
import org.springframework.data.domain.Pageable;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

public interface ReviewService {

    public Boolean isValid(final Review review);

    public Flux<Review> getAllReview();

    public Flux<Review> getReviewByQuestId(Integer quest_id, Pageable paging);

    public Flux<Review> getReviewByQuestTakerId(Integer questaker_id, Pageable paging);

    public Mono<Review> createReview(final Review review);

    public Mono<Review> updateReview(final Review review);

    public Mono<Void> deleteReview(final int id);
}
