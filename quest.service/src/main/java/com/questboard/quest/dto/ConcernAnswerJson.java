package com.questboard.quest.dto;

public class ConcernAnswerJson {
    private String concern;
    private String operator;
    private Double evaluation;

    public ConcernAnswerJson(String concern, String operator, Double evaluation) {
        this.concern = concern;
        this.operator = operator;
        this.evaluation = evaluation;
    }

    public ConcernAnswerJson() {
    }

    public String getConcern() {
        return concern;
    }

    public void setConcern(String concern) {
        this.concern = concern;
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }

    public Double getEvaluation() {
        return evaluation;
    }

    public void setEvaluation(Double evaluation) {
        this.evaluation = evaluation;
    }
}
