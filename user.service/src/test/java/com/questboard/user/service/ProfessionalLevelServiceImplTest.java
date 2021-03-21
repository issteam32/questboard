package com.questboard.user.service;

import com.questboard.user.entity.ProfessionalLevel;
import com.questboard.user.repository.ProfessionalLevelRepository;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.Mockito.when;


class ProfessionalLevelServiceImplTest {

    @Mock
    ProfessionalLevelRepository profRepo;

    @InjectMocks
    ProfessionalLevelServiceImpl profService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.initMocks(this);
        when(profRepo.findByskillsetProfileId(anyInt())).thenReturn(monoProfessionalProvider(1, "skillSetProfileId"));
        when(profRepo.findById(anyInt())).thenReturn(monoProfessionalProvider(2, "id").next());
        when(profRepo.save(Mockito.mock(ProfessionalLevel.class))).thenAnswer(
                invocationOnMock -> {
                    Object arg = invocationOnMock.getArguments()[0];
                    if (arg == null) {
                        return Mono.error(new Error("Error when creating new professional level"));
                    } else {
                        ProfessionalLevel pflvl = (ProfessionalLevel) arg;
                        if (pflvl.getId() == null) {
                            return Mono.error(new Error("Error when updating professional level"));
                        } else {
                            if (pflvl.getTitle() != null && pflvl.getExp() != null) {
                                return pflvl;
                            } else {
                                return Mono.error(new Error("Error when updating professional level"));
                            }
                        }
                    }
                });
    }

    @AfterEach
    void tearDown() {
    }

    @Test
    void shouldGetProfessionalLevelById() {
        StepVerifier.create(profService.getProfessionalLevelById(2))
                .expectNextMatches(pl -> pl.getUserId().equals(2) && pl.getLevel().equals(10))
                .expectComplete();
    }

    @Test
    void shouldGetProfessionalLevelBySkillId() {
        StepVerifier.create(profService.getProfessionalLevelBySkillId(1))
                .expectNextMatches(pl -> pl.getUserId().equals(1) && pl.getLevel().equals(10))
                .expectComplete();
    }

    @Test
    void updateProfessionalLevel() {
    }

    @Test
    void deleteProfessionalLevelById() {
    }

    Flux<ProfessionalLevel> monoProfessionalProvider(Integer id, String type) {
        Flux<ProfessionalLevel> profLvlFlux = fluxProfessionalProvider();
        return profLvlFlux
                .filter(plvl -> type.equals("id") ? plvl.getId().equals(id) : plvl.getSkillsetProfileId().equals(id));
    }

    Flux<ProfessionalLevel> fluxProfessionalProvider() {
        return Flux.just(professionalLevelProvider());
    }

    ProfessionalLevel[] professionalLevelProvider() {
        return new ProfessionalLevel[] {
                new ProfessionalLevel(1, 1, 10, 1, "Cooking Master", 1),
                new ProfessionalLevel(2, 2, 8, 99, "Photograph Master", 2)
        };
    }
}