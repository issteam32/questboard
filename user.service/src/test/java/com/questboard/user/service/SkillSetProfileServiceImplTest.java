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

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.when;

class SkillSetProfileServiceImplTest {

    @Mock
    SkillSetProfileRepository ssRepo;

    @InjectMocks
    SkillSetProfileServiceImpl skillSetProfileService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.initMocks(this);
        when(ssRepo.findByUserId(1)).thenReturn(fluxSkillSetProfileProvider(1));
        when(ssRepo.save(Mockito.any(SkillSetProfile.class))).thenAnswer(
                invocationOnMock -> {
                   Object arg = invocationOnMock.getArguments()[0];
                   if (arg == null) {
                       return false;
                   } else {
                       SkillSetProfile ss = (SkillSetProfile)arg;
                       if (ss.getUserId() != null && ss.getSkill() != null && ss.getSkillDesc() != null) {
                           if (validateSKillSetProfileCreation(ss)) {
                               return false;
                           } else {
                               return true;
                           }
                       } else {
                           return false;
                       }
                   }
                });
    }

    @AfterEach
    void tearDown() {
    }

    @Test
    void getUserSkillSetProfiles() {
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

    Flux<SkillSetProfile> fluxSkillSetProfileProvider(int userId) {
        SkillSetProfile[] ss = skillsetProfileProvider();
        return Flux.fromStream(Arrays.stream(ss)
                .filter(ssp -> ssp.getUserId() == userId));
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

    SkillSetProfile newSkillSetProfile() {
        return new SkillSetProfile(4, 2, Skill.COOKING.label, "I'm michilen chef!!",
                200L, true, LocalDateTime.now(), LocalDateTime.now());
    }
}