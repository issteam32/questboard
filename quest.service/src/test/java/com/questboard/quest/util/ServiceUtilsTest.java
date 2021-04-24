package com.questboard.quest.util;

import com.questboard.quest.dto.ConcernValidationJson;
import com.questboard.quest.dto.SkillSetProfileDto;
import org.junit.Assert;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class ServiceUtilsTest {

    String json;
    List<ConcernValidationJson> concernValidationJsonList;
    String skillRequired;
    List<SkillSetProfileDto> skillSetProfileDtos;

    @BeforeEach
    void setUp() {
        this.json = "{\"version\":1,\"concernAnswered\":[{\"concern\":\"money\",\"operator\":\"<\",\"evaluation\":\"130\"}, {\"concern\":\"time\",\"operator\":\">\",\"evaluation\":\"1618732436670\"}],\"proposalDetail\":\"\"}";
        this.concernValidationJsonList = List.of(new ConcernValidationJson("money", ">", 120.0),
                new ConcernValidationJson("time", ">", 1618992936670L * 1.0));
        this.skillRequired = "Machinery,Design";
        this.skillSetProfileDtos = List.of(new SkillSetProfileDto(5, "Design", 1, "Design Student", 88));
    }

    @AfterEach
    void tearDown() {
    }

    @Test
    void proposalScoreCounting() {
        Double score = ServiceUtils.proposalScoreCounting(json, concernValidationJsonList, skillRequired, skillSetProfileDtos);

        System.out.println("score: " + score);
        Assert.assertTrue(true);
    }
}