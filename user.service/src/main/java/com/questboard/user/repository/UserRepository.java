package com.questboard.user.repository;

import com.questboard.user.entity.User;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.List;

public interface UserRepository extends ReactiveCrudRepository<User, Integer> {

    Mono<Boolean> existsUserByUserName(String userName);
    Mono<Boolean> existsUserByEmail(String email);
    Mono<User> findByUserName(String userName);
    Mono<User> findByEmail(String email);
    Flux<User> findByIdIn(List<Integer> userIdList);
}
