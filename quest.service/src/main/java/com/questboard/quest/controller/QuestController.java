package com.questboard.quest.controller;

import com.questboard.quest.dto.SkillSetProfileDto;
import com.questboard.quest.entity.Quest;
import com.questboard.quest.entity.QuestProposal;
import com.questboard.quest.enums.QuestCategory;
import com.questboard.quest.service.QuestService;
import com.questboard.quest.util.ReqBodyUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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

    @RequestMapping(value = "/quest/{id}", method = RequestMethod.GET)
    public Mono<Quest> getQuestById(@PathVariable("id") Integer id) {
        return this.questService.getQuestById(id)
                .onErrorResume(error -> {
                    logger.error("Get quest error, (id {}), error: {}", id, error.getMessage());
                    return Mono.empty();
                });
    }

    @RequestMapping(value = "/user-quest/{userId}", method = RequestMethod.GET)
    public Mono<List<Quest>> getQuestByUserId(@PathVariable("userId") Integer userId) {
        return this.questService.getQuestByUserId(userId)
                .onErrorResume(error -> {
                    logger.error("Get users's quest error, (id {}), error: {}", userId, error.getMessage());
                    return Mono.empty();
                });
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
}
