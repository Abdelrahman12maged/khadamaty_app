import 'package:hive/hive.dart';
import 'package:khadamaty_app/core/error/exceptions.dart';
import '../models/local_models/chat_local_model.dart';
import '../models/local_models/chat_message_local_model.dart';

/// Abstract local data source for chat caching
abstract class ChatLocalDatasource {
  /// Get all cached chats for a user (as customer or provider)
  Future<List<ChatLocalModel>> getUserChats(String userId);

  /// Get a cached chat by booking ID
  Future<ChatLocalModel?> getChatByBookingId(String bookingId);

  /// Cache a single chat
  Future<void> cacheChat(ChatLocalModel chat);

  /// Cache multiple chats at once
  Future<void> cacheChats(List<ChatLocalModel> chats);

  /// Get cached messages for a specific chat
  Future<List<ChatMessageLocalModel>> getChatMessages(String chatId);

  /// Cache messages for a specific chat
  Future<void> cacheMessages(
      String chatId, List<ChatMessageLocalModel> messages);

  /// Add a single message to cache
  Future<void> cacheMessage(String chatId, ChatMessageLocalModel message);

  /// Clear all chat cache
  Future<void> clearCache();
}

class ChatLocalDatasourceImpl implements ChatLocalDatasource {
  final Box<ChatLocalModel> _chatsBox;
  final Box<ChatMessageLocalModel> _messagesBox;

  ChatLocalDatasourceImpl({required Box <ChatLocalModel> chatsBox,required Box<ChatMessageLocalModel> messagesBox})
  :_chatsBox=chatsBox,_messagesBox=messagesBox;
  @override
  Future<List<ChatLocalModel>> getUserChats(String userId) async {
    try {
      final chats = _chatsBox.values
          .where(
            (chat) => chat.customerId == userId || chat.providerId == userId,
          )
          .toList();

      // Sort by lastMessageTime descending (newest first)
      chats.sort((a, b) {
        final aTime = a.lastMessageTimeMillis ?? a.createdAtMillis;
        final bTime = b.lastMessageTimeMillis ?? b.createdAtMillis;
        return bTime.compareTo(aTime);
      });

      return chats;
    } catch (e) {
      throw CacheException('Failed to get cached chats: $e');
    }
  }

  @override
  Future<ChatLocalModel?> getChatByBookingId(String bookingId) async {
    try {
      return _chatsBox.values.cast<ChatLocalModel?>().firstWhere(
            (chat) => chat?.bookingId == bookingId,
            orElse: () => null,
          );
    } catch (e) {
      throw CacheException('Failed to get cached chat: $e');
    }
  }

  @override
  Future<void> cacheChat(ChatLocalModel chat) async {
    try {
      await _chatsBox.put(chat.id, chat);
    } catch (e) {
      throw CacheException('Failed to cache chat: $e');
    }
  }

  @override
  Future<void> cacheChats(List<ChatLocalModel> chats) async {
    try {
      final entries = <String, ChatLocalModel>{};
      for (final chat in chats) {
        entries[chat.id] = chat;
      }
      await _chatsBox.putAll(entries);
    } catch (e) {
      throw CacheException('Failed to cache chats: $e');
    }
  }

  @override
  Future<List<ChatMessageLocalModel>> getChatMessages(String chatId) async {
    try {
      final messages =
          _messagesBox.values.where((msg) => msg.chatId == chatId).toList();

      // Sort by createdAt ascending (oldest first — natural chat order)
      messages.sort((a, b) => a.createdAtMillis.compareTo(b.createdAtMillis));

      return messages;
    } catch (e) {
      throw CacheException('Failed to get cached messages: $e');
    }
  }

  @override
  Future<void> cacheMessages(
      String chatId, List<ChatMessageLocalModel> messages) async {
    try {
      final entries = <String, ChatMessageLocalModel>{};
      for (final msg in messages) {
        entries[msg.id] = msg;
      }
      await _messagesBox.putAll(entries);
    } catch (e) {
      throw CacheException('Failed to cache messages: $e');
    }
  }

  @override
  Future<void> cacheMessage(
      String chatId, ChatMessageLocalModel message) async {
    try {
      await _messagesBox.put(message.id, message);
    } catch (e) {
      throw CacheException('Failed to cache message: $e');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await _chatsBox.clear();
      await _messagesBox.clear();
    } catch (e) {
      throw CacheException('Failed to clear chat cache: $e');
    }
  }
}
