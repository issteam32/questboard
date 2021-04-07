package com.questboard.review.controller;

import com.questboard.review.entity.Review;
import com.questboard.review.service.ReviewService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@RestController
@RequestMapping("/api/review")
public class ReviewController {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private ReviewService service;

    @GetMapping()
    public ResponseEntity<Flux<Review>> getAllReview() {
        return ResponseEntity.ok(this.service.getAllReview());
    }

    // http://url/api/review/quest?id=X&pageSize=X&pageNo=X
    @GetMapping(value = "/quest")
    public ResponseEntity<Flux<Review>> getByQuest(@RequestParam Integer id,
                                                   @RequestParam(defaultValue = "10", required = false) Integer pageSize,
                                                   @RequestParam(defaultValue = "0", required = false) Integer pageNo) {

        return ResponseEntity.ok(this.service.getReviewByQuestId(id, PageRequest.of(pageNo, pageSize)));
    }

    // http://url/api/review/questtaker?name=X&pageSize=X&pageNo=X
    @GetMapping(value = "/questtaker")
    public ResponseEntity<Flux<Review>> getByQuestTaker(@RequestParam String name,
                                                        @RequestParam(defaultValue = "10", required = false) Integer pageSize,
                                                        @RequestParam(defaultValue = "0", required = false) Integer pageNo) {

        return ResponseEntity.ok(this.service.getReviewByQuestTaker(name, PageRequest.of(pageNo, pageSize)));
    }

    @PostMapping()
    public ResponseEntity<Mono<Review>> createReview(@RequestBody Review review) {
        if (service.isValid(review)) {
            return ResponseEntity.ok(this.service.createReview(review));
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
    }

    @PutMapping(value = "/{id}")
    public ResponseEntity<Mono<Review>> updateReview(@PathVariable("id") Integer id, @RequestBody Review review) {
        if (id > 0 ) {
            return ResponseEntity.ok(this.service.updateReview(id, review));
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
    }

    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Mono<Void>> deleteReview(@PathVariable("id") Integer id) {
        if (id > 0) {
            return ResponseEntity.ok(this.service.deleteReview(id));
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
    }
}
