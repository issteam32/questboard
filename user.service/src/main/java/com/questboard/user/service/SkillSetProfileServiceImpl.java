package com.questboard.user.service;

import com.questboard.user.entity.SkillSetProfile;
import com.questboard.user.enums.Skill;
import com.questboard.user.repository.SkillSetProfileRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

public class SkillSetProfileServiceImpl implements SkillSetProfileService{

    @Autowired
    private SkillSetProfileRepository ssRepo;

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Override
    public Flux<SkillSetProfile> getUserSkillSetProfiles(Integer userId) {
        return this.ssRepo.findByUserId(userId);
    }

    @Override
    public Mono<Boolean> setSkillSetProfileVisibility(Integer id) {
        return this.ssRepo.findById(id)
                .flatMap(skillSetProfile -> {
                    if (skillSetProfile != null) {
                        skillSetProfile.setDisplay(false);
                        this.ssRepo.save(skillSetProfile).subscribe();
                        return Mono.just(true);
                    } else {
                        return Mono.just(false);
                    }
                });
    }

    @Override
    public Mono<Boolean> createSkillSetProfile(SkillSetProfile skillSetProfile) {
        skillSetProfile.setDisplay(true);
        skillSetProfile.setSkillEndorsed(1L);
        return this.ssRepo.save(skillSetProfile).flatMap(ss -> ss != null? Mono.just(true) : Mono.just(false));
    }

    @Override
    public Mono<Boolean> updateSkillSetProfile(SkillSetProfile skillSetProfile) {
        return this.ssRepo.findById(skillSetProfile.getId())
                .flatMap(ssProfile -> {
                    logger.info("ssProfile got: " + ssProfile);
                    if (ssProfile != null) {
                        if (skillSetProfile.getSkillDesc() != null && skillSetProfile.getSkillDesc().length() > 0) {
                            ssProfile.setSkillDesc(skillSetProfile.getSkillDesc());
                        }
                        if (skillSetProfile.getSkillEndorsed() != null && skillSetProfile.getSkillEndorsed() > ssProfile.getSkillEndorsed()) {
                            ssProfile.setSkillEndorsed(ssProfile.getSkillEndorsed() + 1);
                        }
                        if (skillSetProfile.getDisplay() != null) {
                            ssProfile.setDisplay(skillSetProfile.getDisplay());
                        }
                        this.ssRepo.save(ssProfile).subscribe();

                        return Mono.just(true);
                    } else {
                        return Mono.just(false);
                    }
                });
    }

    @Override
    public Mono<SkillSetProfile> getSkillSetProfileById(Integer id) {
        return this.ssRepo.findById(id);
    }

    @Override
    public Flux<SkillSetProfile> getSkillSetProfileByName(String skillName) {
        return this.ssRepo.findBySkill(skillName);
    }
}
