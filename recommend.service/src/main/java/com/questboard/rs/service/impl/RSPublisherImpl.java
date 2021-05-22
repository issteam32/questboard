package com.questboard.rs.service.impl;

import com.questboard.rs.model.Quest;
import com.questboard.rs.service.RSPublisher;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.listener.ChannelTopic;
import org.springframework.scheduling.annotation.Scheduled;

import java.util.List;
import java.util.concurrent.atomic.AtomicLong;

public class RSPublisherImpl implements RSPublisher {

    private final RedisTemplate< String, List<Quest> > template;
    private final ChannelTopic topic;
    private final AtomicLong counter = new AtomicLong( 0 );

    public RSPublisherImpl( final RedisTemplate< String, List<Quest>> template,
                               final ChannelTopic topic ) {
        this.template = template;
        this.topic = topic;
    }

    @Scheduled( fixedDelay = 100 )
    @Override
    public void publish() {
        template.convertAndSend( topic.getTopic(), "Message " + counter.incrementAndGet() +
                ", " + Thread.currentThread().getName() );
    }
}
