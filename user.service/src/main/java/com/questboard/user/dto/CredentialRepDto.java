package com.questboard.user.dto;

public class CredentialRepDto {
    private String id;
    private String credentialData;
    private Integer createdDate;
    private Integer updatedDate;
    private Integer priority;
    private String secretData;
    private Boolean temporary;
    private String type;
    private String userLabel;
    private String value;

    public CredentialRepDto(String id, String credentialData, Integer createdDate, Integer updatedDate, Integer priority,
                            String secretData, Boolean temporary, String type, String userLabel, String value) {
        this.id = id;
        this.credentialData = credentialData;
        this.createdDate = createdDate;
        this.updatedDate = updatedDate;
        this.priority = priority;
        this.secretData = secretData;
        this.temporary = temporary;
        this.type = type;
        this.userLabel = userLabel;
        this.value = value;
    }

    public CredentialRepDto() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCredentialData() {
        return credentialData;
    }

    public void setCredentialData(String credentialData) {
        this.credentialData = credentialData;
    }

    public Integer getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Integer createdDate) {
        this.createdDate = createdDate;
    }

    public Integer getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Integer updatedDate) {
        this.updatedDate = updatedDate;
    }

    public Integer getPriority() {
        return priority;
    }

    public void setPriority(Integer priority) {
        this.priority = priority;
    }

    public String getSecretData() {
        return secretData;
    }

    public void setSecretData(String secretData) {
        this.secretData = secretData;
    }

    public Boolean getTemporary() {
        return temporary;
    }

    public void setTemporary(Boolean temporary) {
        this.temporary = temporary;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getUserLabel() {
        return userLabel;
    }

    public void setUserLabel(String userLabel) {
        this.userLabel = userLabel;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
