package com.questboard.user.service;

import com.questboard.user.entity.User;
import com.questboard.user.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepo;

    public Flux<User> getUsers() {
        return this.userRepo.findAll();
    }

    public Mono<Boolean> checkIfUsernameExist(String username) {
        return this.userRepo.existsUserByUserName(username);
    }

    public Mono<Boolean> checkIfEmailExist(String email) {
        return this.userRepo.existsUserByEmail(email);
    }

    public Mono<User> getUserByUserName(String userName) {
        return this.userRepo.findByUserName(userName);
    }

    public Mono<User> getUserByEmail(String email) {
        return this.userRepo.findByEmail(email);
    }

    public Mono<User> getUserById(int id) {
        return this.userRepo.findById(id);
    }
}
