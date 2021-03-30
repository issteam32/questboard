package com.questboard.quest.service.impl;

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
import com.questboard.quest.service.QuestService;
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

@Service
public
class QuestServiceImpl implements QuestService {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private QuestRepository questRepo;

    @Autowired
    private QuestProposalRepository questProposalRepo;

    @Autowired
    private QuestUserConcernRepository questUserConcernRepo;

    @Override
    public Mono<Quest> getQuestById(Integer id) {
        return this.questRepo.findById(id);
    }

    @Override
    public Flux<Quest> getQuestByCategory(Integer category) {
        return this.questRepo.findByCategory(category);
    }

    @Override
    public Flux<Quest> getEveryDayQuest() {
        return this.questRepo.findByCategory(0);
    }

    /**
     * call external recommendation service
     * @param userId
     * @return
     */
    @Override
    public Flux<Quest> getRecommendedQuest(Integer userId) {
        return null;
    }

    @Override
    public Mono<List<Quest>> getQuestByRequestor(Integer userId) {
        return this.questRepo.findByRequestor(userId)
                .collectList();
    }

    @Override
    public Mono<List<Quest>> getQuestByAwardedTo(Integer userId) {
        return this.questRepo.findByAwardedTo(userId)
                .collectList();
    }

    @Override
    public Flux<Quest> getQuestByDescription(String desc) {
        return this.questRepo.findByDescriptionContainingIgnoreCase(desc);
    }

    @Override
    public Flux<Quest> getNearestQuest(Location location) {
        return null;
    }

    @Override
    public Mono<Quest> createNewQuest(Quest quest) {
        return this.questRepo.save(quest);
    }

    @Override
    public Mono<Quest> updateQuest(Quest quest) {
        return this.questRepo.findById(quest.getId())
                .flatMap(q -> {
                    if (quest.getAwardedTo() != null) {
                        q.setAwarded(quest.getAwarded());
                    }
                    if (quest.getCategory() != null) {
                        q.setCategory(quest.getCategory());
                    }
                    if (quest.getDescription() != null) {
                        q.setDescription(quest.getDescription());
                    }
                    if (quest.getLocation() != null) {
                        q.setLocation(quest.getLocation());
                    }
                    if (quest.getDifficultyLevel() != null) {
                        q.setDifficultyLevel(quest.getDifficultyLevel());
                    }
                    if (quest.getDescription() != null) {
                        q.setDescription(quest.getDescription());
                    }
                    if (quest.getAwarded() != null) {
                        q.setAwarded(quest.getAwarded());
                    }
                    if (quest.getReward() != null && q.getAwarded().equals(false)) {
                        q.setReward(quest.getReward());
                    }
                    if (quest.getRewardType() != null && q.getAwarded().equals(false)) {
                        q.setRewardType(quest.getRewardType());
                    }
                    if (quest.getStatus() != null) {
                        q.setStatus(quest.getStatus());
                    }
                    if (quest.getTitle() != null && q.getAwarded().equals(false)) {
                        q.setTitle(quest.getTitle());
                    }
                    return this.questRepo.save(q);
                })
                .switchIfEmpty(Mono.defer(() -> Mono.error(new Error("No quest found with provided info"))));
    }

    @Override
    public Mono<Void> deleteQuest(Integer id) {
        return this.questRepo.deleteById(id);
    }

    @Override
    public Mono<Boolean> awardQuest(Integer id, Integer awardedTo) {
        return this.questRepo.findById(id)
                .flatMap(q -> {
                    q.setAwarded(true);
                    q.setAwardedTo(awardedTo);
                    this.questRepo.save(q).subscribe();
                    return Mono.just(true);
                })
                .switchIfEmpty(Mono.defer(() -> Mono.just(false)));
    }

    @Override
    public Flux<Quest> getQuestByCategoryPageable(Integer category, Pageable pageable) {
        return this.questRepo.findByCategoryOrderByUpdatedDate(category, pageable);
    }

    /**
     * check if quest exist and user concern exist, then creat proposal record with calculated score if exist,vice versa
     * @param questProposal
     * @param skillSetProfileList
     * @return
     */
    @Override
    public Mono<QuestProposal> createQuestProposal(QuestProposal questProposal, List<SkillSetProfileDto> skillSetProfileList) {
        Mono<Quest> quest = this.questRepo.findById(questProposal.getQuestId());
        Mono<List<QuestUserConcern>> questUserConcernList = this.questUserConcernRepo
                .findByQuestId(questProposal.getQuestId()).collectList();

        Mono<QuestWithUserConcern> questWithUserConcerns = quest.zipWith(questUserConcernList)
                .flatMap(tuple -> {
                    logger.info("tuple result, {}", tuple);
                    if (tuple != null && tuple.getT2().isEmpty()) {
                        Quest q = tuple.getT1();
                        List<QuestUserConcern> questUserConcerns = tuple.getT2();
                        return Mono.just(new QuestWithUserConcern(q, questUserConcerns));
                    } else {
                        return Mono.empty();
                    }
                });

        return questWithUserConcerns
                .flatMap(questWithUserConcern -> {
                    String proposalJson = questProposal.getProposalJson();
                    String skillRequired = questWithUserConcern.getQuest().getSkillRequired();
                    List<ConcernValidationJson> concernValidationJsons = questWithUserConcern.getQuestUserConcern()
                            .stream()
                            .map(questUserConcern -> {
                                ObjectMapper mapper = new ObjectMapper();
                                return mapper.convertValue(questUserConcern.getConcernValidation(), ConcernValidationJson.class);
                            }).collect(Collectors.toList());
                    double score = ServiceUtils.proposalScoreCounting(proposalJson, concernValidationJsons, skillRequired, skillSetProfileList);
                    questProposal.setProposalScore(score);
                    return this.questProposalRepo.save(questProposal);
                })
                .switchIfEmpty(Mono.defer(() -> this.questProposalRepo.save(questProposal)));
    }
}
