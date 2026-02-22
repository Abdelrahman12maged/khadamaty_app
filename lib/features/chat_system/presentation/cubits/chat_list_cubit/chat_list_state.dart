import 'package:equatable/equatable.dart';
import '../../../domain/Entity/chat_entity.dart';

class ChatListState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<ChatEntity> chats;

  const ChatListState({
    this.isLoading = false,
    this.error,
    this.chats = const [],
  });

  ChatListState copyWith({
    bool? isLoading,
    String? error,
    bool clearError = false,
    List<ChatEntity>? chats,
  }) {
    return ChatListState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      chats: chats ?? this.chats,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, chats];
}
