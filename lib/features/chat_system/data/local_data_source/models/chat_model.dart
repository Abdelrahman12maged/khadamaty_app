import 'package:hive/hive.dart';
import '../../../domain/Entity/chat_entity.dart';

part 'chat_model.g.dart';

/// Hive model for Chat — stores DateTime as millis for cross-platform safety
@HiveType(typeId: 1)
class ChatModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String bookingId;

  @HiveField(2)
  final String customerId;

  @HiveField(3)
  final String providerId;

  @HiveField(4)
  final String serviceName;

  @HiveField(5)
  final String? lastMessage;

  @HiveField(6)
  final int? lastMessageTimeMillis;

  @HiveField(7)
  final int customerUnreadCount;

  @HiveField(8)
  final int providerUnreadCount;

  @HiveField(9)
  final int createdAtMillis;

  ChatModel({
    required this.id,
    required this.bookingId,
    required this.customerId,
    required this.providerId,
    required this.serviceName,
    this.lastMessage,
    this.lastMessageTimeMillis,
    this.customerUnreadCount = 0,
    this.providerUnreadCount = 0,
    required this.createdAtMillis,
  });

  /// Convert from domain entity
  factory ChatModel.fromEntity(ChatEntity entity) {
    return ChatModel(
      id: entity.id,
      bookingId: entity.bookingId,
      customerId: entity.customerId,
      providerId: entity.providerId,
      serviceName: entity.serviceName,
      lastMessage: entity.lastMessage,
      lastMessageTimeMillis: entity.lastMessageTime?.millisecondsSinceEpoch,
      customerUnreadCount: entity.customerUnreadCount,
      providerUnreadCount: entity.providerUnreadCount,
      createdAtMillis: entity.createdAt.millisecondsSinceEpoch,
    );
  }

  /// Convert to domain entity
  ChatEntity toEntity() {
    return ChatEntity(
      id: id,
      bookingId: bookingId,
      customerId: customerId,
      providerId: providerId,
      serviceName: serviceName,
      lastMessage: lastMessage,
      lastMessageTime: lastMessageTimeMillis != null
          ? DateTime.fromMillisecondsSinceEpoch(lastMessageTimeMillis!)
          : null,
      customerUnreadCount: customerUnreadCount,
      providerUnreadCount: providerUnreadCount,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAtMillis),
    );
  }
}
