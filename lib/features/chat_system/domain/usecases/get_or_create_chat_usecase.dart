import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../bookings/domain/entities/booking_entity.dart';
import '../Entity/chat_entity.dart';
import '../repository/chat_repository.dart';

class GetOrCreateChatUseCase {
  final ChatRepository _repository;

  GetOrCreateChatUseCase({required ChatRepository repository})
      : _repository = repository;

  Future<Either<Failure, ChatEntity>> call(BookingEntity booking) async {
    return await _repository.getOrCreateChat(booking);
  }
}
