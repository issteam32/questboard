package com.questboard.user.service;

import com.questboard.user.entity.SkillSetProfile;
import com.questboard.user.repository.SkillSetProfileRepository;
import org.springframework.beans.factory.annotation.Autowired;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

public class SkillSetProfileServiceImpl implements SkillSetProfileService{

    @Autowired
    private SkillSetProfileRepository ssRepo;

    @Override
    public Flux<SkillSetProfile> getUserSkillSetProfiles(Integer userId) {
        return null;
    }

    @Override
    public Mono<SkillSetProfile> hideSkillSetProfileFromPublic(Integer id) {
        return null;
    }

    @Override
    public Mono<Boolean> createSkillSetProfile(SkillSetProfile skillSetProfile) {
        return null;
    }

    @Override
    public Mono<Boolean> updateSkillSetProfile(SkillSetProfile skillSetProfile) {
        return null;
    }

    @Override
    public Mono<SkillSetProfile> getSkillSetProfileById(Integer id) {
        return null;
    }

    @Override
    public Flux<SkillSetProfile> getSkillSetProfileByName(String skillName) {
        return null;
    }
}
