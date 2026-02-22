import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../Entity/chat_entity.dart';
import '../Entity/chat_message_entity.dart';
import 'package:khadamaty_app/features/bookings/domain/entities/booking_entity.dart';

abstract class ChatRepository {
  /// Get or create a chat linked to a booking
  Future<Either<Failure, ChatEntity>> getOrCreateChat(BookingEntity booking);

  /// Stream of all chats for a user (customer or provider)
  Stream<List<ChatEntity>> getUserChats(String userId);

  /// Stream of messages for a specific chat
  Stream<List<ChatMessageEntity>> getMessages(String chatId);

  /// Send a message in a chat
  Future<Either<Failure, void>> sendMessage(
      String chatId, ChatMessageEntity message);

  /// Mark all messages in a chat as read for a user
  Future<Either<Failure, void>> markAsRead(String chatId, String userId);
}
