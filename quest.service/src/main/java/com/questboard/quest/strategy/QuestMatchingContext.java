package com.questboard.quest.strategy;

import com.questboard.quest.dto.ConcernAnswerJson;
import com.questboard.quest.dto.ConcernValidationJson;

public class QuestMatchingContext {

    private QuestMatchingStrategy strategy;
    private ConcernValidationJson concernValidationJson;
    private ConcernAnswerJson concernAnswerJson;

    public QuestMatchingContext(QuestMatchingStrategy strategy, ConcernValidationJson concernValidationJson,
                                ConcernAnswerJson concernAnswerJson) {
        this.strategy = strategy;
        this.concernValidationJson = concernValidationJson;
        this.concernAnswerJson = concernAnswerJson;
    }

    public Integer executeStrategy() {
        return this.strategy.evaluate(this.concernValidationJson, this.concernAnswerJson);
    }
}
