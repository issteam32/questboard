package com.questboard.quest.util;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.questboard.quest.dto.ConcernAnswerJson;
import com.questboard.quest.dto.ConcernValidationJson;
import com.questboard.quest.dto.ProposalJson;
import com.questboard.quest.dto.SkillSetProfileDto;
import com.questboard.quest.strategy.QuestMatchingContext;
import com.questboard.quest.strategy.impl.MonetaryMatchingStrategy;
import com.questboard.quest.strategy.impl.TimeMatchingStrategy;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collector;
import java.util.stream.Collectors;

public class ServiceUtils {
    public static Double proposalScoreCounting(String json, List<ConcernValidationJson> concernValidationJsonList,
                                               String skillRequired, List<SkillSetProfileDto> skillSetProfileDto) {
        final ObjectMapper om = new ObjectMapper();
        ProposalJson proposalJson = om.convertValue(json, ProposalJson.class);
        Double concernEvaluationScore = concernEvaluation(concernValidationJsonList, proposalJson.getConcernAnswered());

        List<String> skillsRequiredList = Arrays.asList(skillRequired.split(",").clone());
        Double skillsetEvaluationScore = skillsetEvaluation(skillsRequiredList, skillSetProfileDto);

        return ((concernEvaluationScore / 100.0) * 60) + ((skillsetEvaluationScore / 100.0) * 40);
    }

    /**
     * <=> around
     * > greater or equal than
     * < less or equal than
     */
    private static Double concernEvaluation(List<ConcernValidationJson> concernValidationJsons,
                                            List<ConcernAnswerJson> concernAnswerJsons) {
        int match = 0;
        int totalConcernSize = concernAnswerJsons.size();
        match = concernValidationJsons.stream()
                .map(validation ->
                        concernAnswerJsons.stream()
                                .filter(answer -> validation.getConcern().equals(answer.getConcern()))
                                .map(answer -> {
                                    if (validation.getConcern().equals("time")) {
                                        QuestMatchingContext context = new QuestMatchingContext(new TimeMatchingStrategy(), validation, answer);
                                        return context.executeStrategy();
                                    } else if (validation.getConcern().equals("money")) {
                                        QuestMatchingContext context = new QuestMatchingContext(new MonetaryMatchingStrategy(), validation, answer);
                                        return context.executeStrategy();
                                    }
                                    return 0;
                                })
                ).mapToInt(m -> m.findFirst().isPresent() ? m.findFirst().get() : 0).sum();
        if (match == 0) {
            return 0.0;
        }
        return (match / totalConcernSize) * 100.0;
    }

    private static Double skillsetEvaluation(List<String> skills, List<SkillSetProfileDto> skillSetProfileList) {
        int match = 0;
        int totalSkillRequired = skills.size();
        for (String skill: skills) {
            for (SkillSetProfileDto skillSetProfile: skillSetProfileList) {
                if (skillSetProfile.getSkill().equals(skill)) {
                    match += 1;
                }
            }
        }
        if (match == 0) {
            return 0.0;
        }
        return (match / totalSkillRequired) * 100.0;
    }

}
