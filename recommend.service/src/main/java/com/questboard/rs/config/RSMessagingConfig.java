package com.questboard.rs.config;

import com.questboard.rs.model.Quest;
import com.questboard.rs.service.RSPublisher;
import com.questboard.rs.service.impl.RSMessageListener;
import com.questboard.rs.service.impl.RSPublisherImpl;
import org.springframework.boot.autoconfigure.data.redis.RedisProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.connection.jedis.JedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.listener.ChannelTopic;
import org.springframework.data.redis.listener.RedisMessageListenerContainer;
import org.springframework.data.redis.listener.adapter.MessageListenerAdapter;
import org.springframework.data.redis.serializer.GenericToStringSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import org.springframework.scheduling.annotation.EnableScheduling;

import java.util.List;

//@Configuration
//@EnableScheduling
public class RSMessagingConfig {

//    @Bean
    JedisConnectionFactory jedisConnectionFactory() {
        return new JedisConnectionFactory();
    }

//    @Bean
    RedisTemplate< String, List<Quest>> redisTemplate() {
        final RedisTemplate< String, List<Quest> > template =  new RedisTemplate< String, List<Quest> >();
        template.setConnectionFactory(jedisConnectionFactory());
        template.setKeySerializer( new StringRedisSerializer() );
        template.setHashValueSerializer( new GenericToStringSerializer< Object >( Object.class ) );
        template.setValueSerializer( new GenericToStringSerializer< Object >( Object.class ) );
        return template;
    }

//    @Bean
    MessageListenerAdapter messageListener() {
        return new MessageListenerAdapter( new RSMessageListener() );
    }

//    @Bean
    RedisMessageListenerContainer redisContainer() {
        final RedisMessageListenerContainer container = new RedisMessageListenerContainer();

        container.setConnectionFactory( jedisConnectionFactory() );
        container.addMessageListener( messageListener(), topic() );

        return container;
    }

//    @Bean
    RSPublisher redisPublisher() {
        return new RSPublisherImpl( redisTemplate(), topic() );
    }

//    @Bean
    ChannelTopic topic() {
        return new ChannelTopic( "pubsub:queue" );
    }
}
