package com.questboard.quest.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.questboard.quest.dto.*;
import com.questboard.quest.entity.*;
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
    public Flux<Quest> getRecommendedQuest(String userName);
    public Mono<List<Quest>> getQuestByRequestor(String userName);
    public Mono<List<Quest>> getQuestByAwardedTo(String userName);
    public Flux<Quest> getQuestByDescription(String desc);
    public Flux<QuestWithLocation> getNearestQuest(Location location);
    public Mono<Quest> createNewQuest(Quest quest);
    public Mono<Quest> updateQuest(Quest quest);
    public Mono<Void> deleteQuest(Integer id);
    public Mono<Boolean> awardQuest(Integer id, String awardedTo);
    public Mono<QuestProposal> createQuestProposal(QuestProposal questProposal, List<SkillSetProfileDto> skillSetProfileDto);
    public Mono<QuestFlow> initialNewQuestFlow(Integer questId);
    public Mono<QuestFlow> updateQuestFlow(QuestFlow questFlow);
    public Mono<QuestFlow> markQuestFlowDone(Integer id);
    public Flux<QuestFlow> getQuestFLow(Integer questId);
    public Mono<QuestRequirement> createQuestRequirement(QuestRequirement questRequirement);
    public Flux<QuestRequirement> getQuestRequirements(Integer questId);
    public Mono<QuestRequirement> updateQuestRequirement(QuestRequirement questRequirement);
    public Mono<Void> deleteQuestRequirement(Integer id);
    public Mono<QuestWithProposal> getQuestWithProposal(Integer questId);
    public Flux<QuestProposal> getQuestProposal(String userName);
    public Mono<QuestUserConcern> createQuestUserConcern(QuestUserConcern questUserConcern);
    public Mono<Void> deleteQuestUserConcern(Integer id);
    public Mono<Void> evaluateQuestProposal(Integer questId);
}

