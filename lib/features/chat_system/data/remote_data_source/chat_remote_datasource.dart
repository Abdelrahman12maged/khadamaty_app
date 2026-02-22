import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:khadamaty_app/core/error/exceptions.dart';
import 'package:khadamaty_app/features/bookings/domain/entities/booking_entity.dart';
import 'package:khadamaty_app/features/chat_system/data/models/remote_models/chat_message_models.dart';
import 'package:khadamaty_app/features/chat_system/data/models/remote_models/chat_model.dart';

abstract class ChatRemoteDataSource {
  Future<ChatModel> getOrCreateChat(BookingEntity booking);
  Stream<List<ChatModel>> getUserChats(String userId);
  Stream<List<ChatMessageModel>> getMessages(String chatId);
  Future<void> sendMessage(String chatId, ChatMessageModel msg);
  Future<void> markAsRead(String chatId, String userId);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseFirestore _firestore;

  ChatRemoteDataSourceImpl({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference<Map<String, dynamic>> get _chatsCol =>
      _firestore.collection('chats');

  CollectionReference<Map<String, dynamic>> _messagesCol(String chatId) =>
      _chatsCol.doc(chatId).collection('messages');



  // ─── getOrCreateChat ──────────────────────────────

  @override
  Future<ChatModel> getOrCreateChat(BookingEntity booking) async {
   
   



   
    try {
      // Check if a chat already exists for this booking
      final query = await _chatsCol
          .where('bookingId', isEqualTo: booking.id)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        return ChatModel.fromFirestore(query.docs.first);
      }

      // Create a new chat document
      final chatRef = _chatsCol.doc();
      final newChat = ChatModel(
        id: chatRef.id,
        bookingId: booking.id,
        customerId: booking.customerId,   
        providerId: booking.providerId,
        serviceName: booking.serviceName,
        createdAt: DateTime.now(),
      );

      await chatRef.set(newChat.toFirestore());
      return newChat;
    } on FirebaseException catch (e) {
      throw DatabaseException('Failed to get or create chat: ${e.message}');
    }
  }

  // ─── getUserChats ─────────────────────────────────

  @override
  Stream<List<ChatModel>> getUserChats(String userId) {
 
    final asCustomer = _chatsCol
        .where('customerId', isEqualTo: userId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .map((snap) =>
            snap.docs.map((doc) => ChatModel.fromFirestore(doc)).toList());

    final asProvider = _chatsCol
        .where('providerId', isEqualTo: userId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .map((snap) =>
            snap.docs.map((doc) => ChatModel.fromFirestore(doc)).toList());

    // Merge both streams and deduplicate by chatId
    return asCustomer.asyncExpand((customerChats) {
      return asProvider.map((providerChats) {
        final allChats = <String, ChatModel>{};
        for (final chat in customerChats) {
          allChats[chat.id] = chat;
        }
        for (final chat in providerChats) {
          allChats[chat.id] = chat;
        }
        final merged = allChats.values.toList();
        // Sort by lastMessageTime descending
        merged.sort((a, b) {
          final aTime = a.lastMessageTime ?? a.createdAt;
          final bTime = b.lastMessageTime ?? b.createdAt;
          return bTime.compareTo(aTime);
        });
        return merged;
      });
    });
  }

  // ─── getMessages ──────────────────────────────────

  @override
  Stream<List<ChatMessageModel>> getMessages(String chatId) {
    return _messagesCol(chatId)
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => ChatMessageModel.fromFirestore(doc))
            .toList());
  }

  // ─── sendMessage ──────────────────────────────────

  @override
  Future<void> sendMessage(String chatId, ChatMessageModel msg) async {
    try {
      final batch = _firestore.batch();

      // 1) Add the message to the messages subcollection
      final msgRef = _messagesCol(chatId).doc();
      batch.set(msgRef, msg.toFirestore());

      // 2) Update the chat's last message info
      final chatRef = _chatsCol.doc(chatId);
      batch.update(chatRef, {
        'lastMessage': msg.text,
        'lastMessageTime': Timestamp.fromDate(msg.createdAt),
      });

      await batch.commit();
    } on FirebaseException catch (e) {
      throw DatabaseException('Failed to send message: ${e.message}');
    }
  }

  // ─── markAsRead ───────────────────────────────────

  @override
  Future<void> markAsRead(String chatId, String userId) async {
    try {
      // Get the chat to determine user role
      final chatDoc = await _chatsCol.doc(chatId).get();
      if (!chatDoc.exists) return;

      final data = chatDoc.data()!;
      final isCustomer = data['customerId'] == userId;

      // Reset the unread count for this user's role
      await _chatsCol.doc(chatId).update({
        if (isCustomer) 'customerUnreadCount': 0,
        if (!isCustomer) 'providerUnreadCount': 0,
      });

      // Mark all unread messages as read (sent by the other user)
      final unreadMessages = await _messagesCol(chatId)
          .where('isRead', isEqualTo: false)
          .where('senderId', isNotEqualTo: userId)
          .get();

      if (unreadMessages.docs.isEmpty) return;

      final batch = _firestore.batch();
      for (final doc in unreadMessages.docs) {
        batch.update(doc.reference, {'isRead': true});
      }
      await batch.commit();
    } on FirebaseException catch (e) {
      throw DatabaseException('Failed to mark as read: ${e.message}');
    }
  }
}
