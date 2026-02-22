import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/Entity/chat_entity.dart';
import '../../../domain/Entity/chat_message_entity.dart';
import '../../../domain/usecases/get_messages_usecase.dart';
import '../../../domain/usecases/send_message_usecase.dart';
import '../../../domain/usecases/mark_as_read_usecase.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final GetMessagesUseCase _getMessagesUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  final MarkAsReadUseCase _markAsReadUseCase;
  StreamSubscription? _messagesSubscription;

  ChatCubit({
    required GetMessagesUseCase getMessagesUseCase,
    required SendMessageUseCase sendMessageUseCase,
    required MarkAsReadUseCase markAsReadUseCase,
  })  : _getMessagesUseCase = getMessagesUseCase,
        _sendMessageUseCase = sendMessageUseCase,
        _markAsReadUseCase = markAsReadUseCase,
        super(const ChatState());

  /// Initialize with chat entity and subscribe to messages
  void init(ChatEntity chat, String currentUserId) {
    emit(state.copyWith(chat: chat, isLoading: true, clearError: true));

    _messagesSubscription?.cancel();
    _messagesSubscription = _getMessagesUseCase(chat.id).listen(
      (messages) {
        emit(state.copyWith(isLoading: false, messages: messages));
      },
      onError: (error) {
        emit(state.copyWith(
          isLoading: false,
          error: 'فشل تحميل الرسائل: $error',
        ));
      },
    );

    // Mark as read when entering the chat
    _markAsReadUseCase(chat.id, currentUserId);
  }

  /// Send a text message
  Future<void> sendMessage(String text, String senderId) async {
    final chat = state.chat;
    if (chat == null || text.trim().isEmpty) return;

    emit(state.copyWith(isSending: true, clearError: true));

    final message = ChatMessageEntity(
      id: '', // Firestore will generate the ID
      senderId: senderId,
      text: text.trim(),
      type: MessageType.text,
      isRead: false,
      createdAt: DateTime.now(),
    );

    final result = await _sendMessageUseCase(chat.id, message);

    result.fold(
      (failure) => emit(state.copyWith(
        isSending: false,
        error: failure.message,
      )),
      (_) => emit(state.copyWith(isSending: false)),
    );
  }

  /// Mark messages as read
  Future<void> markAsRead(String userId) async {
    final chat = state.chat;
    if (chat == null) return;
    await _markAsReadUseCase(chat.id, userId);
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
