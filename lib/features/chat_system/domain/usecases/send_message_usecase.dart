import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../Entity/chat_message_entity.dart';
import '../repository/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository _repository;

  SendMessageUseCase({required ChatRepository repository})
      : _repository = repository;

  Future<Either<Failure, void>> call(
      String chatId, ChatMessageEntity message) async {
    return await _repository.sendMessage(chatId, message);
  }
}
