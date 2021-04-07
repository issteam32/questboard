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
        return review != null && review.getQuest_id() != null && review.getReviewer() != null && review.getQuest_taker() != null && !review.getReview_msg().isEmpty();
    }

    public Flux<Review> getAllReview() {
        return this.reviewRepository.findAll();
    }

    public Mono<Review> getReviewById(int id) {
        return this.reviewRepository.findById(id);
    }

    public Flux<Review> getReviewByQuestId(Integer quest_id, Pageable paging) {

        return this.reviewRepository.findByQuestid(quest_id, paging);
    }

    public Flux<Review> getReviewByQuestTaker(String quest_taker, Pageable paging) {

        return this.reviewRepository.findByQuesttaker(quest_taker, paging);
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
                        r.setReview_msg(review.getReview_msg());
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
