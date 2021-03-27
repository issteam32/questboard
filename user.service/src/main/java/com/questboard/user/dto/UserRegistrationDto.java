package com.questboard.user.dto;

public class UserRegistrationDto {

    private String userName;

    private String ssoUid;

    private String email;

    private int registerType;

    private Boolean active;

    private String password;

    private String passwordConfirm;

    public UserRegistrationDto() {
    }

    public UserRegistrationDto(String userName, String ssoUid, String email, int registerType) {
        this.userName = userName;
        this.ssoUid = ssoUid;
        this.email = email;
        this.registerType = registerType;
        this.active = true;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getSsoUid() {
        return ssoUid;
    }

    public void setSsoUid(String ssoUid) {
        this.ssoUid = ssoUid;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getRegisterType() {
        return registerType;
    }

    public void setRegisterType(int registerType) {
        this.registerType = registerType;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPasswordConfirm() {
        return passwordConfirm;
    }

    public void setPasswordConfirm(String passwordConfirm) {
        this.passwordConfirm = passwordConfirm;
    }
}