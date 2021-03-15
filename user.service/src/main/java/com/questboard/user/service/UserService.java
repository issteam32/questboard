package com.questboard.user.service;

import com.questboard.user.entity.User;
import com.questboard.user.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepo;

    public Flux<User> getUsers() {
        return this.userRepo.findAll();
    }


}
