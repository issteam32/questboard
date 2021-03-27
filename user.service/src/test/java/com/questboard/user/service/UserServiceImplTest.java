package com.questboard.user.service;

import com.questboard.user.entity.User;
import com.questboard.user.repository.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.junit.MockitoJUnitRunner;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;
import java.time.LocalDateTime;
import static org.mockito.Mockito.*;

@RunWith(MockitoJUnitRunner.class)
class UserServiceImplTest {

    @Mock
    UserRepository userRepo;

    @InjectMocks
    UserServiceImpl userServiceImpl;

    @BeforeEach
    void setup() {
        MockitoAnnotations.initMocks(this);
        when(userRepo.findAll()).thenReturn(fluxUsersProvider());
        when(userRepo.existsUserByUserName("user1")).thenReturn(Mono.just(true));
        when(userRepo.existsUserByEmail(anyString())).thenReturn(Mono.just(false));
        when(userRepo.existsUserByEmail("user1@email.com")).thenReturn(Mono.just(true));
        when(userRepo.findByUserName(anyString())).thenAnswer(
                invocationOnMock -> {
                    Object arguments = invocationOnMock.getArguments()[0];
                    if (arguments.equals("user1")) {
                        return Mono.just(usersProvider()[0]);
                    } else {
                        return Mono.just(new User());
                    }
                });
        when(userRepo.findByEmail(anyString())).thenAnswer(
                invocationOnMock -> {
                    Object arguments = invocationOnMock.getArguments()[0];
                    if (arguments.equals("user1@email.com")) {
                        return Mono.just(usersProvider()[0]);
                    } else {
                        return Mono.just(new User());
                    }
                });
        when(userRepo.findById(anyInt())).thenAnswer(
                invocationOnMock -> {
                    Object arguments = invocationOnMock.getArguments()[0];
                    if (arguments.equals(1)) {
                        return Mono.just(usersProvider()[0]);
                    } else {
                        return Mono.just(new User());
                    }
                });
    }

    @Test
    void shouldReturnAllUsers() {
        StepVerifier.create(userServiceImpl.getUsers())
                .expectNextMatches(user -> user.getUserName().equals("user1"))
                .expectNextMatches(user -> user.getUserName().equals("user2"))
                .expectComplete()
                .verify();
    }

    @Test
    void shouldCheckIfUserExistsByUsername() {
        StepVerifier.create(userServiceImpl.checkIfUsernameExist("user1"))
                .expectNext(true)
                .verifyComplete();
    }

    @Test
    void shouldCheckIfUserExistsByEmail() {
        StepVerifier.create(userServiceImpl.checkIfEmailExist("user1"))
                .expectNext(false)
                .verifyComplete();

        StepVerifier.create(userServiceImpl.checkIfEmailExist("user1@email.com"))
                .expectNext(true)
                .verifyComplete();
    }

    @Test
    void shouldReturnUserWhenUsernameProvided() {
        StepVerifier.create(userServiceImpl.getUserByUserName("user1"))
                .expectNextMatches(user -> user.getUserName().equals("user1") && user.getEmail().equals("user1@email.com"))
                .verifyComplete();

        StepVerifier.create(userServiceImpl.getUserByUserName("unknownuser"))
                .expectNextMatches(user -> user.getUserName() == null)
                .verifyComplete();
    }

    @Test
    void shouldReturnUserWhenEmailProvided() {
        StepVerifier.create(userServiceImpl.getUserByEmail("user1@email.com"))
                .expectNextMatches(user -> user.getUserName().equals("user1") && user.getEmail().equals("user1@email.com"))
                .verifyComplete();

        StepVerifier.create(userServiceImpl.getUserByEmail("user1"))
                .expectNextMatches(user -> user.getUserName() == null)
                .verifyComplete();
    }

    @Test
    void shouldReturnUserWhenIdProvided() {
        StepVerifier.create(userServiceImpl.getUserById(1))
                .expectNextMatches(user -> user.getUserName().equals("user1") && user.getEmail().equals("user1@email.com"))
                .verifyComplete();
    }

    Flux<User> fluxUsersProvider() {
        return Flux.just(usersProvider());
    }

    User[] usersProvider() {
        return new User[] {
                new User(1, "user1", "21248ce8-871c-11eb-8dcd-0242ac130003", "user1@email.com",
                        1, true, LocalDateTime.now(), LocalDateTime.now()),
                new User(2, "user2", "5bf6f306-871c-11eb-8dcd-0242ac130003", "user2@email.com",
                        1, true, LocalDateTime.now(), LocalDateTime.now())
        };
    }
}