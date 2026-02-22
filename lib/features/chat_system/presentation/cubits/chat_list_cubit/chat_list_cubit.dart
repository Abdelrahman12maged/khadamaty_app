import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamaty_app/features/auth/domain/repositories/auth_repository.dart';
import '../../../domain/usecases/get_user_chats_usecase.dart';
import 'chat_list_state.dart';

class ChatListCubit extends Cubit<ChatListState> {
  final GetUserChatsUseCase _getUserChatsUseCase;
  final AuthRepository _authRepository;
  StreamSubscription? _chatsSubscription;

  ChatListCubit({
    required GetUserChatsUseCase getUserChatsUseCase,
    required AuthRepository authRepository,
  })  : _getUserChatsUseCase = getUserChatsUseCase,
        _authRepository = authRepository,
        super(const ChatListState());

  /// Subscribe to chats stream for the current user
  void loadChats() {
    final user = _authRepository.currentUser;
    if (user == null) {
      emit(state.copyWith(
        isLoading: false,
        error: 'يجب تسجيل الدخول لعرض المحادثات',
      ));
      return;
    }

    emit(state.copyWith(isLoading: true, clearError: true));

    _chatsSubscription?.cancel();
    _chatsSubscription = _getUserChatsUseCase(user.id).listen(
      (chats) {
        emit(state.copyWith(isLoading: false, chats: chats));
      },
      onError: (error) {
        emit(state.copyWith(
          isLoading: false,
          error: 'فشل تحميل المحادثات: $error',
        ));
      },
    );
  }

  @override
  Future<void> close() {
    _chatsSubscription?.cancel();
    return super.close();
  }
}
