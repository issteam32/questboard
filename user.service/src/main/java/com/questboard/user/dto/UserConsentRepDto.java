package com.questboard.user.dto;

public class UserConsentRepDto {
    private String clientId;
    private Integer createdDate;
    private String[] grantClientScopes;
    private Integer lastUpdatedDate;

    public UserConsentRepDto(String clientId, Integer createdDate, String[] grantClientScopes, Integer lastUpdatedDate) {
        this.clientId = clientId;
        this.createdDate = createdDate;
        this.grantClientScopes = grantClientScopes;
        this.lastUpdatedDate = lastUpdatedDate;
    }

    public UserConsentRepDto() {
    }

    public String getClientId() {
        return clientId;
    }

    public void setClientId(String clientId) {
        this.clientId = clientId;
    }

    public Integer getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Integer createdDate) {
        this.createdDate = createdDate;
    }

    public String[] getGrantClientScopes() {
        return grantClientScopes;
    }

    public void setGrantClientScopes(String[] grantClientScopes) {
        this.grantClientScopes = grantClientScopes;
    }

    public Integer getLastUpdatedDate() {
        return lastUpdatedDate;
    }

    public void setLastUpdatedDate(Integer lastUpdatedDate) {
        this.lastUpdatedDate = lastUpdatedDate;
    }
}
