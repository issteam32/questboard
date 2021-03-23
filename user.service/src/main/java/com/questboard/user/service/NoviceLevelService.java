package com.questboard.user.service;

import com.questboard.user.entity.NoviceLevel;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

public interface NoviceLevelService {
    public Mono<NoviceLevel> createNoviceLevel(NoviceLevel noviceLevel);
    public Mono<NoviceLevel> updateNoviceLevel(NoviceLevel noviceLevel);
    public Mono<NoviceLevel> getNoviceLevelById(Integer id);
    public Flux<NoviceLevel> getNoviceLevelByTitle(String title);
    public Mono<NoviceLevel> getUserNoviceLevel(Integer userId);
}
