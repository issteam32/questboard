package com.questboard.user.controller;

import com.questboard.user.dto.SkillSetProfileAndLevelDto;
import com.questboard.user.entity.SkillSetProfile;
import com.questboard.user.entity.User;
import com.questboard.user.response.RespBody;
import com.questboard.user.service.ProfessionalLevelService;
import com.questboard.user.service.SkillSetProfileService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
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

    @Autowired
    private SkillSetProfileService skillSetProfileService;

    @Autowired
    private ProfessionalLevelService professionalLevelService;

    @GetMapping("/health-check")
    public ResponseEntity<String> redinessCheck() {
        return ResponseEntity.status(200).body("Ok");
    }

    @RequestMapping(value = "/user-skillset-profile/{id}", method = RequestMethod.GET)
    public Flux<SkillSetProfileAndLevelDto> getUserSkillSetProfile(@PathVariable("id") Integer userId) {
        return this.skillSetProfileService.getUserSkillSetProfiles(userId)
                .map(skillSetProfile -> {
                    logger.info("skillsetprofile: {}", skillSetProfile.toString());
                    SkillSetProfileAndLevelDto skillSetProfileAndLevelDto = new SkillSetProfileAndLevelDto();
                    skillSetProfileAndLevelDto.setSkillSetProfile(skillSetProfile);
                    return skillSetProfileAndLevelDto;
                })
                .flatMap(skillSetProfileAndLevelDto -> {
                    logger.info("skillsetprofileandleveldto: {}", skillSetProfileAndLevelDto.toString());
                    return this.professionalLevelService
                            .getProfessionalLevelBySkillId(skillSetProfileAndLevelDto.getSkillSetProfile().getId())
                            .map(professionalLevel -> {
                                logger.info("profession level: {}", professionalLevel.toString());
                                skillSetProfileAndLevelDto.setProfessionalLevel(professionalLevel);
                                return skillSetProfileAndLevelDto;
                            });
                })
                .onErrorResume(error -> {
                    logger.error("Error when getting user (id:{}), error: {}", userId, error.getMessage());
                    return Flux.error(new Error("User skill set profile not found"));
                });
    }

    @RequestMapping(value = "/user-skillset-profile", method = RequestMethod.POST)
    public Mono<SkillSetProfile> createUserSkillSetProfile(@RequestBody HashMap<String, String> param) {
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
                .map(ssp -> ssp)
                .onErrorResume(error -> {
                    logger.error("Error when getting user(id:{}), error: {}", param.get("userId"), error.getMessage());
                    return Mono.error(new Error(error.getMessage()));
                });
    }

    @RequestMapping(value = "/skillset-profile/{id}", method = RequestMethod.GET)
    public Mono<SkillSetProfile> getSkillSetProfileById(@PathVariable("id") Integer id) {
        return this.skillSetProfileService.getSkillSetProfileById(id)
                .map(ssp -> ssp)
                .onErrorResume(error -> {
                    logger.error("Error when getting skill set profile(id:{}}, error {}", id, error.getMessage());
                    return Mono.error(new Error(error.getMessage()));
                });
    }

    @RequestMapping(value = "/skillset-profile", method = RequestMethod.GET)
    public Flux<User> getSkillSetProfileByName(@RequestParam(name = "skill") String skill) {
        return this.skillSetProfileService.getSkillSetProfileByName(skill)
                .map(users -> users)
                .onErrorResume(error -> {
                    logger.error("Error when getting user with this skill set profile(skill:{}), error {}", skill, error.getMessage());
                    return Flux.error(new Error(error.getMessage()));
                });
    }

    @RequestMapping(value = "/skillset-profile/{id}", method = RequestMethod.PUT)
    public Mono<Boolean> updateSkillSetProfile(@RequestBody Map<String, String> param, @PathVariable("id") Integer id) {
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
                .map(updated -> updated)
                .onErrorResume(error -> {
                    logger.error("Error occur when updating skill set profile ({}), error {}", id, error.getMessage());
                    return Mono.error(new Error(error.getMessage()));
                });
    }

    @RequestMapping(value = "/skillset-profile/{id}", method = RequestMethod.DELETE)
    public Mono<Void> deletedSkillSetProfileById(@PathVariable("id") Integer id) {
        return this.skillSetProfileService.deleteSkillSetProfileById(id);
    }

}
