import '../Entity/chat_message_entity.dart';
import '../repository/chat_repository.dart';

class GetMessagesUseCase {
  final ChatRepository _repository;

  GetMessagesUseCase({required ChatRepository repository})
      : _repository = repository;

  Stream<List<ChatMessageEntity>> call(String chatId) {
    return _repository.getMessages(chatId);
  }
}
