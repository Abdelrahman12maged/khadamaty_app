import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/Entity/chat_entity.dart';

/// Firestore model for Chat — used by ChatRemoteDataSource
class ChatModel {
  final String id;
  final String bookingId;
  final String customerId;
  final String providerId;
  final String serviceName;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final int customerUnreadCount;
  final int providerUnreadCount;
  final DateTime createdAt;

  const ChatModel({
    required this.id,
    required this.bookingId,
    required this.customerId,
    required this.providerId,
    required this.serviceName,
    this.lastMessage,
    this.lastMessageTime,
    this.customerUnreadCount = 0,
    this.providerUnreadCount = 0,
    required this.createdAt,
  });

  // ─── Firestore ────────────────────────────────────

  factory ChatModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatModel(
      id: doc.id,
      bookingId: data['bookingId'] ?? '',
      customerId: data['customerId'] ?? '',
      providerId: data['providerId'] ?? '',
      serviceName: data['serviceName'] ?? '',
      lastMessage: data['lastMessage'],
      lastMessageTime: (data['lastMessageTime'] as Timestamp?)?.toDate(),
      customerUnreadCount: data['customerUnreadCount'] ?? 0,
      providerUnreadCount: data['providerUnreadCount'] ?? 0,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'bookingId': bookingId,
      'customerId': customerId,
      'providerId': providerId,
      'serviceName': serviceName,
      'lastMessage': lastMessage,
      'lastMessageTime':
          lastMessageTime != null ? Timestamp.fromDate(lastMessageTime!) : null,
      'customerUnreadCount': customerUnreadCount,
      'providerUnreadCount': providerUnreadCount,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  // ─── Domain Entity conversion ─────────────────────

  factory ChatModel.fromEntity(ChatEntity entity) {
    return ChatModel(
      id: entity.id,
      bookingId: entity.bookingId,
      customerId: entity.customerId,
      providerId: entity.providerId,
      serviceName: entity.serviceName,
      lastMessage: entity.lastMessage,
      lastMessageTime: entity.lastMessageTime,
      customerUnreadCount: entity.customerUnreadCount,
      providerUnreadCount: entity.providerUnreadCount,
      createdAt: entity.createdAt,
    );
  }

  ChatEntity toEntity() {
    return ChatEntity(
      id: id,
      bookingId: bookingId,
      customerId: customerId,
      providerId: providerId,
      serviceName: serviceName,
      lastMessage: lastMessage,
      lastMessageTime: lastMessageTime,
      customerUnreadCount: customerUnreadCount,
      providerUnreadCount: providerUnreadCount,
      createdAt: createdAt,
    );
  }
}
