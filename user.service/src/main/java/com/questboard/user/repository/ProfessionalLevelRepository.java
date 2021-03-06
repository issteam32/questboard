package com.questboard.user.repository;

import com.questboard.user.entity.ProfessionalLevel;
import com.questboard.user.entity.SkillSetProfile;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

public interface ProfessionalLevelRepository extends ReactiveCrudRepository<ProfessionalLevel, Integer> {
    public Flux<ProfessionalLevel> findByUserId(Integer userId);
    public Flux<ProfessionalLevel> findByskillsetProfileId(Integer skillsetProfileId);
}
