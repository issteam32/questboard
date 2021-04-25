package com.questboard.quest.service;

import com.questboard.quest.dto.QuestWithToken;
import com.questboard.quest.entity.Quest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.stereotype.Service;

import static com.questboard.quest.config.ActiveMQConfig.QUEST_AUTOASSIGN_QUEUE;

@Service
public class ActiveMQSenderService {

    private final Logger log = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private JmsTemplate jmsTemplate;

    public void send(QuestWithToken questWithToken) {
        log.info("sending with convertAndSend() to queue <" + questWithToken + ">");
        jmsTemplate.convertAndSend(QUEST_AUTOASSIGN_QUEUE, questWithToken);
    }
}
