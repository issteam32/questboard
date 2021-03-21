package com.questboard.user.controller;

import com.questboard.user.entity.SkillSetProfile;
import com.questboard.user.entity.User;
import com.questboard.user.response.RespBody;
import com.questboard.user.service.SkillSetProfileService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/ssp/v1")
public class SkillSetProfilerController {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    private SkillSetProfileService skillSetProfileService;

    @RequestMapping(value = "/user-skillset-profile", method = RequestMethod.GET)
    public Flux<ResponseEntity<RespBody<SkillSetProfile>>> getUserSkillSetProfile(@PathVariable("id") Integer userId) {
        return this.skillSetProfileService.getUserSkillSetProfiles(userId)
                .map(skillSetProfiles -> ResponseEntity.ok(RespBody.body(skillSetProfiles)))
                .onErrorResume(error -> {
                    logger.error("Error when getting user(id:{}} skill set profile: {}", userId, error.getMessage());
                    return Flux.just(ResponseEntity.status(404)
                            .body(new  RespBody<>("User skill set profile not found")));
                });
    }

    @RequestMapping(value = "/user-skillset-profile", method = RequestMethod.POST)
    public Mono<ResponseEntity<RespBody<SkillSetProfile>>> createUserSkillSetProfile(@RequestBody HashMap<String, String> param) {
        SkillSetProfile skillSetProfile = new SkillSetProfile();
        if (param.containsKey("userId")) {
            skillSetProfile.setUserId(Integer.parseInt(param.get("userId")));
        }
        if (param.containsKey("skill")) {
            skillSetProfile.setSkill(param.get("skill"));
        }
        if (param.containsKey("skillDesc")) {
            skillSetProfile.setSkillDesc(param.get("skillDesc"));
        }
        return this.skillSetProfileService.createSkillSetProfile(skillSetProfile)
                .map(ssp -> ResponseEntity.ok(RespBody.body(ssp)))
                .onErrorResume(error -> {
                    logger.error("Error when getting user(id:{}}, error: {}", param.get("userId"), error.getMessage());
                    return Mono.just(ResponseEntity.badRequest()
                            .body(new RespBody<>(error.getMessage())
                            ));
                });
    }

    @RequestMapping(value = "/skill-profile/{id}", method = RequestMethod.GET)
    public Mono<ResponseEntity<RespBody<SkillSetProfile>>> getSkillSetProfileById(@PathVariable("id") Integer id) {
        return this.skillSetProfileService.getSkillSetProfileById(id)
                .map(ssp -> ResponseEntity.ok(RespBody.body(ssp)))
                .onErrorResume(error -> {
                    logger.error("Error when getting skill set profile(id:{}}, error {}", id, error.getMessage());
                    return Mono.just(ResponseEntity.badRequest()
                            .body(new RespBody<>(error.getMessage())));
                });
    }

    @RequestMapping(value = "/user-skill-profile/{skill}", method = RequestMethod.GET)
    public Flux<ResponseEntity<RespBody<User>>> getSkillSetProfileByName(@PathVariable("skill") String skill) {
        return this.skillSetProfileService.getSkillSetProfileByName(skill)
                .map(users -> ResponseEntity.ok(RespBody.body(users)))
                .onErrorResume(error -> {
                    logger.error("Error when getting user with this skill set profile(skill:{}), error {}", skill, error.getMessage());
                    return Flux.just(ResponseEntity.badRequest()
                            .body(new RespBody<>(error.getMessage())));
                });
    }

    @RequestMapping(value = "/skill-profile/{id}", method = RequestMethod.PUT)
    public Mono<ResponseEntity<RespBody<Boolean>>> updateSkillSetProfile(@RequestBody Map<String, String> param, @PathVariable("id") Integer id) {
        SkillSetProfile skillSetProfile = new SkillSetProfile();
        skillSetProfile.setId(id);
        if (param.containsKey("skillEndorsed")) {
            skillSetProfile.setSkillEndorsed(Long.parseLong(param.get("skillEndorsed")));
        }
        if (param.containsKey("skillDesc")) {
            skillSetProfile.setSkillDesc(param.get("skillDesc"));
        }
        if (param.containsKey("display")) {
            skillSetProfile.setDisplay(Boolean.parseBoolean(param.get("display")));
        }

        return this.skillSetProfileService.updateSkillSetProfile(skillSetProfile)
                .map(updated -> ResponseEntity.ok(RespBody.body(updated)))
                .onErrorResume(error -> {
                    logger.error("Error occur when updating skill set profile ({}), error {}", id, error.getMessage());
                    return Mono.just(ResponseEntity.badRequest()
                            .body(new RespBody<>(error.getMessage())));
                });
    }

    @RequestMapping(value = "/skill-set-profile/{id}", method = RequestMethod.DELETE)
    public Mono<Void> deletedSkillSetProfileById(@PathVariable("id") Integer id) {
        return this.skillSetProfileService.deleteSkillSetProfileById(id);
    }
}
