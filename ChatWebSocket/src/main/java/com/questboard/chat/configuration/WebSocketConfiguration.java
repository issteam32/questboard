package com.questboard.chat.configuration;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.questboard.chat.handler.ChatWebSocketHandler;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.messaging.converter.DefaultContentTypeResolver;
import org.springframework.messaging.converter.MappingJackson2MessageConverter;
import org.springframework.messaging.converter.MessageConverter;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.util.MimeTypeUtils;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.*;
import org.springframework.web.socket.server.HandshakeInterceptor;

import java.util.List;
import java.util.Map;

@Configuration
@EnableWebSocket
@EnableWebSocketMessageBroker
public class WebSocketConfiguration implements WebSocketMessageBrokerConfigurer {

    private final static String CHAT_ENDPOINT = "/chat/*";

//    @Override
//    public void registerWebSocketHandlers(WebSocketHandlerRegistry webSocketHandlerRegistry) {
//        webSocketHandlerRegistry.addHandler(getChatWebSocketHandler(), CHAT_ENDPOINT)
//                .addInterceptors(chatRoomInterceptor())
//                .setAllowedOrigins("*");
//    }

//    @Bean
//    public WebSocketHandler getChatWebSocketHandler(){
//        return new ChatWebSocketHandler();
//    }

//    public HandshakeInterceptor chatRoomInterceptor(){
//        return new HandshakeInterceptor() {
//            @Override
//            public boolean beforeHandshake(ServerHttpRequest serverHttpRequest,
//                                           ServerHttpResponse serverHttpResponse,
//                                           WebSocketHandler webSocketHandler,
//                                           Map<String, Object> attributes) throws Exception {
//                // Get the URI segment corresponding to the auction id during handshake
//                String path = serverHttpRequest.getURI().getPath();
//                String chatRoomId = path.substring(path.lastIndexOf('/') + 1);
//
//                // This will be added to the web socket session
//                attributes.put("chatRoomId", chatRoomId);
//                return true;
//            }
//
//            @Override
//            public void afterHandshake(ServerHttpRequest serverHttpRequest, ServerHttpResponse serverHttpResponse, WebSocketHandler webSocketHandler, Exception e) {
//                // nothing implemented
//            }
//        };
//    }

    @Override
    public void configureMessageBroker(MessageBrokerRegistry config) {
        config.enableSimpleBroker( "/user");
        config.setApplicationDestinationPrefixes("/app");
        config.setUserDestinationPrefix("/user");
    }

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry
                .addEndpoint("/ws")
                .setAllowedOrigins("*")
                .withSockJS();
    }

    @Override
    public boolean configureMessageConverters(List<MessageConverter> messageConverters) {
        DefaultContentTypeResolver resolver = new DefaultContentTypeResolver();
        resolver.setDefaultMimeType(MimeTypeUtils.APPLICATION_JSON);
        MappingJackson2MessageConverter converter = new MappingJackson2MessageConverter();
        converter.setObjectMapper(new ObjectMapper());
        converter.setContentTypeResolver(resolver);
        messageConverters.add(converter);
        return false;
    }
}
