package com.questboard.user.repository;

import com.questboard.user.entity.SkillSetProfile;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;
import reactor.core.publisher.Flux;

public interface SkillSetProfileRepository extends ReactiveCrudRepository<SkillSetProfile, Integer> {
    public Flux<SkillSetProfile> findByUserId(Integer userId);

    public Flux<SkillSetProfile> findBySkill(String skill);
}
