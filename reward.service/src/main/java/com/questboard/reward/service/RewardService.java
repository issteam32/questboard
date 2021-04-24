package com.questboard.reward.service;

import com.questboard.reward.entity.Reward;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

public interface RewardService {

    public Boolean isValid(final Reward review);

    public Flux<Reward> getAllReward();

    public Mono<Reward> getRewardById(int id);

    public Flux<Reward> getRewardByQuestId(Integer questId);

    public Mono<Reward> createReward(Reward reward);

    public Mono<Reward> updateProposedAmount(int id, Reward reward);

    public Mono<Reward> updateRewardStatus(int id, Reward reward);

    public Mono<Void> deleteReward(int id);
}
