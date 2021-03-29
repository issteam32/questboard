package com.questboard.quest.strategy;

import com.questboard.quest.dto.ConcernAnswerJson;
import com.questboard.quest.dto.ConcernValidationJson;

/**
 * Operator signal
 * <=> around
 * > greater or equal than
 * < less or equal than
 */

public interface QuestMatchingStrategy {
    public Integer evaluate(ConcernValidationJson cV, ConcernAnswerJson cA);
}
