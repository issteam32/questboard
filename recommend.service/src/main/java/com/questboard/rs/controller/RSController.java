package com.questboard.rs.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.questboard.rs.model.Quest;
import com.questboard.rs.service.RSService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/v1/rs")
public class RSController {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private RSService rsService;

    @GetMapping(value = "/health-check")
    public ResponseEntity<String> healthCheck() {
        return ResponseEntity.ok("Ok");
    }

    @RequestMapping(value = "/recommended-quests", method = RequestMethod.GET)
    public ResponseEntity<?> getRecommendedQuests(@RequestParam("skill") String skill) {
        return ResponseEntity.ok(rsService.getRecommendedQuests(skill));
    }

    @RequestMapping(value = "/push-quest", method = RequestMethod.POST)
    public ResponseEntity<?> pushQuest(@RequestBody Map param) {
        final ObjectMapper mapper = new ObjectMapper();
        Quest quest = mapper.convertValue(param, Quest.class);
//        return ResponseEntity.ok(rsService.pushNewQuest(quest));
        return ResponseEntity.ok(rsService.appendToQuestList(quest));
    }

    @RequestMapping(value = "/get-quest/{key}", method = RequestMethod.GET)
    public ResponseEntity<?> getQuestInQueue(@PathVariable("key") String key) {
//        return ResponseEntity.ok(rsService.getQuestById(key));
        return ResponseEntity.ok(rsService.getQuestListByKey(key));
    }

}
