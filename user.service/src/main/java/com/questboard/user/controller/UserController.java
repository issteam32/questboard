package com.questboard.user.controller;


import com.questboard.user.dto.UserLoginDto;
import com.questboard.user.dto.UserRegistrationDto;
import com.questboard.user.dto.UserUpdateDto;
import com.questboard.user.entity.SocialAccount;
import com.questboard.user.entity.User;
import com.questboard.user.enums.SocialPlatform;
import com.questboard.user.response.RespBody;
import com.questboard.user.service.KeycloakRestService;
import com.questboard.user.service.SocialAccountService;
import com.questboard.user.service.UserService;
import org.keycloak.representations.AccessTokenResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.Map;

@RestController
@RequestMapping("/api/u/v1")
public class UserController {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private UserService userServiceImpl;

    @Autowired
    private KeycloakRestService keycloakRestService;

    @Autowired
    private SocialAccountService socialAccountService;

    @RequestMapping(value = "/user", method = RequestMethod.GET)
    public ResponseEntity<Flux<User>> getUsers() {
        return ResponseEntity.ok(this.userServiceImpl.getUsers());
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
    public Mono<ResponseEntity<RespBody<User>>> getUserById(JwtAuthenticationToken jwtToken) {
        String username = (String)jwtToken.getToken().getClaims().get("preferred_username");
        return this.userServiceImpl.getUserByUserName(username)
                .map(user -> ResponseEntity.ok(RespBody.body(user)))
                .onErrorResume(error -> {
                    logger.error("Error occur when getting user with id" + username);
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

    @RequestMapping(value = "/user-social-account/{id}", method = RequestMethod.GET)
    public Flux<SocialAccount> getUserSocialAccount(@PathVariable("id") Integer userId) {
        return this.socialAccountService.getSocialAccountByUserId(userId);
    }

    @RequestMapping(value = "/user-social-account/{id}", method = RequestMethod.POST)
    public Mono<SocialAccount> linkupUserSocialAccount(@RequestBody Map<String, String> param, @PathVariable("id") Integer userId) {
        SocialAccount socialAccount = new SocialAccount();
        if (userId != null) {
            socialAccount.setUserId(userId);
        }
        if (param.containsKey("socialAccountLink")) {
            socialAccount.setSocialAcctLink(param.get("socialAccountLink"));
        }
        if (param.containsKey("socialPlatform")) {
            Integer sp = Integer.parseInt(param.get("socialPlatform"));
            if (sp.equals(SocialPlatform.FACEBOOK.value)) {
                socialAccount.setSocialPlatform(SocialPlatform.FACEBOOK.value);
            } else if (sp.equals(SocialPlatform.GOOGLE.value)) {
                socialAccount.setSocialPlatform(SocialPlatform.GOOGLE.value);
            }
        }
        return this.socialAccountService.linkupSocialAccount(socialAccount)
                .onErrorResume(error -> {
                    logger.error("Unable to link up social account with (userId:{}), error: {}", userId, error.getMessage());
                    return Mono.error(new Error(error.getMessage()));
                });
    }

    @RequestMapping(value = "/social-account/{id}", method = RequestMethod.PUT)
    public Mono<SocialAccount> updateUserSocialAccount(@RequestBody Map<String, String> param, @PathVariable("id") Integer id) {
        SocialAccount socialAccount = new SocialAccount();
        if (id != null) {
            socialAccount.setId(id);
        }
        if (param.containsKey("socialAccountLink")) {
            socialAccount.setSocialAcctLink(param.get("socialAccountLink"));
        }
        return this.socialAccountService.updateSocialAccount(socialAccount)
                .onErrorResume(error -> {
                   logger.error("Unable to update social account (id:{}), error: {}", id, error.getMessage());
                   return Mono.error(new Error(error.getMessage()));
                });
    }

    @RequestMapping(value = "/social-account/{id}", method = RequestMethod.DELETE)
    public Mono<Void> deleteSocialAccountById(@PathVariable("id") Integer id) {
        return this.socialAccountService.deleteSocialAccountById(id);
    }
}
