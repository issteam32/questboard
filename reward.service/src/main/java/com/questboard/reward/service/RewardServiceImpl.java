package com.questboard.reward.service;

import com.questboard.reward.entity.Reward;
import com.questboard.reward.repository.RewardRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;


@Service
public class RewardServiceImpl implements RewardService{

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private RewardRepository rewardRepository;

    public Boolean isValid(final Reward reward) {
        return reward != null && reward.getQuestId() != null && reward.getQuestGiver() != null && reward.getQuestTaker() != null && reward.getInitialAmount() != null;
    }

    public Flux<Reward> getAllReward() {
        logger.info("GET - " + this.rewardRepository.findAll().toString());
        return this.rewardRepository.findAll();
    }

    public Mono<Reward> getRewardById(int id) {
        logger.info("GET - " + this.rewardRepository.findById(id).toString());
        return this.rewardRepository.findById(id);
    }

    public Flux<Reward> getRewardByQuestId(Integer questId) {
        logger.info("GET - " + this.rewardRepository.findByQuestId(questId).toString());
        return this.rewardRepository.findByQuestId(questId);
    }

    @Transactional
    public Mono<Reward> createReward(Reward reward) {
        logger.info("CREATE REWARD - " + reward.toString());
        return this.rewardRepository.save(reward);
    }

    @Transactional
    public Mono<Reward> updateProposedAmount(int id, Reward reward) {
        return this.rewardRepository.findById(id)
                .flatMap(r -> {
                    if(r != null ){
                        r.setProposedAmount(reward.getProposedAmount());
                        logger.info("UPDATE PROPOSED AMOUNT - " + r.toString());
                    }
                    return this.rewardRepository.save(r);
                })
                .switchIfEmpty(Mono.defer(() -> Mono.error(new Error("Reward not found"))));
    }

    @Transactional
    public Mono<Reward> updateRewardStatus(int id, Reward reward) {
        return this.rewardRepository.findById(id)
                .flatMap(r -> {
                    if(r != null ){
                        r.setStatus(reward.getStatus());
                        logger.info("UPDATE REWARD STATUS - " + r.toString());
                    }
                    return this.rewardRepository.save(r);
                })
                .switchIfEmpty(Mono.defer(() -> Mono.error(new Error("Reward not found"))));
    }

    @Transactional
    public Mono<Void> deleteReward(int id){
        logger.info("DELETE REVIEW - " + this.rewardRepository.findById(id).toString());
        return this.rewardRepository.findById(id)
                .flatMap(this.rewardRepository::delete);
    }
}
