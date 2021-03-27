package com.questboard.user.service;

import com.questboard.user.entity.SocialAccount;
import com.questboard.user.repository.SocialAccountRepository;
import com.questboard.user.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@Service
public class SocialAccountServiceImpl implements SocialAccountService{

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private SocialAccountRepository socialAccountRepo;

    @Autowired
    private UserRepository userRepo;

    @Override
    public Flux<SocialAccount> getSocialAccountByUserId(Integer userId) {
        return this.socialAccountRepo.findByUserId(userId);
    }

    @Override
    public Mono<SocialAccount> linkupSocialAccount(SocialAccount socialAccount) {
        return this.userRepo.findById(socialAccount.getUserId())
                .flatMap(user -> this.socialAccountRepo.save(socialAccount))
                .switchIfEmpty(Mono.defer(() -> Mono.error(new Error("User not found!"))))
                .flatMap(Mono::just);
    }

    @Override
    public Mono<SocialAccount> updateSocialAccount(SocialAccount socialAccount) {
        return this.socialAccountRepo.findById(socialAccount.getId())
                .flatMap(socialAcct -> {
                    if (socialAccount.getSocialAcctLink() != null) {
                        socialAcct.setSocialAcctLink(socialAccount.getSocialAcctLink());
                    }
                    return this.socialAccountRepo.save(socialAccount);
                })
                .switchIfEmpty(Mono.defer(() -> Mono.error(new Error("Social Account Link is not found!"))))
                .flatMap(Mono::just);
    }

    @Override
    public Mono<Void> deleteSocialAccountById(Integer id) {
        return this.socialAccountRepo.deleteById(id);
    }
}
