package com.questboard.user.service;

import com.questboard.user.entity.ProfessionalLevel;
import com.questboard.user.repository.ProfessionalLevelRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@Service
public class ProfessionalLevelServiceImpl implements ProfessionalLevelService{

    @Autowired
    private ProfessionalLevelRepository profLvlRepo;

    @Override
    public Mono<ProfessionalLevel> getProfessionalLevelById(Integer id) {
        return this.profLvlRepo.findById(id);
    }

    @Override
    public Flux<ProfessionalLevel> getProfessionalLevelBySkillId(Integer skillId) {
        return this.profLvlRepo.findByskillsetProfileId(skillId);
    }

    @Override
    public Mono<ProfessionalLevel> updateProfessionalLevel(ProfessionalLevel profLvl) {
        if (profLvl.getId() == null || profLvl.getSkillsetProfileId() == null) {
            Mono.error(new Error("No id provided, update operation exit"));
        }
        return this.profLvlRepo.findById(profLvl.getId())
                .flatMap(professionalLevel -> {
                    if (profLvl.getExp() != null) {
                        professionalLevel.setExp(profLvl.getExp() + professionalLevel.getExp());
                        if (professionalLevel.getExp() >= 100) {
                            professionalLevel.levelUp();
                            professionalLevel.setExp(professionalLevel.getExp() - 100);
                        }
                    }
                    if (profLvl.getTitle() != null) {
                        professionalLevel.setTitle(profLvl.getTitle());
                    }
                    return this.profLvlRepo.save(professionalLevel);
                });
    }

    @Override
    public Mono<Void> deleteProfessionalLevelById(Integer id) {
        return this.profLvlRepo.deleteById(id);
    }
}
