import 'package:equatable/equatable.dart';
import '../../../domain/Entity/chat_entity.dart';
import '../../../domain/Entity/chat_message_entity.dart';

class ChatState extends Equatable {
  final bool isLoading;
  final bool isSending;
  final String? error;
  final ChatEntity? chat;
  final List<ChatMessageEntity> messages;

  const ChatState({
    this.isLoading = false,
    this.isSending = false,
    this.error,
    this.chat,
    this.messages = const [],
  });

  ChatState copyWith({
    bool? isLoading,
    bool? isSending,
    String? error,
    bool clearError = false,
    ChatEntity? chat,
    List<ChatMessageEntity>? messages,
  }) {
    return ChatState(
      isLoading: isLoading ?? this.isLoading,
      isSending: isSending ?? this.isSending,
      error: clearError ? null : (error ?? this.error),
      chat: chat ?? this.chat,
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSending, error, chat, messages];
}
