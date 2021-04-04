package com.questboard.user.repository;

import com.questboard.user.entity.SocialAccount;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;
import reactor.core.publisher.Flux;

public interface SocialAccountRepository extends ReactiveCrudRepository<SocialAccount, Integer> {
    public Flux<SocialAccount> findByUserId(Integer userId);
}
