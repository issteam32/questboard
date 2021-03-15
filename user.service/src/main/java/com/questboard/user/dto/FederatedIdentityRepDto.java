package com.questboard.user.dto;

public class FederatedIdentityRepDto {
    private String identityProvider;
    private String userId;
    private String userName;

    public FederatedIdentityRepDto(String identityProvider, String userId, String userName) {
        this.identityProvider = identityProvider;
        this.userId = userId;
        this.userName = userName;
    }

    public FederatedIdentityRepDto() {
    }

    public String getIdentityProvider() {
        return identityProvider;
    }

    public void setIdentityProvider(String identityProvider) {
        this.identityProvider = identityProvider;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}
