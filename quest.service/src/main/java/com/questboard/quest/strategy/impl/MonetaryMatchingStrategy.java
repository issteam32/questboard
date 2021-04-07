package com.questboard.quest.strategy.impl;

import com.questboard.quest.dto.ConcernAnswerJson;
import com.questboard.quest.dto.ConcernValidationJson;
import com.questboard.quest.strategy.QuestMatchingStrategy;

public class MonetaryMatchingStrategy implements QuestMatchingStrategy {
    @Override
    public Integer evaluate(ConcernValidationJson cV, ConcernAnswerJson cA) {
        if (cV.getOperator().equalsIgnoreCase("<=>")) {
            Double balance = ((cV.getEvaluation() + cA.getEvaluation())/ 2);
            if (balance.equals(cV.getEvaluation()) || cV.getEvaluation() > balance) {
                return 1;
            } else {
                double diff = (balance - cV.getEvaluation()) / cV.getEvaluation();
                if (diff <= 10) {
                    return 1;
                } else if (diff >= 10) {
                    return 0;
                } else {
                    return 0;
                }
            }
        } else if (cV.getOperator().equalsIgnoreCase(">")) {
            Double balance = ((cV.getEvaluation() + cA.getEvaluation())/ 2);
            if (balance.equals(cV.getEvaluation()) || balance > cV.getEvaluation()) {
                return 1;
            } else {
                return 0;
            }
        } else if (cV.getOperator().equalsIgnoreCase("<")) {
            Double balance = ((cV.getEvaluation() + cA.getEvaluation())/ 2);
            if (balance.equals(cV.getEvaluation()) || cV.getEvaluation() > balance) {
                return 1;
            } else {
                return 0;
            }
        } else {
            return 0;
        }
    }
}
