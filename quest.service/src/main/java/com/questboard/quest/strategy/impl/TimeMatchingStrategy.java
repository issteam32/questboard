package com.questboard.quest.strategy.impl;

import com.questboard.quest.dto.ConcernAnswerJson;
import com.questboard.quest.dto.ConcernValidationJson;
import com.questboard.quest.strategy.QuestMatchingStrategy;

import java.time.Duration;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;

public class TimeMatchingStrategy implements QuestMatchingStrategy {
    @Override
    public Integer evaluate(ConcernValidationJson cV, ConcernAnswerJson cA) {
        LocalDate cVDate = Instant.ofEpochMilli(cV.getEvaluation().longValue())
                .atZone(ZoneId.systemDefault()).toLocalDate();
        LocalDate cADate = Instant.ofEpochMilli(cA.getEvaluation().longValue())
                .atZone(ZoneId.systemDefault()).toLocalDate();
        if (cV.getOperator().equalsIgnoreCase("<=>")) {
            long days = Duration.between(cVDate, cADate).toDays();
            return days >= 2 ? 1: 0;
        } else if (cV.getOperator().equalsIgnoreCase(">")) {
            return cADate.isAfter(cVDate)? 1 : 0;
        } else if (cV.getOperator().equalsIgnoreCase("<")) {
            return cADate.isBefore(cVDate)? 1: 0;
        } else {
            return 0;
        }
    }
}
