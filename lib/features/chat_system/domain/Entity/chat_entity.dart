import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
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

  const ChatEntity({
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

  ChatEntity copyWith({
    String? id,
    String? bookingId,
    String? customerId,
    String? providerId,
    String? serviceName,
    String? lastMessage,
    DateTime? lastMessageTime,
    int? customerUnreadCount,
    int? providerUnreadCount,
    DateTime? createdAt,
  }) {
    return ChatEntity(
      id: id ?? this.id,
      bookingId: bookingId ?? this.bookingId,
      customerId: customerId ?? this.customerId,
      providerId: providerId ?? this.providerId,
      serviceName: serviceName ?? this.serviceName,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      customerUnreadCount: customerUnreadCount ?? this.customerUnreadCount,
      providerUnreadCount: providerUnreadCount ?? this.providerUnreadCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        bookingId,
        customerId,
        providerId,
        serviceName,
        lastMessage,
        lastMessageTime,
        customerUnreadCount,
        providerUnreadCount,
        createdAt,
      ];
}
