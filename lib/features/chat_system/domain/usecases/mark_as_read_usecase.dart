import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repository/chat_repository.dart';

class MarkAsReadUseCase {
  final ChatRepository _repository;

  MarkAsReadUseCase({required ChatRepository repository})
      : _repository = repository;

  Future<Either<Failure, void>> call(String chatId, String userId) async {
    return await _repository.markAsRead(chatId, userId);
  }
}
