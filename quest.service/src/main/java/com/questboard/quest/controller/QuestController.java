package com.questboard.quest.controller;

import com.questboard.quest.dto.QuestWithProposal;
import com.questboard.quest.dto.SkillSetProfileDto;
import com.questboard.quest.entity.Quest;
import com.questboard.quest.entity.QuestFlow;
import com.questboard.quest.entity.QuestProposal;
import com.questboard.quest.entity.QuestRequirement;
import com.questboard.quest.enums.QuestCategory;
import com.questboard.quest.repository.QuestRequirementRepository;
import com.questboard.quest.service.QuestService;
import com.questboard.quest.util.ReqBodyUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.OAuth2AuthenticatedPrincipal;
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
    public Mono<Quest> createQuest(@RequestBody HashMap<String, Object> param) {
        Quest quest = (Quest)ReqBodyUtils.convertValue(param, Quest.class);
        return this.questService.createNewQuest(quest)
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
            Integer userId;
            if (param.containsKey("awardTo")) {
                userId = Integer.parseInt(param.get("awardTo"));
            } else {
                return Mono.just(false);
            }
            return this.questService.awardQuest(id, userId);
        }
    }

    @RequestMapping(value = "/quest/proposal", method = RequestMethod.POST)
    public Mono<QuestProposal> createProfessionalQuestProposal(@RequestBody HashMap<String, Object> param) {
        if (! param.containsKey("proposal") || !param.containsKey("skillsetProfile")) {
            return Mono.error(new Error("no skillset profile or proposal found!"));
        }
        HashMap<String, Object> proposalMap = (HashMap<String, Object>) param.get("proposal");
        List<HashMap<String, Object>> skillsetProfileList = new ArrayList(Collections.singletonList(param.get("skillSetProfileList")));
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
}
