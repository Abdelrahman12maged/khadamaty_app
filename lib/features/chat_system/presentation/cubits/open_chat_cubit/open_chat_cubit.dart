import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../bookings/domain/entities/booking_entity.dart';
import '../../../domain/usecases/get_or_create_chat_usecase.dart';
import 'open_chat_state.dart';

class OpenChatCubit extends Cubit<OpenChatState> {
  final GetOrCreateChatUseCase _getOrCreateChatUseCase;

  OpenChatCubit({
    required GetOrCreateChatUseCase getOrCreateChatUseCase,
  })  : _getOrCreateChatUseCase = getOrCreateChatUseCase,
        super(const OpenChatState());

  /// Open or create a chat for a booking
  Future<void> openChat(BookingEntity booking) async {
    emit(state.copyWith(isLoading: true, clearError: true));

    final result = await _getOrCreateChatUseCase(booking);

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        error: failure.message,
      )),
      (chat) => emit(state.copyWith(
        isLoading: false,
        chat: chat,
      )),
    );
  }
}
