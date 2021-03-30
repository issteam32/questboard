package com.questboard.quest.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.questboard.quest.dto.ConcernValidationJson;
import com.questboard.quest.dto.QuestWithUserConcern;
import com.questboard.quest.dto.SkillSetProfileDto;
import com.questboard.quest.entity.Location;
import com.questboard.quest.entity.Quest;
import com.questboard.quest.entity.QuestProposal;
import com.questboard.quest.entity.QuestUserConcern;
import com.questboard.quest.repository.QuestProposalRepository;
import com.questboard.quest.repository.QuestRepository;
import com.questboard.quest.repository.QuestUserConcernRepository;
import com.questboard.quest.util.ServiceUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.List;
import java.util.stream.Collectors;

public interface QuestService {
    public Mono<Quest> getQuestById(Integer id);
    public Flux<Quest> getQuestByCategory(Integer category);
    public Flux<Quest> getQuestByCategoryPageable(Integer category, Pageable pageable);
    public Flux<Quest> getEveryDayQuest();
    public Flux<Quest> getRecommendedQuest(Integer userId);
    public Mono<List<Quest>> getQuestByRequestor(Integer userId);
    public Mono<List<Quest>> getQuestByAwardedTo(Integer userId);
    public Flux<Quest> getQuestByDescription(String desc);
    public Flux<Quest> getNearestQuest(Location location);
    public Mono<Quest> createNewQuest(Quest quest);
    public Mono<Quest> updateQuest(Quest quest);
    public Mono<Void> deleteQuest(Integer id);
    public Mono<Boolean> awardQuest(Integer id, Integer awardedTo);
    public Mono<QuestProposal> createQuestProposal(QuestProposal questProposal, List<SkillSetProfileDto> skillSetProfileDto);

}

