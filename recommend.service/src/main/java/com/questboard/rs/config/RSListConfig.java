package com.questboard.rs.config;

import com.questboard.rs.model.Quest;
import org.springframework.boot.autoconfigure.data.redis.RedisProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;

import java.util.List;

@Configuration
@EnableConfigurationProperties(RedisProperties.class)
public class RSListConfig {
    @Bean
    public RedisTemplate<String, List<Quest>> redisListTemplate(RedisConnectionFactory connectionFactory) {
        RedisTemplate<String, List<Quest>> template = new RedisTemplate<>();
        template.setConnectionFactory(connectionFactory);
        return template;
    }

}