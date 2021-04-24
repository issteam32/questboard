package com.questboard.reward.service;

import com.questboard.reward.entity.Reward;
import com.questboard.reward.repository.RewardRepository;
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
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import java.time.LocalDateTime;

import static org.mockito.Mockito.anyInt;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
public class RewardServiceImplTest {

    @Mock
    RewardRepository rewardRepository;

    @InjectMocks
    RewardServiceImpl rewardServiceImpl;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.initMocks(this);
        when(rewardRepository.findAll()).thenReturn(Flux.just(rewardProviderSet1()));
        when(rewardRepository.findById(anyInt())).thenReturn(
                Flux.just(rewardProviderSet1())
                        .filter(review -> review.getId().equals(1)).next());
        when(rewardRepository.findByQuestId(anyInt())).thenAnswer(
                invocationOnMock -> {
                    Object arguments = invocationOnMock.getArguments()[0];
                    return Flux.just(rewardProviderSet1())
                            .filter(review -> review.getQuestId().equals(arguments));
                }
        );
        when(rewardRepository.save(Mockito.any(Reward.class))).thenAnswer(
                invocationOnMock -> {
                    Object arguments = invocationOnMock.getArguments()[0];
                    if (arguments == null) {
                        return new Exception("Error while inserting new reward");
                    } else {
                        Reward reward = (Reward) arguments;
                        if (reward != null && reward.getQuestId() != null && reward.getQuestGiver() != null && reward.getQuestTaker() != null && reward.getInitialAmount() != null) {
                            reward.setId(rewardProviderSet1().length + 1);
                            return Mono.just(reward);
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
    public void getAllReward() {
        StepVerifier.create(rewardServiceImpl.getAllReward())
                .expectNextMatches(reward -> reward.getId().equals(1))
                .expectNextMatches(reward -> reward.getId().equals(2))
                .expectNextMatches(reward -> reward.getId().equals(3))
                .expectNextMatches(reward -> reward.getId().equals(4))
                .expectNextMatches(reward -> reward.getId().equals(5))
                .verifyComplete();
    }

    @Test
    public void getRewardByQuestId() {
        StepVerifier.create(rewardServiceImpl.getRewardByQuestId(1))
                .expectNextCount(3)
                .verifyComplete();

        StepVerifier.create(rewardServiceImpl.getRewardByQuestId(2))
                .expectNextCount(2)
                .verifyComplete();
    }


    @Test
    public void createReward() {

        Reward testReward = new Reward();
        testReward.setQuestId(1);
        testReward.setQuestGiver("Adrian");
        testReward.setQuestTaker("Matthew");
        testReward.setInitialAmount(88);

        StepVerifier.create(rewardServiceImpl.createReward(testReward))
                .expectNextMatches(r -> r.getInitialAmount().equals(88))
                .expectComplete();

        testReward = new Reward();
        testReward.setInitialAmount(9);
        StepVerifier.create(rewardServiceImpl.createReward(testReward))
                .expectError();
    }

    @Test
    public void updateProposedAmount() {

        Reward testReward = new Reward();
        testReward.setQuestId(1);
        testReward.setQuestGiver("Matthew");
        testReward.setQuestTaker("Adam");
        testReward.setInitialAmount(18);
        testReward.setProposedAmount(20);
        testReward.setStatus(1);

        StepVerifier.create(rewardServiceImpl.updateProposedAmount(1, testReward))
                .expectNextMatches(r -> r.getId()!=null
                        && r.getId().equals(1)
                        && r.getProposedAmount().equals(20))
                .expectComplete();
    }

    @Test
    public void updateRewardStatus() {

        Reward testReward = new Reward();
        testReward.setQuestId(1);
        testReward.setQuestGiver("Matthew");
        testReward.setQuestTaker("Adam");
        testReward.setInitialAmount(18);
        testReward.setProposedAmount(20);
        testReward.setStatus(2);

        StepVerifier.create(rewardServiceImpl.updateProposedAmount(1, testReward))
                .expectNextMatches(r -> r.getId()!=null
                        && r.getId().equals(1)
                        && r.getStatus().equals(2))
                .expectComplete();
    }

    @Test
    public void deleteReward() {
        StepVerifier.create(rewardServiceImpl.deleteReward(1))
                .expectComplete();
    }

    /*
    * Status
    * 1 - New
    * 2 - Accepted
    * 3 - Pending Payment
    * 4 - Closed
    * */

    Reward[] rewardProviderSet1() {
        return new Reward[] {
                new Reward(1, 1, "Matthew", "Adam", 18, 20,
                        1, LocalDateTime.now(), LocalDateTime.now()),
                new Reward(2, 1, "Matthew", "Bryan", 18, 25,
                        1, LocalDateTime.now(), LocalDateTime.now()),
                new Reward(3, 1, "Matthew", "YongJia",18, 18,
                        2, LocalDateTime.now(), LocalDateTime.now()),
                new Reward(4, 2, "Matthew", "Denise", 65, 70,
                        1, LocalDateTime.now(), LocalDateTime.now()),
                new Reward(5, 2, "Matthew", "Elaine", 65, 80,
                        1, LocalDateTime.now(), LocalDateTime.now())
        };
    }
}