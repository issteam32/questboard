package com.questboard.rs.config;

import com.questboard.rs.model.Quest;
import org.springframework.boot.autoconfigure.data.redis.RedisProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;

//@Configuration
//@EnableConfigurationProperties(RedisProperties.class)
public class RSConfig {
//    @Bean
    public RedisTemplate<String, Quest> redisQuestTemplate(RedisConnectionFactory connectionFactory) {
        RedisTemplate<String, Quest> template = new RedisTemplate<>();
        template.setConnectionFactory(connectionFactory);
        return template;
    }

}