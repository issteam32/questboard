package com.questboard.user.service;

import com.questboard.user.entity.SkillSetProfile;
import com.questboard.user.entity.User;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

public interface SkillSetProfileService {
    public Flux<SkillSetProfile> getUserSkillSetProfiles(Integer userId);
    public Mono<Boolean> setSkillSetProfileVisibility(Integer id, Boolean visibility);
    public Mono<SkillSetProfile> createSkillSetProfile(SkillSetProfile skillSetProfile);
    public Mono<Boolean> updateSkillSetProfile(SkillSetProfile skillSetProfile);
    public Mono<SkillSetProfile> getSkillSetProfileById(Integer id);
    public Flux<User> getSkillSetProfileByName(String skillName);
    public Mono<Void> deleteSkillSetProfileById(Integer id);
}
