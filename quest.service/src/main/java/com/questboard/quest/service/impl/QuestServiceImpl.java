package com.questboard.quest.service.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.questboard.quest.dto.*;
import com.questboard.quest.entity.*;
import com.questboard.quest.repository.*;
import com.questboard.quest.service.QuestService;
import com.questboard.quest.util.ServiceUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.ArrayList;
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

    @Autowired
    private QuestFlowRepository questFlowRepo;

    @Autowired
    private QuestRequirementRepository questReqRepo;

    @Autowired
    private QuestTakerRequestRepository questTakerRequestRepo;

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
     * @param username
     * @return
     */
    @Override
    public Flux<Quest> getRecommendedQuest(String username) {
        return null;
    }

    @Override
    public Mono<List<Quest>> getQuestByRequestor(String username) {
        return this.questRepo.findByRequestor(username)
                .collectList();
    }

    @Override
    public Mono<List<Quest>> getQuestByAwardedTo(String username) {
        return this.questRepo.findByAwardedTo(username)
                .collectList();
    }

    @Override
    public Flux<Quest> getQuestByDescription(String desc) {
        return this.questRepo.findByDescriptionContainingIgnoreCase(desc);
    }

    @Override
    public Flux<QuestWithLocation> getNearestQuest(Location location) {
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
                    if (quest.getCategoryDesc() != null) {
                        q.setCategoryDesc(quest.getCategoryDesc());
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
    public Mono<Boolean> awardQuest(Integer id, String awardedTo) {
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
                    if (tuple != null && tuple.getT1() != null) {
                        logger.debug("tuple result is not null");
                        Quest q = tuple.getT1();
                        List<QuestUserConcern> questUserConcerns = new ArrayList<>();
                        if (! tuple.getT2().isEmpty()) {
                            questUserConcerns.addAll(tuple.getT2());
                        }
                        return Mono.just(new QuestWithUserConcern(q, questUserConcerns));
                    } else {
                        return Mono.empty();
                    }
                });

        return questWithUserConcerns
                .flatMap(questWithUserConcern -> {
                    logger.info("there are something user is concern with their quests");
                    String proposalJson = questProposal.getProposalJson();
                    String skillRequired = questWithUserConcern.getQuest().getSkillRequired();
                    List<ConcernValidationJson> concernValidationJsons = questWithUserConcern.getQuestUserConcern()
                            .stream()
                            .map(questUserConcern -> {
                                ObjectMapper mapper = new ObjectMapper();
                                try {
                                    return mapper.readValue(questUserConcern.getConcernValidation(), ConcernValidationJson.class);
                                } catch (JsonProcessingException e) {
                                    e.printStackTrace();
                                    return new ConcernValidationJson();
                                }
                            }).collect(Collectors.toList());
                    logger.info("concern validation list: {}", concernValidationJsons);
                    double score = ServiceUtils.proposalScoreCounting(proposalJson, concernValidationJsons, skillRequired, skillSetProfileList);
                    questProposal.setProposalScore(score);
                    return this.questProposalRepo.save(questProposal);
                })
                .switchIfEmpty(Mono.defer(() -> this.questProposalRepo.save(questProposal)));
    }

    @Override
    public Mono<Void> evaluateQuestProposal(Integer questId) {
        Mono<Quest> quest = this.questRepo.findById(questId);
        Mono<List<QuestUserConcern>> questUserConcernList = this.questUserConcernRepo
                .findByQuestId(questId).collectList();
        Mono<List<QuestProposal>> questProposals = this.questProposalRepo.findByQuestId(questId).collectList();

        Mono<QuestNConcernNProposal> questNConcernNProposalMono = quest.zipWith(questUserConcernList).zipWith(questProposals)
                .flatMap(tuple -> {
                    logger.info("tuple result, {}", tuple);
                    if (tuple != null && tuple.getT1() != null) {
                        logger.debug("tuple result is not null");
                        Quest q = tuple.getT1().getT1();
                        List<QuestUserConcern> questUserConcerns = new ArrayList<>();
                        if (! tuple.getT1().getT2().isEmpty()) {
                            questUserConcerns.addAll(tuple.getT1().getT2());
                        }
                        List<QuestProposal> questProposalsList = new ArrayList<>();
                        if (! tuple.getT2().isEmpty()) {
                            questProposalsList.addAll(tuple.getT2());
                        }

                        return Mono.just(new QuestNConcernNProposal(q, questUserConcerns, questProposalsList));
                    } else {
                        return Mono.empty();
                    }
                });

        return questNConcernNProposalMono
                .flatMap(questNConcernNProposal -> {
                    for (QuestProposal proposal: questNConcernNProposal.getQuestProposal()) {
                        String proposalJson = proposal.getProposalJson();
                        String skillRequired = questNConcernNProposal.getQuest().getSkillRequired();
                        List<ConcernValidationJson> concernValidationJsons = questNConcernNProposal.getQuestUserConcern()
                                .stream()
                                .map(questUserConcern -> {
                                    ObjectMapper mapper = new ObjectMapper();
                                    try {
                                        return mapper.readValue(questUserConcern.getConcernValidation(), ConcernValidationJson.class);
                                    } catch (JsonProcessingException e) {
                                        e.printStackTrace();
                                        return new ConcernValidationJson();
                                    }
                                }).collect(Collectors.toList());

                        logger.info("concern validation list: {}", concernValidationJsons);
                        List<SkillSetProfileDto> emptyList = new ArrayList<>();
                        double score = ServiceUtils.proposalScoreCounting(proposalJson, concernValidationJsons, skillRequired, emptyList);
                        logger.info("quest reevaluate score: {}", score);
                        if (proposal.getProposalScore() != null && proposal.getProposalScore() >= 40) {
                            score = (score / 100.0) * 60.0;
                            score += proposal.getProposalScore();
                        }
                        logger.info("quest reevaluate score added with original score: {}", score);
                        proposal.setProposalScore(score);
                        this.questProposalRepo.save(proposal).subscribe();
                    }
                    return Mono.empty();
                });
    }

    @Override
    public Mono<QuestFlow> initialNewQuestFlow(Integer questId) {
        QuestFlow questFlow = new QuestFlow(questId, 1, "", "");
        return this.questFlowRepo.save(questFlow);
    }

    @Override
    public Mono<QuestFlow> updateQuestFlow(QuestFlow questFlow) {
        return this.questFlowRepo.findById(questFlow.getId())
                .flatMap(qf -> {
                    if (questFlow.getRequestorRemarks() != null) {
                        qf.setRequestorRemarks(questFlow.getRequestorRemarks());
                    }
                    if (questFlow.getTakerRemarks() != null) {
                        qf.setTakerRemarks(questFlow.getTakerRemarks());
                    }
                    return this.questFlowRepo.save(qf);
                });
    }

    @Override
    public Mono<QuestFlow> markQuestFlowDone(Integer id) {
        return questFlowRepo.findById(id)
                .flatMap(qf -> {
                   if (qf.getStage().equals(3)) {
                       return Mono.just(qf);
                   } else {
                       qf.setStage(qf.getStage() + 1);
                       return this.questFlowRepo.save(qf);
                   }
                });
    }

    @Override
    public Flux<QuestFlow> getQuestFLow(Integer questId) {
        return this.questFlowRepo.findByQuestId(questId);
    }

    @Override
    public Mono<QuestRequirement> createQuestRequirement(QuestRequirement questRequirement) {
        return this.questReqRepo.save(questRequirement);
    }

    @Override
    public Flux<QuestRequirement> getQuestRequirements(Integer questId) {
        return this.questReqRepo.findByQuestId(questId);
    }

    @Override
    public Mono<QuestRequirement> updateQuestRequirement(QuestRequirement questRequirement) {
        return this.questReqRepo.findById(questRequirement.getId())
                .flatMap(qr -> {
                    if (questRequirement.getRequirement() != null) {
                        qr.setRequirement(questRequirement.getRequirement());
                    }
                    return this.questReqRepo.save(qr);
                });
    }

    @Override
    public Mono<Void> deleteQuestRequirement(Integer id) {
        return this.questReqRepo.deleteById(id);
    }

    @Override
    public Mono<QuestWithProposal> getQuestWithProposal(Integer questId) {
        Mono<Quest> quest = this.questRepo.findById(questId);
        Mono<List<QuestProposal>> questProposals = this.questProposalRepo
                .findByQuestId(questId).collectList();
        return quest.zipWith(questProposals)
                .flatMap(tuple -> {
                    Quest q = tuple.getT1();
                    List<QuestProposal> qpList = tuple.getT2();
                    return Mono.just(new QuestWithProposal(q, qpList));
                });
    }

    @Override
    public Flux<QuestProposal> getQuestProposal(String userName) {
        return this.questProposalRepo.findByUsername(userName);
    }

    @Override
    public Mono<QuestUserConcern> createQuestUserConcern(QuestUserConcern questUserConcern) {
        return this.questUserConcernRepo.save(questUserConcern);
    }

    @Override
    public Mono<Void> deleteQuestUserConcern(Integer id) {
        return this.questUserConcernRepo.deleteById(id);
    }

    @Override
    public Mono<Void> deleteQuestProposal(Integer id) {
        return this.questProposalRepo.deleteById(id);
    }

    @Override
    public Mono<QuestTakerRequest> createQuestTakerRequest(QuestTakerRequest questTakerRequest) {
        return this.questTakerRequestRepo
                .existsByUsernameAndQuestId(questTakerRequest.getUsername(), questTakerRequest.getQuestId())
                .flatMap(exist -> {
                    if (exist) {
                        logger.info("User has created request for this quest");
                        return Mono.empty();
                    } else {
                        return this.questTakerRequestRepo.save(questTakerRequest);
                    }
                });
    }

    @Override
    public Mono<QuestTakerRequest> updateQuestTakerRequest(Integer id, String status) {
        return this.questTakerRequestRepo.findById(id)
                .flatMap(questTakerReq -> {
                    if ("REQ".equalsIgnoreCase(status)) {
                        questTakerReq.setStatus("REQUESTED");
                    } else if ("AWA".equalsIgnoreCase(status)) {
                        questTakerReq.setStatus("AWARDED");
                    }
                    return this.questTakerRequestRepo.save(questTakerReq);
                });
    }

    @Override
    public Flux<QuestTakerRequest> getQuestTakerRequestByQuestId(Integer questId) {
        return this.questTakerRequestRepo.findByQuestId(questId);
    }

    @Override
    public Mono<QuestTakerRequest> getQuestTakerRequestById(Integer id) {
        return this.questTakerRequestRepo.findById(id);
    }

    @Override
    public Mono<Void> deleteQuestTakerRequest(Integer id) {
        return this.questTakerRequestRepo.deleteById(id);
    }

    @Override
    public Flux<Quest> getUserProposedQuests(String username) {
        return this.questRepo.findProposedQuestByUsername(username);
    }
}
