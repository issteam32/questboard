package com.questboard.quest.service;

import com.questboard.quest.dto.SkillSetProfileDto;
import com.questboard.quest.entity.Location;
import com.questboard.quest.entity.Quest;
import com.questboard.quest.entity.QuestProposal;
import org.springframework.data.domain.Pageable;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.List;

public interface QuestService {
    public Mono<Quest> getQuestById(Integer id);
    public Flux<Quest> getQuestByCategory(Integer category);
    public Flux<Quest> getQuestByCategoryPageable(Integer category, Pageable pageable);
    public Flux<Quest> getEveryDayQuest();
    public Flux<Quest> getRecommendedQuest(Integer userId);
    public Mono<List<Quest>> getQuestByUserId(Integer userId);
    public Flux<Quest> getQuestByDescription(String desc);
    public Flux<Quest> getNearestQuest(Location location);
    public Mono<Quest> createNewQuest(Quest quest);
    public Mono<Quest> updateQuest(Quest quest);
    public Mono<Void> deleteQuest(Integer id);
    public Mono<Boolean> awardQuest(Integer id, Integer awardedTo);
    public Mono<QuestProposal> createQuestProposal(QuestProposal questProposal, List<SkillSetProfileDto> skillSetProfileDto);
}

