package com.questboard.quest;

import com.questboard.quest.service.ActiveMQSenderService;
import org.apache.activemq.broker.BrokerService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.util.concurrent.TimeUnit;

@SpringBootApplication
public class QuestApplication {

	public static void main(String[] args) {
		SpringApplication.run(QuestApplication.class, args);
	}

}
