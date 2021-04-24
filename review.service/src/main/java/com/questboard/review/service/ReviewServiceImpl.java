package com.questboard.review.service;

import com.questboard.review.entity.Review;
import com.questboard.review.repository.ReviewRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;


@Service
public class ReviewServiceImpl implements ReviewService{

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private ReviewRepository reviewRepository;

    public Boolean isValid(final Review review) {
        return review != null && review.getQuestId() != null && review.getReviewer() != null && review.getQuestTaker() != null && !review.getReviewMsg().isEmpty();
    }

    public Flux<Review> getAllReview() {
        logger.info("GET - " + this.reviewRepository.findAll().toString());
        return this.reviewRepository.findAll();
    }

    public Mono<Review> getReviewById(int id) {
        logger.info("GET - " + this.reviewRepository.findById(id).toString());
        return this.reviewRepository.findById(id);
    }

    public Flux<Review> getReviewByQuestId(Integer questId, Pageable paging) {
        logger.info("GET - " + this.reviewRepository.findByQuestId(questId, paging).toString());
        return this.reviewRepository.findByQuestId(questId, paging);
    }

    public Flux<Review> getReviewByQuestTaker(String questTaker, Pageable paging) {
        logger.info("GET - " + this.reviewRepository.findByQuestTaker(questTaker, paging).toString());
        return this.reviewRepository.findByQuestTaker(questTaker, paging);
    }

    @Transactional
    public Mono<Review> createReview(Review review) {
        logger.info("CREATE REVIEW - " + review.toString());
        return this.reviewRepository.save(review);
    }

    @Transactional
    public Mono<Review> updateReview(int id, Review review) {
        return this.reviewRepository.findById(id)
                .flatMap(r -> {
                    if(r != null && r.getReviewer().equals(review.getReviewer())){
                        r.setReviewMsg(review.getReviewMsg());
                        logger.info("UPDATE REVIEW - " + r.toString());
                    }
                    return this.reviewRepository.save(r);
                })
                .switchIfEmpty(Mono.defer(() -> Mono.error(new Error("Review not found"))));
    }

    @Transactional
    public Mono<Void> deleteReview(int id){
        logger.info("DELETE REVIEW - " + this.reviewRepository.findById(id).toString());
        return this.reviewRepository.findById(id)
                .flatMap(this.reviewRepository::delete);
    }
}
