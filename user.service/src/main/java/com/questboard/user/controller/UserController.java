package com.questboard.user.controller;


import com.questboard.user.dto.UserLoginDto;
import com.questboard.user.dto.UserRegistrationDto;
import com.questboard.user.entity.User;
import com.questboard.user.response.RespBody;
import com.questboard.user.service.KeycloakRestService;
import com.questboard.user.service.UserService;
import org.keycloak.representations.AccessTokenResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.Map;

@RestController
@RequestMapping("/api/u/v1")
public class UserController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private UserService userService;

    @Autowired
    private KeycloakRestService keycloakRestService;

    @RequestMapping(value = "/user", method = RequestMethod.GET)
    public ResponseEntity<Flux<User>> getUsers() {
        return ResponseEntity.ok(this.userService.getUsers());
    }

    @RequestMapping(value = "/user/login", method = RequestMethod.POST)
    public Mono<ResponseEntity<RespBody<AccessTokenResponse>>> login(@RequestBody UserLoginDto userLoginDto) {
            return this.keycloakRestService.loginSecure(userLoginDto.username, userLoginDto.password)
                    .map(accessTokenResponse -> ResponseEntity.ok(RespBody.body(accessTokenResponse)))
                    .defaultIfEmpty(
                            ResponseEntity
                                    .status(HttpStatus.UNAUTHORIZED)
                                    .body(new RespBody<>("Unauthorized access")));
    }

    @RequestMapping(value = "/user/register", method = RequestMethod.POST)
    public Mono<ResponseEntity<RespBody<Boolean>>> registerUser(@RequestBody Map<String, String> param) {
            UserRegistrationDto userRegistration = new UserRegistrationDto();
            userRegistration.setUserName(param.get("username"));
            userRegistration.setEmail(param.get("email"));
            userRegistration.setPassword(param.get("password"));
            userRegistration.setPasswordConfirm(param.get("passwordConfirm"));

            return this.keycloakRestService.registerUser(userRegistration)
                    .map(registered -> ResponseEntity.ok(RespBody.body(registered)))
                    .doOnError(error -> {
                        logger.error("Error occur when creating new user " + error);
                        ResponseEntity.badRequest()
                                .body(RespBody.body(false).setError("Error when creating new user")
                                        .setRequired(new String[] {"username", "email", "password", "passwordConfirm"}));
                    });

    }
}
