package com.questboard.quest.util;

import com.fasterxml.jackson.databind.DeserializationConfig;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.questboard.quest.dto.ConcernAnswerJson;
import com.questboard.quest.dto.ConcernValidationJson;
import com.questboard.quest.dto.ProposalJson;
import com.questboard.quest.dto.SkillSetProfileDto;
import com.questboard.quest.strategy.QuestMatchingContext;
import com.questboard.quest.strategy.impl.MonetaryMatchingStrategy;
import com.questboard.quest.strategy.impl.TimeMatchingStrategy;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collector;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static com.fasterxml.jackson.databind.DeserializationFeature.ACCEPT_EMPTY_STRING_AS_NULL_OBJECT;

public class ServiceUtils {
    private static final Logger logger = LoggerFactory.getLogger("ServiceUtils");
    public static Double proposalScoreCounting(String json, List<ConcernValidationJson> concernValidationJsonList,
                                               String skillRequired, List<SkillSetProfileDto> skillSetProfileDto) {
        try {
            final ObjectMapper om = new ObjectMapper();
            om.enable(ACCEPT_EMPTY_STRING_AS_NULL_OBJECT);
            om.configure(ACCEPT_EMPTY_STRING_AS_NULL_OBJECT, true);
            ProposalJson proposalJson = om.readValue(json, ProposalJson.class);

            logger.debug("validation list: {}", concernValidationJsonList);
            logger.debug("proposal json: {}", proposalJson);

            Double concernEvaluationScore = concernEvaluation(concernValidationJsonList, proposalJson.getConcernAnswered());

            List<String> skillsRequiredList = Arrays.asList(skillRequired.split(",").clone());
            Double skillsetEvaluationScore = skillsetEvaluation(skillsRequiredList, skillSetProfileDto);

            logger.info("proposal concern evaluation: {}", concernEvaluationScore);
            logger.info("skillset evaluation: {}", skillsetEvaluationScore);

            return ((concernEvaluationScore / 100.0) * 60) + ((skillsetEvaluationScore / 100.0) * 40);
        } catch (Exception exception) {
            logger.error(exception.getMessage());
            logger.error(exception.getStackTrace().toString());
            return 30.0;
        }
    }

    /**
     * <=> around
     * > greater or equal than
     * < less or equal than
     */
    private static Double concernEvaluation(List<ConcernValidationJson> concernValidationJsons,
                                            List<ConcernAnswerJson> concernAnswerJsons) {
        Double match = 0.0;
        for (ConcernValidationJson validation: concernValidationJsons) {
            for (ConcernAnswerJson answer: concernAnswerJsons) {
                if (validation.getConcern().equalsIgnoreCase(answer.getConcern())) {
                    if ("time".equalsIgnoreCase(validation.getConcern())) {
                        QuestMatchingContext context = new QuestMatchingContext(new TimeMatchingStrategy(), validation, answer);
                        match += context.executeStrategy();
                    } else if ("money".equalsIgnoreCase(validation.getConcern())) {
                        QuestMatchingContext context = new QuestMatchingContext(new MonetaryMatchingStrategy(), validation, answer);
                        match += context.executeStrategy();
                    } else {
                        match += 0;
                    }
                }
            }
        }
        Double totalConcernSize = concernAnswerJsons.size() * 1.0;
        if (match == 0.0) {
            return 0.0;
        }
        return (match / totalConcernSize) * 100.0;
    }

    private static Double skillsetEvaluation(List<String> skills, List<SkillSetProfileDto> skillSetProfileList) {
        Double match = 0.0;
        Double totalSkillRequired = skills.size() * 1.0;
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
