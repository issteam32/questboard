package com.questboard.quest.dto;

import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.List;

public class ProposalJson {
    private Integer version;
    private List<ConcernAnswerJson> concernAnswered;
    private String proposalDetail;

    public ProposalJson(Integer version, List<ConcernAnswerJson> concernAnswered, String proposalDetail) {
        this.version = version;
        this.concernAnswered = concernAnswered;
        this.proposalDetail = proposalDetail;
    }

    public ProposalJson() {
    }

    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }

    public List<ConcernAnswerJson> getConcernAnswered() {
        return concernAnswered;
    }

    public void setConcernAnswered(List<ConcernAnswerJson> concernAnswered) {
        this.concernAnswered = concernAnswered;
    }

    public String getProposalDetail() {
        return proposalDetail;
    }

    public void setProposalDetail(String proposalDetail) {
        this.proposalDetail = proposalDetail;
    }
}
