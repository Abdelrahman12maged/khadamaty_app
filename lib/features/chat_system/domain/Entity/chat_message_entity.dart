import 'package:equatable/equatable.dart';

enum MessageType {
  text,
  image,
  system, // e.g. "Booking confirmed", "Booking cancelled"
}

/// Represents a single message in a chat conversation
class ChatMessageEntity extends Equatable {
  final String id;
  final String senderId;
  final String text;
  final MessageType type;
  final bool isRead;
  final DateTime createdAt;

  const ChatMessageEntity({
    required this.id,
    required this.senderId,
    required this.text,
    required this.type,
    required this.isRead,
    required this.createdAt,
  });

  ChatMessageEntity copyWith({
    String? id,
    String? senderId,
    String? text,
    MessageType? type,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return ChatMessageEntity(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      text: text ?? this.text,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, senderId, text, type, isRead, createdAt];
}
