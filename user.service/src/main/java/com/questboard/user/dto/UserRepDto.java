package com.questboard.user.dto;

import java.util.Map;

public class UserRepDto {
    private Map access;
    private Map attributes;
    private UserConsentRepDto clientConsents;
    private Map clientRoles;
    private Integer createdTimestamp;
    private CredentialRepDto credentials;
    private String[] disableableCredentialTypes;
    private String email;
    private Boolean emailVerified;
    private Boolean enabled;
    private FederatedIdentityRepDto federatedIdentities;
    private String federationLink;
    private String firstName;
    private String[] groups;
    private String id;
    private String lastName;
    private Integer notBefore;
    private String origin;
    private String[] realmRoles;
    private String[] requiredActions;
    private String self;
    private String serviceAccountClientId;
    private String username;

    public UserRepDto(Map access, Map attributes, UserConsentRepDto clientConsents, Map clientRoles,
                      Integer createdTimestamp, CredentialRepDto credentials, String[] disableableCredentialTypes,
                      String email, Boolean emailVerified, Boolean enabled, FederatedIdentityRepDto federatedIdentities,
                      String federationLink, String firstName, String[] groups, String id, String lastName,
                      Integer notBefore, String origin, String[] realmRoles, String[] requiredActions, String self,
                      String serviceAccountClientId, String username) {
        this.access = access;
        this.attributes = attributes;
        this.clientConsents = clientConsents;
        this.clientRoles = clientRoles;
        this.createdTimestamp = createdTimestamp;
        this.credentials = credentials;
        this.disableableCredentialTypes = disableableCredentialTypes;
        this.email = email;
        this.emailVerified = emailVerified;
        this.enabled = enabled;
        this.federatedIdentities = federatedIdentities;
        this.federationLink = federationLink;
        this.firstName = firstName;
        this.groups = groups;
        this.id = id;
        this.lastName = lastName;
        this.notBefore = notBefore;
        this.origin = origin;
        this.realmRoles = realmRoles;
        this.requiredActions = requiredActions;
        this.self = self;
        this.serviceAccountClientId = serviceAccountClientId;
        this.username = username;
    }

    public UserRepDto() {
    }

    public Map getAccess() {
        return access;
    }

    public void setAccess(Map access) {
        this.access = access;
    }

    public Map getAttributes() {
        return attributes;
    }

    public void setAttributes(Map attributes) {
        this.attributes = attributes;
    }

    public UserConsentRepDto getClientConsents() {
        return clientConsents;
    }

    public void setClientConsents(UserConsentRepDto clientConsents) {
        this.clientConsents = clientConsents;
    }

    public Map getClientRoles() {
        return clientRoles;
    }

    public void setClientRoles(Map clientRoles) {
        this.clientRoles = clientRoles;
    }

    public Integer getCreatedTimestamp() {
        return createdTimestamp;
    }

    public void setCreatedTimestamp(Integer createdTimestamp) {
        this.createdTimestamp = createdTimestamp;
    }

    public CredentialRepDto getCredentials() {
        return credentials;
    }

    public void setCredentials(CredentialRepDto credentials) {
        this.credentials = credentials;
    }

    public String[] getDisableableCredentialTypes() {
        return disableableCredentialTypes;
    }

    public void setDisableableCredentialTypes(String[] disableableCredentialTypes) {
        this.disableableCredentialTypes = disableableCredentialTypes;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Boolean getEmailVerified() {
        return emailVerified;
    }

    public void setEmailVerified(Boolean emailVerified) {
        this.emailVerified = emailVerified;
    }

    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }

    public FederatedIdentityRepDto getFederatedIdentities() {
        return federatedIdentities;
    }

    public void setFederatedIdentities(FederatedIdentityRepDto federatedIdentities) {
        this.federatedIdentities = federatedIdentities;
    }

    public String getFederationLink() {
        return federationLink;
    }

    public void setFederationLink(String federationLink) {
        this.federationLink = federationLink;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String[] getGroups() {
        return groups;
    }

    public void setGroups(String[] groups) {
        this.groups = groups;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public Integer getNotBefore() {
        return notBefore;
    }

    public void setNotBefore(Integer notBefore) {
        this.notBefore = notBefore;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String[] getRealmRoles() {
        return realmRoles;
    }

    public void setRealmRoles(String[] realmRoles) {
        this.realmRoles = realmRoles;
    }

    public String[] getRequiredActions() {
        return requiredActions;
    }

    public void setRequiredActions(String[] requiredActions) {
        this.requiredActions = requiredActions;
    }

    public String getSelf() {
        return self;
    }

    public void setSelf(String self) {
        this.self = self;
    }

    public String getServiceAccountClientId() {
        return serviceAccountClientId;
    }

    public void setServiceAccountClientId(String serviceAccountClientId) {
        this.serviceAccountClientId = serviceAccountClientId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}
