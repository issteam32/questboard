package com.questboard.user.service;

import com.questboard.user.entity.SocialAccount;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

public interface SocialAccountService {
    public Flux<SocialAccount> getSocialAccountByUserId(Integer userId);
    public Mono<SocialAccount> linkupSocialAccount(SocialAccount socialAccount);
    public Mono<SocialAccount> updateSocialAccount(SocialAccount socialAccount);
    public Mono<Void> deleteSocialAccountById(Integer id);
}
