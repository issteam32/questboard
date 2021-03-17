package com.questboard.user.service;

import com.questboard.user.entity.User;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

public interface UserService {
    public Flux<User> getUsers();

    public Mono<Boolean> checkIfUsernameExist(String username);

    public Mono<Boolean> checkIfEmailExist(String email);

    public Mono<User> getUserByUserName(String userName);

    public Mono<User> getUserByEmail(String email);

    public Mono<User> getUserById(int id);
}
