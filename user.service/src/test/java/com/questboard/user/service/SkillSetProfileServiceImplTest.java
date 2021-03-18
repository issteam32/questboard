package com.questboard.user.service;

import com.questboard.user.entity.SkillSetProfile;
import com.questboard.user.enums.Skill;
import com.questboard.user.repository.SkillSetProfileRepository;
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

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;

class SkillSetProfileServiceImplTest {

    @Mock
    SkillSetProfileRepository ssRepo;

    @InjectMocks
    SkillSetProfileServiceImpl skillSetProfileService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.initMocks(this);
        when(ssRepo.findByUserId(anyInt())).thenReturn(fluxSkillSetProfileProvider(1, "userId"));
        when(ssRepo.save(Mockito.any(SkillSetProfile.class))).thenAnswer(
                invocationOnMock -> {
                    Object arg = invocationOnMock.getArguments()[0];
                    if (arg == null) {
                        return false;
                    } else {
                        SkillSetProfile ss = (SkillSetProfile)arg;
                        if (ss.getDisplay() != null) {
                            return true;
                        } else if (ss.getUserId() != null && ss.getSkill() != null && ss.getSkillDesc() != null) {
                            if (ss.getId() != null) {
                                return true;
                            } else {
                                return !validateSKillSetProfileCreation(ss);
                           }
                        } else {
                           return false;
                        }
                    }
                });
        when(ssRepo.findBySkill(anyString())).thenAnswer(
                invocationOnMock -> {
                    Object arg = invocationOnMock.getArguments()[0];
                    if (arg == null) {
                        return null;
                    } else {
                        return findSkillSetProfile((String)arg);
                    }
                });
        when(ssRepo.findById(anyInt())).thenReturn(fluxSkillSetProfileProvider(1, "id").next());
    }

    @AfterEach
    void tearDown() {
    }

    @Test
    void shouldGetSkillProfileByUserId() {
        StepVerifier.create(skillSetProfileService.getUserSkillSetProfiles(1))
                .expectNextMatches(ss -> ss.getUserId() == 1 && !ss.getSkill().isBlank())
                .expectNextMatches(ss -> ss.getUserId() == 1 && !ss.getSkill().isBlank())
                .verifyComplete();

        // if expect nothing return then directly expectComplete, since there are nothing to emit
        StepVerifier.create(skillSetProfileService.getUserSkillSetProfiles(4))
                .expectComplete();

    }

    @Test
    void setSkillSetProfileVisibility() {
    }

    @Test
    void createSkillSetProfile() {
    }

    @Test
    void updateSkillSetProfile() {
    }

    @Test
    void getSkillSetProfileById() {
    }

    @Test
    void getSkillSetProfileByName() {
    }

    Flux<SkillSetProfile> fluxSkillSetProfileProvider() {
        return Flux.just(skillsetProfileProvider());
    }

    Flux<SkillSetProfile> fluxSkillSetProfileProvider(int id, String type) {
        SkillSetProfile[] ss = skillsetProfileProvider();
        return Flux.fromStream(Arrays.stream(ss)
                .filter(ssp -> type.equals("userId") ? ssp.getUserId() == id : ssp.getId() == id));
    }

    SkillSetProfile[] skillsetProfileProvider() {
        return new SkillSetProfile[] {
                new SkillSetProfile(1, 1, Skill.HOUSEKEEPING.label, "Keep the house as clean as detol",
                  20L, true, LocalDateTime.now(), LocalDateTime.now()),
                new SkillSetProfile(2, 1, Skill.GAMING.label, "I can support you in Dota",
                        1L, true, LocalDateTime.now(), LocalDateTime.now()),
                new SkillSetProfile(3, 2, Skill.PHOTOGRAPHY.label, "I won Nobel with my Photo", 1000L,
                        true, LocalDateTime.now(), LocalDateTime.now()),
        };
    }

    Boolean validateSKillSetProfileCreation(SkillSetProfile ssp) {
        SkillSetProfile[] ssps = skillsetProfileProvider();
        return Arrays.stream(ssps)
                .filter(s -> s.getUserId().equals(ssp.getUserId())).anyMatch(s -> s.getSkill().equals(ssp.getSkill()));
    }

    Mono<SkillSetProfile> findSkillSetProfile(String skill) {
        SkillSetProfile[] ssps = skillsetProfileProvider();
        return fluxSkillSetProfileProvider().filter(ss -> ss.getSkill().equals(skill)).next();
    }

    SkillSetProfile newSkillSetProfile() {
        return new SkillSetProfile(4, 2, Skill.COOKING.label, "I'm michilen chef!!",
                200L, true, LocalDateTime.now(), LocalDateTime.now());
    }
}