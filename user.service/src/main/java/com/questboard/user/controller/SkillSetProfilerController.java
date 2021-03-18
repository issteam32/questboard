package com.questboard.user.controller;

import com.questboard.user.entity.SkillSetProfile;
import com.questboard.user.response.RespBody;
import com.questboard.user.service.SkillSetProfileService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.HashMap;

@RestController
@RequestMapping("/api/ssp/v1")
public class SkillSetProfilerController {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    private SkillSetProfileService skillSetProfileService;

    @RequestMapping(value = "/user-skillset-profile", method = RequestMethod.GET)
    public Flux<ResponseEntity<RespBody<SkillSetProfile>>> getUserSkillSetProfile(Integer userId) {
        return this.skillSetProfileService.getUserSkillSetProfiles(userId)
                .map(skillSetProfiles -> ResponseEntity.ok(RespBody.body(skillSetProfiles)))
                .onErrorResume(error -> {
                    logger.error("Error when getting user(id:{}} skill set profile: {}", userId, error.getMessage());
                    return Flux.just(ResponseEntity.status(404)
                            .body(new  RespBody<>("User skill set profile not found")));
                });
    }

    @RequestMapping(value = "/user-skillset-profile", method = RequestMethod.POST)
    public Mono<ResponseEntity<RespBody<Boolean>>> createUserSkillSetProfile(@RequestBody HashMap<String, String> param) {
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
                .map(created -> ResponseEntity.ok(RespBody.body(created)))
                .onErrorResume(error -> {
                    logger.error("Error when getting user(id:{}} skill set profile: {}", param.get("userId"), error.getMessage());
                    return Mono.just(ResponseEntity.badRequest()
                            .body(RespBody.body(false)
                                    .failed()
                                    .setError(error.getMessage())
                                    .setRequired(new String[] {"userId", "skill", "skillDesc"})
                            ));
                });

    }
}
