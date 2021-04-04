package com.questboard.review.service;

import com.questboard.review.entity.Review;
import com.questboard.review.repository.ReviewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;


@Service
public class ReviewServiceImpl implements ReviewService{

    @Autowired
    private ReviewRepository reviewRepository;

    public Boolean isValid(final Review review) {
        return review != null && review.getQuest_id() != null && review.getReviewer_id() != null && review.getQuest_taker_id() != null && !review.getReview_msg().isEmpty();
    }

    public Flux<Review> getAllReview() {
        return this.reviewRepository.findAll();
    }

    public Flux<Review> getReviewByQuestId(Integer quest_id, Pageable paging) {

        return this.reviewRepository.findByQuestid(quest_id, paging);
    }

    public Flux<Review> getReviewByQuestTakerId(Integer questaker_id, Pageable paging) {

        return this.reviewRepository.findByQuesttakerid(questaker_id, paging);
    }

    @Transactional
    public Mono<Review> createReview(final Review review) {
        return this.reviewRepository.save(review);
    }

    @Transactional
    public Mono<Review> updateReview(final Review review) {
        return this.reviewRepository.findById(review.getReview_id())
                .flatMap(r -> {
                    r.setReview_msg(review.getReview_msg());
                    return this.reviewRepository.save(r);
                });
    }

    @Transactional
    public Mono<Void> deleteReview(final int id){
        return this.reviewRepository.findById(id)
                .flatMap(this.reviewRepository::delete);
    }
}
