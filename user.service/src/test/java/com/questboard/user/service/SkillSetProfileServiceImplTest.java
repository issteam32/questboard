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
import java.util.Optional;
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
        when(ssRepo.findBySkill(anyString())).thenAnswer(
                invocationOnMock -> {
                    Object arg = invocationOnMock.getArguments()[0];
                    if (arg == null) {
                        return Flux.empty();
                    } else {
                        return findSkillSetProfile((String)arg);
                    }
                });
        when(ssRepo.findById(anyInt())).thenReturn(fluxSkillSetProfileProvider(1, "id").next());
        when(ssRepo.deleteById(anyInt())).thenAnswer(
                invocationOnMock -> {
                    Object arg = invocationOnMock.getArguments()[0];
                    if (arg == null) {
                        return new Exception("No id provided");
                    } else {
                        List<SkillSetProfile> sspList = new java.util.ArrayList<>(List.of(skillsetProfileProvider()));
                        Optional<SkillSetProfile> ssp = sspList.stream().filter(ss -> ss.getId().equals(arg)).findFirst();
                        if (ssp.isPresent()) {
                            if (sspList.remove(ssp.get())) {
                                return Mono.empty();
                            } else {
                                return new Exception("Unable to delete");
                            }
                        } else {
                            return new Exception("Item not found in list");
                        }
                    }
                });
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
    void shouldSetSkillSetProfileToHidden() {
        when(ssRepo.save(Mockito.any(SkillSetProfile.class))).thenAnswer(
                invocationOnMock -> {
                    Object arg = invocationOnMock.getArguments()[0];
                    if (arg == null) {
                        return new Exception("Unable to find skill set profile");
                    } else {
                        SkillSetProfile ss = (SkillSetProfile) arg;
                        return ss.getDisplay() != null && ss.getId() != null;
                    }
                });
        StepVerifier.create(skillSetProfileService.setSkillSetProfileVisibility(1, false))
                .expectNext(true)
                .expectComplete();
    }

    @Test
    void shouldCreateSkillSetProfile() {
        when(ssRepo.save(Mockito.any(SkillSetProfile.class))).thenAnswer(
                invocationOnMock -> {
                    Object arg = invocationOnMock.getArguments()[0];
                    if (arg == null) {
                        return new Exception("Error when creating new skill set profile");
                    } else {
                        SkillSetProfile ss = (SkillSetProfile) arg;
                        if (ss.getUserId() != null && ss.getSkill() != null && ss.getSkillDesc() != null) {
                            ss.setId(skillsetProfileProvider().length + 1);
                            return Mono.just(ss);
                        } else {
                            return Mono.empty();
                        }
                    }
                });

        SkillSetProfile ssp = new SkillSetProfile();
        ssp.setUserId(1);
        ssp.setSkill(Skill.ACCOUNT_AND_BOOKING.label);
        ssp.setSkillDesc("Very calculative");
        StepVerifier.create(skillSetProfileService.createSkillSetProfile(ssp))
                .expectNextMatches(ss -> ss.getId() != null && ss.getSkill().equals(Skill.ACCOUNT_AND_BOOKING.label))
                .expectComplete();

        ssp = new SkillSetProfile();
        ssp.setUserId(1);
        ssp.setSkill(Skill.GAMING.label);
        ssp.setSkillDesc("I'm carry");
        StepVerifier.create(skillSetProfileService.createSkillSetProfile(ssp))
                .expectError();

        ssp = new SkillSetProfile();
        ssp.setSkill(Skill.ACCOUNT_AND_BOOKING.label);
        ssp.setSkillDesc("Very calculative");
        StepVerifier.create(skillSetProfileService.createSkillSetProfile(ssp))
                .expectError();

    }

    @Test
    void shouldUpdateSkillSetProfile() {
        when(ssRepo.save(Mockito.any(SkillSetProfile.class))).thenAnswer(
                invocationOnMock -> {
                    Object arg = invocationOnMock.getArguments()[0];
                    if (arg == null) {
                        return new Exception("Error when creating new skill set profile");
                    } else {
                        SkillSetProfile ss = (SkillSetProfile) arg;
                        if (ss.getUserId() != null && ss.getSkill() != null && ss.getSkillDesc() != null && ss.getId() != null) {
                            return Mono.just(ss);
                        } else {
                            return Mono.empty();
                        }
                    }
                });

        SkillSetProfile ssp = new SkillSetProfile();
        ssp.setId(1);
        ssp.setUserId(1);
        ssp.setSkill(Skill.ACCOUNT_AND_BOOKING.label);
        ssp.setSkillDesc("Very calculative");
        StepVerifier.create(skillSetProfileService.createSkillSetProfile(ssp))
                .expectNextMatches(ss -> ss.getSkill().equals(Skill.ACCOUNT_AND_BOOKING.label))
                .expectComplete();

    }

    @Test
    void shouldGetSkillSetProfileById() {
        StepVerifier.create(skillSetProfileService.getSkillSetProfileById(2))
                .expectNextMatches(ss -> ss.getSkill().equals(Skill.GAMING.label) && ss.getSkillEndorsed() == 1L)
                .expectComplete();
    }

    @Test
    void shouldGetSkillSetProfileByName() {
        StepVerifier.create(skillSetProfileService.getSkillSetProfileByName(Skill.PHOTOGRAPHY.label))
                .expectNextMatches(user -> user.getId().equals(1))
                .expectNextMatches(user -> user.getId().equals(2))
                .expectComplete();

        StepVerifier.create(skillSetProfileService.getSkillSetProfileByName(Skill.HOUSEKEEPING.label))
                .expectNextMatches(user -> user.getId().equals(1))
                .expectComplete();
    }

    @Test
    void shouldDeleteSkillSetProfileById() {
        StepVerifier.create(skillSetProfileService.deleteSkillSetProfileById(3))
                .expectComplete();
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
                new SkillSetProfile(4, 1, Skill.PHOTOGRAPHY.label, "I can take really good photo", 100L,
                        true, LocalDateTime.now(), LocalDateTime.now()),
        };
    }

    Boolean validateSKillSetProfileCreation(SkillSetProfile ssp) {
        SkillSetProfile[] ssps = skillsetProfileProvider();
        return Arrays.stream(ssps)
                .filter(s -> s.getUserId().equals(ssp.getUserId())).anyMatch(s -> s.getSkill().equals(ssp.getSkill()));
    }

    Flux<SkillSetProfile> findSkillSetProfile(String skill) {
        return Flux.just(skillsetProfileProvider())
                .filter(ss -> ss.getSkill().equals(skill));
    }

    SkillSetProfile newSkillSetProfile() {
        return new SkillSetProfile(5, 2, Skill.COOKING.label, "I'm michilen chef!!",
                200L, true, LocalDateTime.now(), LocalDateTime.now());
    }
}