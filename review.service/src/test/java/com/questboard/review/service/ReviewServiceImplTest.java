package com.questboard.review.service;

import com.questboard.review.entity.Review;
import com.questboard.review.repository.ReviewRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import java.time.LocalDateTime;

import static org.mockito.ArgumentMatchers.isA;
import static org.mockito.Mockito.anyInt;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
public class ReviewServiceImplTest {

    @Mock
    ReviewRepository reviewRepository;

    @InjectMocks
    ReviewServiceImpl reviewServiceImpl;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.initMocks(this);
        when(reviewRepository.findAll()).thenReturn(Flux.just(reviewProviderSet1()));
        when(reviewRepository.findById(anyInt())).thenReturn(
                Flux.just(reviewProviderSet1())
                        .filter(review -> review.getReview_id().equals(1)).next());
        when(reviewRepository.findByQuestid(anyInt(), isA(Pageable.class))).thenAnswer(
                invocationOnMock -> {
                    Object arguments = invocationOnMock.getArguments()[0];
                    return Flux.just(reviewProviderSet1())
                            .filter(review -> review.getQuest_id().equals(arguments));
                }
        );
        when(reviewRepository.findByQuesttakerid(anyInt(), isA(Pageable.class))).thenAnswer(
                invocationOnMock -> {
                    Object arguments = invocationOnMock.getArguments()[0];
                    return Flux.just(reviewProviderSet1())
                            .filter(review -> review.getQuest_taker_id().equals(arguments));
                }
        );
        when(reviewRepository.save(Mockito.any(Review.class))).thenAnswer(
                invocationOnMock -> {
                    Object arguments = invocationOnMock.getArguments()[0];
                    if (arguments == null) {
                        return new Exception("Error while inserting new review");
                    } else {
                        Review review = (Review) arguments;
                        if (review != null && review.getQuest_id() != null && review.getReviewer_id() != null && review.getQuest_taker_id() != null && !review.getReview_msg().isEmpty()) {
                            review.setReview_id(reviewProviderSet1().length + 1);
                            return Mono.just(review);
                        } else {
                            return Mono.empty();
                        }
                    }
                }
        );
    }

    @Test
    public void isValid() {
    }

    @Test
    public void getAllReview() {
        StepVerifier.create(reviewServiceImpl.getAllReview())
                .expectNextMatches(review -> review.getReview_id().equals(1))
                .expectNextMatches(review -> review.getReview_id().equals(2))
                .expectNextMatches(review -> review.getReview_id().equals(3))
                .expectNextMatches(review -> review.getReview_id().equals(4))
                .expectNextMatches(review -> review.getReview_id().equals(5))
                .verifyComplete();
    }

    @Test
    public void getReviewByQuestId() {
        StepVerifier.create(reviewServiceImpl.getReviewByQuestId(1, PageRequest.of(0,2)))
                .expectNextCount(3)
                .verifyComplete();

        StepVerifier.create(reviewServiceImpl.getReviewByQuestId(2, PageRequest.of(0,2)))
                .expectNextCount(2)
                .verifyComplete();
    }

    @Test
    public void getReviewByQuestTakerId() {
        StepVerifier.create(reviewServiceImpl.getReviewByQuestTakerId(1345, PageRequest.of(0,2)))
                .expectNextCount(2)
                .verifyComplete();

        StepVerifier.create(reviewServiceImpl.getReviewByQuestTakerId(1346, PageRequest.of(0,2)))
                .expectNextCount(3)
                .verifyComplete();
    }

    @Test
    public void createReview() {

        Review testReview = new Review();
        testReview.setReview_id(1);
        testReview.setQuest_id(1);
        testReview.setReviewer_id(9133);
        testReview.setQuest_taker_id(1345);
        testReview.setReview_msg("You did a great job");

        StepVerifier.create(reviewServiceImpl.createReview(testReview))
                .expectNextMatches(r -> r.getReview_id()!=null && r.getReview_msg().equals("You did a great job"))
                .expectComplete();

        testReview = new Review();
        testReview.setReview_msg("You did a great job");
        StepVerifier.create(reviewServiceImpl.createReview(testReview))
                .expectError();
    }

    @Test
    public void updateReview() {

        Review testReview = new Review();
        testReview.setReview_id(1);
        testReview.setQuest_id(1);
        testReview.setReviewer_id(9133);
        testReview.setQuest_taker_id(1345);
        testReview.setReview_msg("You did a great job");

        StepVerifier.create(reviewServiceImpl.updateReview(testReview))
                .expectNextMatches(r -> r.getReview_id()!=null
                        && r.getReview_id().equals(1)
                        && r.getReview_msg().equals("You did a great job"))
                .expectComplete();
    }

    @Test
    public void deleteReview() {
        StepVerifier.create(reviewServiceImpl.deleteReview(1))
                .expectComplete();
    }


    Review[] reviewProviderSet1() {
        return new Review[] {
                new Review(1, 1, 9133, 1345,
                        "You did a great job", LocalDateTime.now(), LocalDateTime.now(), 9133),
                new Review(2, 1, 9134, 1345,
                        "Always deliver on time", LocalDateTime.now(), LocalDateTime.now(), 9134),
                new Review(3, 1, 9135, 1346,
                        "Accomplished job very well", LocalDateTime.now(), LocalDateTime.now(), 9135),
                new Review(4, 2, 9136, 1346,
                        "Great quest taker", LocalDateTime.now(), LocalDateTime.now(), 9136),
                new Review(5, 2, 9137, 1346,
                        "I am happy to work with this guy", LocalDateTime.now(), LocalDateTime.now(), 9137)
        };
    }
}