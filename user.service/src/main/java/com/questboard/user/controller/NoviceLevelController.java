package com.questboard.user.controller;

import com.questboard.user.dto.UserAndTheirNoviceLevelDto;
import com.questboard.user.entity.NoviceLevel;
import com.questboard.user.service.NoviceLevelService;
import com.questboard.user.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.Map;

@RestController
@RequestMapping("/api/nlv/v1")
public class NoviceLevelController {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private NoviceLevelService noviceLevelService;

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/novicelvl/{userId}", method = RequestMethod.GET)
    public Mono<NoviceLevel> getUserNoviceLevel(@PathVariable("userId") Integer userId) {
        return this.noviceLevelService.getUserNoviceLevel(userId)
                .onErrorResume(error -> {
                    logger.error("Unable to retrive user (id: {}) novice level, error: {}", userId, error.getMessage());
                    return Mono.error(new Error(error.getMessage()));
                });
    }

    @RequestMapping(value = "/novicelvl/{userId}", method = RequestMethod.POST)
    public Mono<NoviceLevel> createUserNoviceLevelProfile(@PathVariable("userId") Integer userId) {
        NoviceLevel noviceLevel = new NoviceLevel();
        if (userId == null) {
            return Mono.error(new Error("User id not provided"));
        }
        noviceLevel.setUserId(userId);
        return this.noviceLevelService.createNoviceLevel(noviceLevel)
                .onErrorResume(error -> {
                    logger.error("Unable to create user (id: {}) novice level, error: {}", userId, error.getMessage());
                    return Mono.error(new Error(error.getMessage()));
                });
    }

    @RequestMapping(value = "/user-novice-profile", method = RequestMethod.GET)
    public Flux<UserAndTheirNoviceLevelDto> getUserByNoviceTitle(@RequestParam("title") String title) {
        return this.noviceLevelService.getNoviceLevelByTitle(title)
                .map(noviceLevel -> {
                    UserAndTheirNoviceLevelDto userAndTheirNoviceLevelDto = new UserAndTheirNoviceLevelDto();
                    userAndTheirNoviceLevelDto.setNoviceLevel(noviceLevel);
                    return userAndTheirNoviceLevelDto;
                })
                .flatMap(userAndTheirNoviceLevel ->
                    this.userService.getUserById(userAndTheirNoviceLevel.getNoviceLevel().getUserId())
                            .map(user -> {
                                userAndTheirNoviceLevel.setUser(user);
                                return userAndTheirNoviceLevel;
                            })
                )
                .onErrorResume(error -> {
                    logger.error("Error when getting user and their novice level with title like {}, error: {}", title, error.getMessage());
                    return Flux.error(new Error("User skill set profile not found"));
                });
    }

    @RequestMapping(value = "/novicelvl/{id}", method = RequestMethod.PUT)
    public Mono<NoviceLevel> updateUserNoviceLevelProfile(@RequestBody Map<String, String> param, @PathVariable("id") Integer id) {
        NoviceLevel noviceLevel = new NoviceLevel();
        if (id == null) {
            return Mono.error(new Error("No id is provided"));
        } else {
            noviceLevel.setId(id);
        }
        if (param.containsKey("title")) {
            noviceLevel.setTitle(param.get("title"));
        }
        if (param.containsKey("exp")) {
            noviceLevel.setExp(Integer.parseInt(param.get("exp")));
        }
        return this.noviceLevelService.updateNoviceLevel(noviceLevel)
                .flatMap(Mono::just)
                .onErrorResume(error -> {
                    logger.error("Unable to update novice level profile (id: {}), error, {}", id, error.getMessage());
                    return Mono.error(new Error(error.getMessage()));
                });
    }
}