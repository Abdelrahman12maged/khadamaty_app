import '../Entity/chat_entity.dart';
import '../repository/chat_repository.dart';

class GetUserChatsUseCase {
  final ChatRepository _repository;

  GetUserChatsUseCase({required ChatRepository repository})
      : _repository = repository;

  Stream<List<ChatEntity>> call(String userId) {
    return _repository.getUserChats(userId);
  }
}
