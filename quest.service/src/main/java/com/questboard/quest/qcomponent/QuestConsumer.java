package com.questboard.quest.qcomponent;

import com.questboard.quest.dto.QuestWithToken;
import com.questboard.quest.dto.UserDto;
import com.questboard.quest.entity.Quest;
import com.questboard.quest.service.QuestService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.jms.annotation.JmsListener;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageHeaders;
import org.springframework.messaging.handler.annotation.Headers;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import javax.jms.Session;
import java.util.Objects;
import java.util.Random;

import static com.questboard.quest.config.ActiveMQConfig.QUEST_AUTOASSIGN_QUEUE;

@Component
public class QuestConsumer {
    private final Logger log = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private Environment env;

    @Autowired
    private QuestService questService;

    @JmsListener(destination = QUEST_AUTOASSIGN_QUEUE)
    public void receiveMessage(@Payload QuestWithToken questWithToken,
                               @Headers MessageHeaders headers,
                               Message message, Session session) {
        log.info("received <" + questWithToken + ">");
        log.info("token <" + questWithToken.getToken() + ">");
        log.info("- - - - - - - - - - - - - - - - - - - - - - - -");
        log.info("######          Message Details           #####");
        log.info("- - - - - - - - - - - - - - - - - - - - - - - -");
        log.info("headers: " + headers);
        log.info("message: " + message);
        log.info("session: " + session);
        log.info("- - - - - - - - - - - - - - - - - - - - - - - -");
        try {
            String userCluster = Objects.requireNonNull(env.getProperty("USER_CLUSTER"));
            Quest quest = questWithToken.getQuest();
            String token = questWithToken.getToken();

            String apiPath = userCluster + "/api/u/v1/user-with-everyday-profile";
            log.info("sending request to {}", apiPath);

            String response = WebClient.create().get().uri(userCluster +  "/api/u/v1/health-check")
                    .retrieve()
                    .onStatus(HttpStatus::isError, resp -> Mono.error(new Error("health check error")))
                    .bodyToMono(String.class)
                    .block();

            if (response.equalsIgnoreCase("ok")) {
                UserDto[] userResults = WebClient.create(apiPath).get()
                        .header(HttpHeaders.AUTHORIZATION, "Bearer " + token.toString())
                        .retrieve()
                        .bodyToMono(UserDto[].class)
                        .block();
                log.info("user result: {}", userResults.length);

                if (userResults.length > 0) {
                    Random random = new Random();
                    int luckyOne = random.nextInt(userResults.length);
                    UserDto userDto = userResults[luckyOne];

                    log.info("awarded to: {}", userDto.getUserName());

                    questService.awardQuest(quest.getId(), userDto.getUserName()).subscribe();
                }
            }

        } catch (Exception e) {
            log.error("unable to auto assign quest, {}", e);
        }
    }

}
