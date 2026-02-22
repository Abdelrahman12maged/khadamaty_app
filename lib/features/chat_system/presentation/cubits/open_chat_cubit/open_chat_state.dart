import 'package:equatable/equatable.dart';
import '../../../domain/Entity/chat_entity.dart';

class OpenChatState extends Equatable {
  final bool isLoading;
  final String? error;
  final ChatEntity? chat;

  const OpenChatState({
    this.isLoading = false,
    this.error,
    this.chat,
  });

  OpenChatState copyWith({
    bool? isLoading,
    String? error,
    bool clearError = false,
    ChatEntity? chat,
  }) {
    return OpenChatState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      chat: chat,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, chat];
}
