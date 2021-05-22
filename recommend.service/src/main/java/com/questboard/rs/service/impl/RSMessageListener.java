package com.questboard.rs.service.impl;

import org.springframework.data.redis.connection.Message;
import org.springframework.data.redis.connection.MessageListener;

public class RSMessageListener implements MessageListener {
    @Override
    public void onMessage(Message message, byte[] bytes) {
        System.out.println( "Message received: " + message.toString() );
    }
}
