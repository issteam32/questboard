package com.questboard.chat.repository;

import com.questboard.chat.model.ChatRoom;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.Optional;

public interface ChatRoomRepository  extends MongoRepository<ChatRoom, String> {
    Optional<ChatRoom> findBySenderIdAndRecipientIdAndQuestId(String senderId, String recipientId, String questId);
}
