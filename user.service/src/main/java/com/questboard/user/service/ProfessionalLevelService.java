package com.questboard.user.service;

import com.questboard.user.entity.ProfessionalLevel;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

public interface ProfessionalLevelService {
    public Mono<ProfessionalLevel> getProfessionalLevelById(Integer id);
    public Flux<ProfessionalLevel> getProfessionalLevelBySkillId(Integer skillId);
    public Mono<ProfessionalLevel> updateProfessionalLevel(ProfessionalLevel profLvl);
    public Mono<Void> deleteProfessionalLevelById(Integer id);
}
