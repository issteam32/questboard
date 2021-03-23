package com.questboard.user.controller;

import com.questboard.user.entity.ProfessionalLevel;
import com.questboard.user.service.ProfessionalLevelService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

import java.util.Map;


@RestController
@RequestMapping("/api/plv/v1")
public class ProfessionalLevelController {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private ProfessionalLevelService profLvlService;

    @RequestMapping(value = "/proflvl/{id}", method = RequestMethod.GET)
    public Mono<ProfessionalLevel> getProfessionalLevelById(@PathVariable("id") Integer id) {
        return this.profLvlService.getProfessionalLevelById(id);
    }

    @RequestMapping(value = "/proflvl/{id}", method = RequestMethod.PUT)
    public Mono<ProfessionalLevel> updateProfessionalLevel(@RequestBody Map<String, String> param, @PathVariable("id") Integer id) {
        ProfessionalLevel profLvl = new ProfessionalLevel();
        profLvl.setId(id);
        if (param.containsKey("title")) {
            profLvl.setTitle(param.get("title"));
        }
        if (param.containsKey("exp")) {
            profLvl.setExp(Integer.parseInt(param.get("exp")));
        }
        return this.profLvlService.updateProfessionalLevel(profLvl)
                .map(professionalLevel -> professionalLevel)
                .onErrorResume(error -> {
                    logger.error("Error when updating professional level (id: {}), error: {}", id, error.getMessage());
                    return Mono.error(new Error(error.getMessage()));
                });
    }

}
