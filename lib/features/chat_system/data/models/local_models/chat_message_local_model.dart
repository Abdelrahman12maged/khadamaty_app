import 'package:hive/hive.dart';
import '../../../domain/Entity/chat_message_entity.dart';

part 'chat_message_local_model.g.dart';

/// Hive model for ChatMessage — used by ChatLocalDatasource for caching
@HiveType(typeId: 0)
class ChatMessageLocalModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String chatId;

  @HiveField(2)
  final String senderId;

  @HiveField(3)
  final String text;

  @HiveField(4)
  final String type;

  @HiveField(5)
  final bool isRead;

  @HiveField(6)
  final int createdAtMillis;

  ChatMessageLocalModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.text,
    required this.type,
    required this.isRead,
    required this.createdAtMillis,
  });

  // ─── Domain Entity conversion ─────────────────────

  factory ChatMessageLocalModel.fromEntity(
      String chatId, ChatMessageEntity entity) {
    return ChatMessageLocalModel(
      id: entity.id,
      chatId: chatId,
      senderId: entity.senderId,
      text: entity.text,
      type: entity.type.name,
      isRead: entity.isRead,
      createdAtMillis: entity.createdAt.millisecondsSinceEpoch,
    );
  }

  ChatMessageEntity toEntity() {
    return ChatMessageEntity(
      id: id,
      senderId: senderId,
      text: text,
      type: MessageType.values.firstWhere(
        (e) => e.name == type,
        orElse: () => MessageType.text,
      ),
      isRead: isRead,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAtMillis),
    );
  }
}
