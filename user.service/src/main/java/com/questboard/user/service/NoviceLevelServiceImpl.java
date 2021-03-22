package com.questboard.user.service;

import com.questboard.user.entity.NoviceLevel;
import com.questboard.user.repository.NoviceLevelRepository;
import com.questboard.user.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@Service
public class NoviceLevelServiceImpl implements NoviceLevelService{

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private NoviceLevelRepository noviceLevelRepo;

    @Autowired
    private UserRepository userRepo;

    @Override
    public Mono<NoviceLevel> createNoviceLevel(NoviceLevel noviceLevel) {
        return this.userRepo.findById(noviceLevel.getUserId())
                .flatMap(user -> {
                    if (user != null) {
                        logger.info("user in create: {}", user.getId());
                        return this.noviceLevelRepo.findByUserId(user.getId());
                    } else {
                        return Mono.error(new Error("User not found"));
                    }
                })
                .switchIfEmpty(Mono.defer(() ->{
                    logger.info("not sure entering here...");
                    noviceLevel.setLevel(1);
                    noviceLevel.setExp(1);
                    noviceLevel.setTitle("Novice");
                    return this.noviceLevelRepo.save(noviceLevel);
                }))
                .flatMap(Mono::just);
    }

    @Override
    public Mono<NoviceLevel> updateNoviceLevel(NoviceLevel noviceLevel) {
        return this.noviceLevelRepo.findById(noviceLevel.getId())
                .flatMap(noviceLvl -> {
                    if (noviceLvl != null) {
                        if (noviceLevel.getTitle() != null) {
                            noviceLvl.setTitle(noviceLevel.getTitle());
                        }
                        if (noviceLevel.getExp() != null) {
                            noviceLvl.setExp(noviceLevel.getExp() + noviceLvl.getExp());
                            if (noviceLvl.getExp() >= 100) {
                                noviceLvl.levelUp();
                                noviceLvl.setExp(noviceLvl.getExp() - 100);
                            }
                        }
                        return this.noviceLevelRepo.save(noviceLvl);
                    } else {
                        return Mono.error(new Error("Novice level not found"));
                    }
                });
    }

    @Override
    public Mono<NoviceLevel> getNoviceLevelById(Integer id) {
        return this.noviceLevelRepo.findById(id);
    }

    @Override
    public Flux<NoviceLevel> getNoviceLevelByTitle(String title) {
        return this.noviceLevelRepo.findByTitleLikeIgnoreCase(title);
    }

    @Override
    public Mono<NoviceLevel> getUserNoviceLevel(Integer userId) {
        return this.noviceLevelRepo.findByUserId(userId);
    }
}
