package com.questboard.chat.handler;

import com.questboard.chat.model.ChatRoom;
import com.questboard.chat.repository.ChatMessageRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ChatWebSocketHandler extends TextWebSocketHandler {

    private final List<WebSocketSession> webSocketSessions = new ArrayList<>();

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    Environment environment;

    @Autowired
    private ChatMessageRepository chatRepo;

    @Autowired
    private MongoTemplate mongoTemplate;

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        logger.info("someone connected to chatroom");
        webSocketSessions.add(session);
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        for(WebSocketSession webSocketSession : webSocketSessions){
            logger.info("session id: {}", session.getId());
            logger.info("websocket session id: {}", webSocketSession.getId());
            String chatRoomId = (String) session.getAttributes().get("chatRoomId");
            logger.info("chat room id: {}", chatRoomId);
            Map<String, String> chatRoomIds = retrieveChatRoomId(chatRoomId);
            logger.info("after splitting: {}", chatRoomIds);
            try {
//                List<ChatRoom> chatRooms = chatRepo.findByChatRoomId(Integer.parseInt(chatRoomIds.get("questId")), chatRoomIds.get("requestor"),
//                        chatRoomIds.get("taker"));
                Query query = new Query();
                query.addCriteria(Criteria.where("questId").is(Integer.parseInt(chatRoomIds.get("questId"))));
                query.addCriteria(Criteria.where("requestorUsername").is(chatRoomIds.get("requestor")));
                query.addCriteria(Criteria.where("takerUsername").is(chatRoomIds.get("taker")));
                List<ChatRoom> chatRooms = mongoTemplate.find(query, ChatRoom.class);
                if (chatRooms.isEmpty()) {
                    logger.info("chat room is empty");
//                    ChatRoom chatRoom = createNewChatRoom(Integer.parseInt(chatRoomIds.get("questId")), chatRoomIds.get("requestor"),
//                            chatRoomIds.get("taker"));
//                    chatRepo.save(chatRoom);
                } else {
                    logger.info("chat room existed");
                    logger.info("list is: {}", chatRooms);
                }
            } catch(Exception err) {
                logger.error("err: {}", err.getMessage());
                logger.error("err: {}", err.getStackTrace());
            }
            webSocketSession.sendMessage(message);
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        webSocketSessions.remove(session);
    }

//    public ChatRoom createNewChatRoom(Integer questId, String requestor, String taker) {
//        return new ChatRoom(requestor, taker, questId);
//    }

    private Map<String, String> retrieveChatRoomId(String id) {
        String tmpId = id;
        int idSize = id.length();
        String questId = tmpId.substring(0, tmpId.indexOf(";"));
        tmpId = tmpId.replace(questId + ";", "");
        String requestor = tmpId.substring(0, tmpId.indexOf(";"));
        tmpId = tmpId.replace(requestor + ";", "");
        String taker = tmpId;
        taker = taker.replace(";", "");

        HashMap<String, String> map = new HashMap<>();
        map.put("questId", questId);
        map.put("requestor", requestor);
        map.put("taker", taker);

        return map;
    }
}
