package com.questboard.user.controller;


import com.questboard.user.dto.UserLoginDto;
import com.questboard.user.dto.UserRegistrationDto;
import com.questboard.user.dto.UserUpdateDto;
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
import org.springframework.web.reactive.function.server.ServerResponse;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.Map;

@RestController
@RequestMapping("/api/u/v1")
public class UserController {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

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
                    .onErrorResume(error -> Mono.just(ResponseEntity
                            .status(HttpStatus.UNAUTHORIZED)
                            .body(new RespBody<>("Unauthorized access")))
                            );
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
                    .onErrorResume(error -> {
                        logger.error("Error occur when creating new user ");
                        return Mono.just(ResponseEntity.badRequest()
                                .body(RespBody.body(false).setError("Error when creating new user: " + error.getMessage()).failed()
                                        .setRequired(new String[]{"username", "email", "password", "passwordConfirm"})));
                    });

    }

    @RequestMapping(value = "/user/{id}", method = RequestMethod.GET)
    public Mono<ResponseEntity<RespBody<User>>> getUserById(@PathVariable("id") Integer id) {
        return this.userService.getUserById(id)
                .map(user -> ResponseEntity.ok(RespBody.body(user)))
                .onErrorResume(error -> {
                    logger.error("Error occur when getting user with id" + id);
                    logger.error(error.getMessage());
                    return Mono.just(ResponseEntity.status(404)
                        .body(new RespBody<>("User not found")));
                });
    }

    @RequestMapping(value = "/user/{id}", method = RequestMethod.PUT)
    public Mono<ResponseEntity<RespBody<Boolean>>> updateUser(@RequestBody Map<String, String> param, @PathVariable("id") Integer id) {
        logger.info("Param value: " + param);
        logger.info("id value: " + id);
        UserUpdateDto userUpdateDto = new UserUpdateDto(id);
        if (param.containsKey("email")) {
            userUpdateDto.setEmail(param.get("email"));
        }
        if (param.containsKey("active")) {
            userUpdateDto.setUpdateActiveStatus(true);
            userUpdateDto.setActive(Boolean.parseBoolean(param.get("active")));
        } else {
            userUpdateDto.setUpdateActiveStatus(false);
        }
        if (param.containsKey("ssoUid")) {
            userUpdateDto.setSsoUid(param.get("ssoUid"));
        }
        if (param.containsKey("password") && param.containsKey("passwordConfirm")) {
            userUpdateDto.setPassword(param.get("password"));
            userUpdateDto.setPasswordConfirm(param.get("passwordConfirm"));
        }
        logger.info("userDto in controller: \n" + userUpdateDto.toString());
        return this.keycloakRestService.updateUser(userUpdateDto)
                .map(updatedStatus -> ResponseEntity.ok(RespBody.body(updatedStatus)))
                .onErrorResume(error -> {
                    logger.error("Error occur when updating user with id" + id + error.getMessage());
                    return Mono.just(ResponseEntity.badRequest()
                            .body(RespBody.body(false)
                                    .setError("User not updated due to " + error.getMessage())
                                    .failed()
                                    .setRequired(userUpdateDto.requiredFields())));
                });
    }
}
