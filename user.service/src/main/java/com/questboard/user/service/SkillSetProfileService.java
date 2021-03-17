package com.questboard.user.service;

import com.questboard.user.entity.SkillSetProfile;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

public interface SkillSetProfileService {
    public Flux<SkillSetProfile> getUserSkillSetProfiles(Integer userId);
    public Mono<Boolean> setSkillSetProfileVisibility(Integer id);
    public Mono<Boolean> createSkillSetProfile(SkillSetProfile skillSetProfile);
    public Mono<Boolean> updateSkillSetProfile(SkillSetProfile skillSetProfile);
    public Mono<SkillSetProfile> getSkillSetProfileById(Integer id);
    public Flux<SkillSetProfile> getSkillSetProfileByName(String skillName);
}
