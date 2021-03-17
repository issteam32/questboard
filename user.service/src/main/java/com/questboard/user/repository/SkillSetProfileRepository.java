package com.questboard.user.repository;

import com.questboard.user.entity.SkillSetProfile;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;

public interface SkillSetProfileRepository extends ReactiveCrudRepository<SkillSetProfile, Integer> {
}
