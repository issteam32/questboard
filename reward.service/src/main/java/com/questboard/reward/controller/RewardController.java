package com.questboard.reward.controller;

import com.questboard.reward.entity.Reward;
import com.questboard.reward.service.RewardService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@RestController
@RequestMapping("/api/reward")
public class RewardController {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private RewardService service;

    @GetMapping("/health-check")
    public ResponseEntity<String> redinessCheck() {
        return ResponseEntity.status(200).body("Ok");
    }

    @GetMapping()
    public ResponseEntity<Flux<Reward>> getAllReward() {
        return ResponseEntity.ok(this.service.getAllReward());
    }

    // http://url/api/reward/{id}
    @GetMapping(value = "/{id}")
    public ResponseEntity<Mono<Reward>> getByRewardId(@PathVariable("id") Integer id) {

        return ResponseEntity.ok(this.service.getRewardById(id));
    }

    // http://url/api/reward/quest/{id}
    @GetMapping(value = "/quest/{id}")
    public ResponseEntity<Flux<Reward>> getByQuestId(@PathVariable("id") Integer id) {

        return ResponseEntity.ok(this.service.getRewardByQuestId(id));
    }

    @PostMapping()
    public ResponseEntity<Mono<Reward>> createReward(@RequestBody Reward reward) {
        if (service.isValid(reward)) {
            return ResponseEntity.ok(this.service.createReward(reward));
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
    }

    // http://url/api/reward/amount/{id}
    @PutMapping(value = "/amount/{id}")
    public ResponseEntity<Mono<Reward>> updateProposedAmount(@PathVariable("id") Integer id, @RequestBody Reward reward) {
        if (id > 0 ) {
            return ResponseEntity.ok(this.service.updateProposedAmount(id, reward));
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
    }

    // http://url/api/reward/status/{id}
    @PutMapping(value = "/status/{id}")
    public ResponseEntity<Mono<Reward>> updateRewardStatus(@PathVariable("id") Integer id, @RequestBody Reward reward) {
        if (id > 0 ) {
            return ResponseEntity.ok(this.service.updateRewardStatus(id, reward));
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
    }

    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Mono<Void>> deleteReward(@PathVariable("id") Integer id) {
        if (id > 0) {
            return ResponseEntity.ok(this.service.deleteReward(id));
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
    }
}
