package com.questboard.user.service;

import com.questboard.user.entity.ProfessionalLevel;
import com.questboard.user.entity.SkillSetProfile;
import com.questboard.user.entity.User;
import com.questboard.user.enums.Skill;
import com.questboard.user.repository.ProfessionalLevelRepository;
import com.questboard.user.repository.SkillSetProfileRepository;
import com.questboard.user.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.HashMap;
import java.util.stream.Collectors;

@Service
public class SkillSetProfileServiceImpl implements SkillSetProfileService{

    @Autowired
    private SkillSetProfileRepository ssRepo;

    @Autowired
    private UserRepository userRepo;

    @Autowired
    private ProfessionalLevelRepository profLvlRepo;

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Override
    public Flux<SkillSetProfile> getUserSkillSetProfiles(Integer userId) {
        return this.ssRepo.findByUserId(userId);
    }

    @Override
    public Mono<Boolean> setSkillSetProfileVisibility(Integer id, Boolean visibility) {
        return this.ssRepo.findById(id)
                .flatMap(skillSetProfile -> {
                    if (skillSetProfile != null) {
                        skillSetProfile.setDisplay(visibility);
                        this.ssRepo.save(skillSetProfile).subscribe();
                        return Mono.just(true);
                    } else {
                        return Mono.just(false);
                    }
                });
    }

    @Override
    public Mono<SkillSetProfile> createSkillSetProfile(SkillSetProfile skillSetProfile) {
        skillSetProfile.setDisplay(true);
        skillSetProfile.setSkillEndorsed(1L);
        if (skillSetProfile.getUserId() == null) {
            return Mono.error(new Error("User id is not provide, operation exit"));
        }
        return this.ssRepo.findByUserId(skillSetProfile.getUserId())
                .any(s -> s.getSkill().equals(skillSetProfile.getSkill()))
                .flatMap(found -> {
                    if (found) {
                        return Mono.error(new Error("User already has the skill"));
                    } else {
                        return this.ssRepo.save(skillSetProfile);
                    }
                })
                .map(ssp -> {
                    ProfessionalLevel pflvl = new ProfessionalLevel();
                    pflvl.setUserId(ssp.getUserId());
                    pflvl.setLevel(1);
                    pflvl.setExp(1);
                    pflvl.setTitle(ssp.getSkill() + " Novice ");
                    pflvl.setSkillsetProfileId(ssp.getId());
                    this.profLvlRepo.save(pflvl).subscribe();
                    return ssp;
                });
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
    public Flux<User> getSkillSetProfileByName(String skillName) {
//        return this.ssRepo.findBySkill(skillName)
//                .collectList()
//                .map(ssp -> ssp.stream().map(SkillSetProfile::getUserId).collect(Collectors.toList()))
//                .map(ssList -> this.userRepo.findByIdIn(ssList))
//                .map(userFlux -> Flux.just(userFlux));
        return this.ssRepo.findBySkill(skillName)
                .flatMap(ss -> this.userRepo.findById(ss.getUserId()));
    }

    @Override
    public Mono<Void> deleteSkillSetProfileById(Integer id) {
        return this.ssRepo.deleteById(id);
    }
}
