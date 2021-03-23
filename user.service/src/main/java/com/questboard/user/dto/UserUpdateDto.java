package com.questboard.user.dto;

public class UserUpdateDto {
    private Integer id;

    private String email;

    private int registerType;

    private String ssoUid;

    private Boolean active;

    private String password;

    private String passwordConfirm;

    private Boolean updateActiveStatus;

    public UserUpdateDto() {
    }

    public UserUpdateDto(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public String getSsoUid() {
        return ssoUid;
    }

    public void setSsoUid(String ssoUid) {
        this.ssoUid = ssoUid;
    }

    public Boolean getUpdateActiveStatus() {
        return updateActiveStatus;
    }

    public void setUpdateActiveStatus(Boolean updateActiveStatus) {
        this.updateActiveStatus = updateActiveStatus;
    }

    @Override
    public String toString() {
        return "UserUpdateDto{" +
                "id=" + id +
                ", email='" + email + '\'' +
                ", registerType=" + registerType +
                ", ssoUid='" + ssoUid + '\'' +
                ", active=" + active +
                ", password='" + password + '\'' +
                ", passwordConfirm='" + passwordConfirm + '\'' +
                ", updateActiveStatus=" + updateActiveStatus +
                '}';
    }

    public String[] requiredFields() {
        return new String[] {"id","ssoUid"};
    }
}
