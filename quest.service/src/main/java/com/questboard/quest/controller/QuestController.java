package com.questboard.quest.controller;

import com.questboard.quest.dto.QuestWithProposal;
import com.questboard.quest.dto.QuestWithToken;
import com.questboard.quest.dto.SkillSetProfileDto;
import com.questboard.quest.entity.*;
import com.questboard.quest.enums.QuestCategory;
import com.questboard.quest.service.ActiveMQSenderService;
import com.questboard.quest.service.QuestService;
import com.questboard.quest.util.ReqBodyUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/q/v1")
public class QuestController {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private QuestService questService;

    @Autowired
    private ActiveMQSenderService questSender;

    @GetMapping("/health-check")
    public ResponseEntity<String> redinessCheck() {
        return ResponseEntity.status(200).body("Ok");
    }

    @RequestMapping(value = "/quest/{id}", method = RequestMethod.GET)
    public Mono<Quest> getQuestById(@PathVariable("id") Integer id) {
        return this.questService.getQuestById(id)
                .onErrorResume(error -> {
                    logger.error("Get quest error, (id {}), error: {}", id, error.getMessage());
                    return Mono.empty();
                });
    }

    @RequestMapping(value = "/user-quest", method = RequestMethod.GET)
    public Mono<List<Quest>> getQuestByUserId(JwtAuthenticationToken token, @RequestParam("type") String type) {
        String username = token.getToken().getClaim("preferred_username");
        if (type.equals("requestor")) {
            return this.questService.getQuestByRequestor(username)
                    .onErrorResume(error -> {
                        logger.error("Get users's quest error, (id {}), error: {}", username, error.getMessage());
                        return Mono.empty();
                    });
        } else if (type.equals("taker")) {
            return this.questService.getQuestByAwardedTo(username)
                    .onErrorResume(error -> {
                        logger.error("Get users's quest error, (id {}), error: {}", username, error.getMessage());
                        return Mono.empty();
                    });
        } else {
            return Mono.empty();
        }
    }

    @RequestMapping(value = "/quest", method = RequestMethod.POST)
    public Mono<Quest> createQuest(JwtAuthenticationToken token, @RequestBody HashMap<String, Object> param) {
        String username = token.getToken().getClaim("preferred_username");
        Quest quest = (Quest)ReqBodyUtils.convertValue(param, Quest.class);
        quest.setStatus("PUBLISHED");
        quest.setRequestor(username);
        return this.questService.createNewQuest(quest)
                .flatMap(q -> {
                    if (q.getCategory() == 0) {
                        try {
                            sendQuestAutoAssignSignal(token, q);
                        } catch (Exception exception) {
                            exception.printStackTrace();
                            logger.error("failed to auto allocate user for quest");
                        }
                    }
                    return Mono.just(q);
                })
                .onErrorResume(error -> {
                    logger.error("Creating new quest, error: {}", error.getMessage());
                    return Mono.error(new Error(error.getMessage()));
                });
    }

    @RequestMapping(value = "/quest/{id}", method = RequestMethod.POST)
    public Mono<Quest> updateQuest(@RequestBody HashMap<String, Object> param, @PathVariable("id") Integer id) {
        if (id == null) {
            return Mono.error(new Error("No id provided"));
        }
        Quest quest = (Quest) ReqBodyUtils.convertValue(param, Quest.class);
        quest.setId(id);
        return this.questService.updateQuest(quest)
                .onErrorResume(error -> {
                    logger.error("Update quest, error: {}", error.getMessage());
                    return Mono.error(new Error(error.getMessage()));
                });
    }

    @RequestMapping(value = "/quest/category", method = RequestMethod.GET)
    public Flux<Quest> getQuestByCategory(@RequestParam("category") String category, @RequestParam("page") Integer page,
                                          @RequestParam("limit") Integer limit) {
        if (category == null || page == null || limit == null) {
            return Flux.empty();
        } else {
            Pageable pageable = PageRequest.of(page, limit);
            Integer cat = category.equalsIgnoreCase("professional") ? QuestCategory.PROFESSIONAL.value : QuestCategory.EVERYDAY.value;
            return this.questService.getQuestByCategoryPageable(cat, pageable)
                    .onErrorResume(error -> {
                        logger.error("Unable to retrieve paged quest, error: {}", error.getMessage());
                        return Mono.error(new Error(error.getMessage()));
                    });
        }
    }

    @RequestMapping(value = "/quest/{id}", method = RequestMethod.DELETE)
    public Mono<Void> deleteQuest(@PathVariable("id") Integer id) {
        return this.questService.deleteQuest(id)
                .onErrorResume(error -> {
                    logger.error("Unable to delete quest, error: {}", error.getMessage());
                    return Mono.error(new Error(error.getMessage()));
                });
    }

    @RequestMapping(value = "/quest/award/{id}", method = RequestMethod.POST)
    public Mono<Boolean> awardQuest(@RequestBody HashMap<String, String> param, @PathVariable("id") Integer id) {
        if (id == null || param.isEmpty()) {
            return Mono.just(false);
        } else {
            String username;
            if (param.containsKey("awardTo")) {
                username = param.get("awardTo");
            } else {
                return Mono.just(false);
            }
            return this.questService.awardQuest(id, username);
        }
    }

    @RequestMapping(value = "/quest/proposal", method = RequestMethod.POST)
    public Mono<QuestProposal> createProfessionalQuestProposal(@RequestBody HashMap<String, Object> param) {
        if (! param.containsKey("proposal") || !param.containsKey("skillSetProfileList")) {
            return Mono.error(new Error("no skillset profile or proposal found!"));
        }
        HashMap<String, Object> proposalMap = (HashMap<String, Object>) param.get("proposal");
        List<HashMap<String, Object>> skillsetProfileList = (List<HashMap<String, Object>>)param.get("skillSetProfileList");
        List<SkillSetProfileDto> skillSetProfileDtos = skillsetProfileList.stream()
                .map(mapObject -> (SkillSetProfileDto)ReqBodyUtils.convertValue(mapObject, SkillSetProfileDto.class))
                .collect(Collectors.toList());

        QuestProposal questProposal = (QuestProposal) ReqBodyUtils
                .convertValue(proposalMap, QuestProposal.class);

        return this.questService.createQuestProposal(questProposal, skillSetProfileDtos)
                .onErrorResume(error -> {
                    logger.error("Unable to create quest proposal, error: {}", error.getMessage());
                    return Mono.error(new Error(error.getMessage()));
                });
    }

    @RequestMapping(value = "/quest/proposal/{id}", method = RequestMethod.DELETE)
    public Mono<Void> deleteQuestProposal(@PathVariable("id") Integer id) {
        return this.questService.deleteQuestProposal(id);
    }

    @RequestMapping(value = "/quest/flow", method = RequestMethod.POST)
    public Mono<QuestFlow> createNewQuestFlow(@RequestBody HashMap<String, String> param) {
        if (! param.containsKey("questId")) {
            return Mono.error(new Error("No quest id provided"));
        }
        return this.questService.initialNewQuestFlow(Integer.parseInt(param.get("questId")));
    }

    @RequestMapping(value = "/quest/flow{id}", method = RequestMethod.GET)
    public Flux<QuestFlow> getQuestFlow(@PathVariable("questId") Integer questId) {
        return this.questService.getQuestFLow(questId);
    }

    @RequestMapping(value = "/quest/flow/{id}", method = RequestMethod.POST)
    public Mono<QuestFlow> markQuestFlowDone(@PathVariable("questId") Integer questId) {
        return this.questService.markQuestFlowDone(questId);
    }

    @RequestMapping(value = "/quest/flow", method = RequestMethod.PUT)
    public Mono<QuestFlow> updateQuestFlow(@RequestBody HashMap<String, String> param) {
        if (! param.containsKey("questId") || ! param.containsKey("id")) {
            return Mono.error(new Error("No id or quest id provided"));
        }
        QuestFlow questFlow = (QuestFlow) ReqBodyUtils.convertValue(param, QuestFlow.class);
        return this.questService.updateQuestFlow(questFlow);
    }

    @RequestMapping(value = "/quest/requirement", method = RequestMethod.POST)
    public Mono<QuestRequirement> createQuestRequirement(@RequestBody HashMap<String, String> param) {
        if (! param.containsKey("questId")) {
            return Mono.error(new Error("No quest id provided"));
        }
        QuestRequirement questRequirement = (QuestRequirement) ReqBodyUtils.convertValue(param, QuestRequirement.class);
        return this.questService.createQuestRequirement(questRequirement);
    }

    @RequestMapping(value = "/quest/requirement", method = RequestMethod.PUT)
    public Mono<QuestRequirement> updateQuestRequirement(@RequestBody HashMap<String, String> param) {
        if (! param.containsKey("questId") || ! param.containsKey("id")) {
            return Mono.error(new Error("No quest id provided"));
        }
        QuestRequirement questRequirement = (QuestRequirement) ReqBodyUtils.convertValue(param, QuestRequirement.class);
        return this.questService.updateQuestRequirement(questRequirement);
    }

    @RequestMapping(value = "/quest/requirement/{questId}", method = RequestMethod.GET)
    public Flux<QuestRequirement> getQuestRequirement(@PathVariable("questId") Integer questId) {
        return this.questService.getQuestRequirements(questId);
    }

    @RequestMapping(value = "/quest/requirement/{id}", method = RequestMethod.DELETE)
    public Mono<Void> deleteQuestRequirement(@PathVariable("id") Integer id) {
        return this.questService.deleteQuestRequirement(id);
    }

    @RequestMapping(value = "/quest/proposal/{questId}", method = RequestMethod.GET)
    public Mono<QuestWithProposal> getQuestWithItsProposal(@PathVariable("questId") Integer questId) {
        return this.questService.getQuestWithProposal(questId);
    }

    @RequestMapping(value = "/quest/user-proposal", method = RequestMethod.GET)
    public Flux<QuestProposal> getUserSubmittedProposal(JwtAuthenticationToken token) {
        logger.info("toke username: {}", token.getToken().getClaims().get("preferred_username"));
        String username = (String)token.getToken().getClaims().get("preferred_username");
        return this.questService.getQuestProposal(username);
    }

    @RequestMapping(value = "/quest/user-concern", method = RequestMethod.POST)
    public Mono<QuestUserConcern> createQuestUserConcern(@RequestBody HashMap<String, String> param) {
        logger.info("user concern: {}", param);
        QuestUserConcern questUserConcern = new QuestUserConcern();
        if (param.containsKey("context")) {
            questUserConcern.setContext(param.get("context"));
        }
        if (param.containsKey("concernValidation")) {
            questUserConcern.setConcernValidation(param.get("concernValidation"));
        }
        questUserConcern.setQuestId(Integer.parseInt(param.get("questId")));
        return this.questService.createQuestUserConcern(questUserConcern);
    }

    @RequestMapping(value = "/quest/proposal-evaluate/{questId}", method = RequestMethod.POST)
    public Mono<Void> createQuestUserConcern(@PathVariable("questId") Integer questId) {
        logger.info("quest to reevaluate {}", questId);
        return this.questService.evaluateQuestProposal(questId);
    }

    @RequestMapping(value = "/quest/user-concern/{id}", method = RequestMethod.DELETE)
    public Mono<Void> deleteQuestUserConcern(JwtAuthenticationToken token, @PathVariable("id") Integer id) {
        logger.info("toke username: {}", token.getToken().getClaims().get("preferred_username"));
        String username = (String)token.getToken().getClaims().get("preferred_username");
        return this.questService.getQuestById(id)
                .flatMap(quest -> {
                    if (quest.getRequestor().equals(username)) {
                        return this.questService.deleteQuestUserConcern(id);
                    } else {
                        return Mono.empty();
                    }
                });
    }

    @RequestMapping(value = "/quest/quest-taker", method = RequestMethod.POST)
    public Mono<QuestTakerRequest> createQuestTakerRequest(JwtAuthenticationToken token, @RequestBody Map<String, String> param) {
        String username = (String)token.getToken().getClaims().get("preferred_username");
        logger.info("{} wants to create taker request, {}", username, param);
        QuestTakerRequest questTakerRequest = new QuestTakerRequest();
        if (param.containsKey("questId")) {
            questTakerRequest.setQuestId(Integer.parseInt(param.get("questId")));
        } else {
            logger.info("no quest id provided");
            return Mono.empty();
        }
        questTakerRequest.setStatus("REQUESTED");
        questTakerRequest.setUsername(username);
        return this.questService.createQuestTakerRequest(questTakerRequest);
    }

    @RequestMapping(value = "/quest/quest-taker", method = RequestMethod.PUT)
    public Mono<QuestTakerRequest> updateQuestTakerRequest(@RequestBody Map<String, String> param) {
        String status = "";
        Integer id = -1;
        if (param.containsKey("status")) {
            status = param.get("status");
        } else {
            return Mono.empty();
        }

        if (param.containsKey("id")) {
            id = Integer.parseInt(param.get("questId"));
        } else {
            return Mono.empty();
        }
        return this.questService.updateQuestTakerRequest(id, status);
    }

    @RequestMapping(value = "/quest/quest-taker-quest/{questId}", method = RequestMethod.GET)
    public Flux<QuestTakerRequest> getQuestTakerRequestByQuestId(@PathVariable("questId") Integer questId) {
        return this.questService.getQuestTakerRequestByQuestId(questId);
    }

    @RequestMapping(value = "/quest/quest-taker-id/{id}", method = RequestMethod.GET)
    public Mono<QuestTakerRequest> getQuestTakerRequestById(@PathVariable("id") Integer id) {
        return this.questService.getQuestTakerRequestById(id);
    }

    @RequestMapping(value = "/quest/quest-taker/{id}", method = RequestMethod.DELETE)
    public Mono<Void> deleteQuestTakerRequest(@PathVariable("id") Integer id) {
        return this.questService.deleteQuestTakerRequest(id);
    }

//    @RequestMapping(value = "/produce", method = RequestMethod.GET)
    private void sendQuestAutoAssignSignal(JwtAuthenticationToken token, Quest quest) throws Exception {
        logger.info("####     token     #####");
        logger.info(token.getToken().toString());
        logger.info("########################");

        QuestWithToken questWithToken = new QuestWithToken(quest, token.getToken().getTokenValue());
        questSender.send(questWithToken);
    }

    @RequestMapping(value = "/user-proposed-quests", method = RequestMethod.GET)
    public Flux<Quest> getUserProposedQuest(JwtAuthenticationToken token) {
        String username = (String)token.getToken().getClaims().get("preferred_username");
        return this.questService.getUserProposedQuests(username);
    }
}
