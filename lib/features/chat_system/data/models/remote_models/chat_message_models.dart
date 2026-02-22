import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/Entity/chat_message_entity.dart';

/// Firestore model for ChatMessage — used by ChatRemoteDataSource
class ChatMessageModel {
  final String id;
  final String senderId;
  final String text;
  final MessageType type;
  final bool isRead;
  final DateTime createdAt;

  const ChatMessageModel({
    required this.id,
    required this.senderId,
    required this.text,
    required this.type,
    required this.isRead,
    required this.createdAt,
  });

  // ─── Firestore ────────────────────────────────────

  factory ChatMessageModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatMessageModel(
      id: doc.id,
      senderId: data['senderId'] ?? '',
      text: data['text'] ?? '',
      type: MessageType.values.firstWhere(
        (e) => e.name == data['type'],
        orElse: () => MessageType.text,
      ),
      isRead: data['isRead'] ?? false,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'senderId': senderId,
      'text': text,
      'type': type.name,
      'isRead': isRead,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  // ─── Domain Entity conversion ─────────────────────

  factory ChatMessageModel.fromEntity(ChatMessageEntity entity) {
    return ChatMessageModel(
      id: entity.id,
      senderId: entity.senderId,
      text: entity.text,
      type: entity.type,
      isRead: entity.isRead,
      createdAt: entity.createdAt,
    );
  }

  ChatMessageEntity toEntity() {
    return ChatMessageEntity(
      id: id,
      senderId: senderId,
      text: text,
      type: type,
      isRead: isRead,
      createdAt: createdAt,
    );
  }
}
