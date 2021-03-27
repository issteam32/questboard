package com.questboard.user.enums;

public enum SocialPlatform {
    FACEBOOK(0),
    GOOGLE(1);

    public final Integer value;

    SocialPlatform(Integer value) {
        this.value = value;
    }
}
