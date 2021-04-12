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
        return review != null && review.getQuestId() != null && review.getReviewer() != null && review.getQuestTaker() != null && !review.getReviewMsg().isEmpty();
    }

    public Flux<Review> getAllReview() {
        return this.reviewRepository.findAll();
    }

    public Mono<Review> getReviewById(int id) {
        return this.reviewRepository.findById(id);
    }

    public Flux<Review> getReviewByQuestId(Integer quest_id, Pageable paging) {

        return this.reviewRepository.findByQuestId(quest_id, paging);
    }

    public Flux<Review> getReviewByQuestTaker(String quest_taker, Pageable paging) {

        return this.reviewRepository.findByQuestTaker(quest_taker, paging);
    }

    @Transactional
    public Mono<Review> createReview(Review review) {
        return this.reviewRepository.save(review);
    }

    @Transactional
    public Mono<Review> updateReview(int id, Review review) {
        return this.reviewRepository.findById(id)
                .flatMap(r -> {
                    if(r != null && r.getReviewer() == review.getReviewer()){
                        r.setReviewMsg(review.getReviewMsg());
                    }
                    return this.reviewRepository.save(r);
                })
                .switchIfEmpty(Mono.defer(() -> Mono.error(new Error("Review not found"))));
    }

    @Transactional
    public Mono<Void> deleteReview(int id){
        return this.reviewRepository.findById(id)
                .flatMap(this.reviewRepository::delete);
    }
}
