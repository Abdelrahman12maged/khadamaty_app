import 'package:dartz/dartz.dart';
import 'package:khadamaty_app/core/error/exceptions.dart';
import 'package:khadamaty_app/core/error/failures.dart';
import 'package:khadamaty_app/features/bookings/domain/entities/booking_entity.dart';
import '../../domain/Entity/chat_entity.dart';
import '../../domain/Entity/chat_message_entity.dart';
import '../../domain/repository/chat_repository.dart';
import '../local_data_source/chat_local_datasourc.dart';
import '../models/local_models/chat_local_model.dart';
import '../models/local_models/chat_message_local_model.dart';
import '../models/remote_models/chat_message_models.dart';
import '../remote_data_source/chat_remote_datasource.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource _remoteDataSource;
  final ChatLocalDatasource _localDataSource;

  ChatRepositoryImpl({
    required ChatRemoteDataSource remoteDataSource,
    required ChatLocalDatasource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  // ─── getOrCreateChat ──────────────────────────────

  @override
  Future<Either<Failure, ChatEntity>> getOrCreateChat(
      BookingEntity booking) async {
    try {
      final chatModel = await _remoteDataSource.getOrCreateChat(booking);

      // Cache locally
      await _localDataSource.cacheChat(
        ChatLocalModel.fromEntity(chatModel.toEntity()),
      );

      return Right(chatModel.toEntity());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  // ─── getUserChats ─────────────────────────────────

  @override
  Stream<List<ChatEntity>> getUserChats(String userId) {
    return _remoteDataSource.getUserChats(userId).map((chatModels) {
      // Cache all chats locally
      final localModels = chatModels
          .map((m) => ChatLocalModel.fromEntity(m.toEntity()))
          .toList();
      _localDataSource.cacheChats(localModels);

      // Convert to entities
      return chatModels.map((m) => m.toEntity()).toList();
    });
  }

  // ─── getMessages ──────────────────────────────────

  @override
  Stream<List<ChatMessageEntity>> getMessages(String chatId) {
    return _remoteDataSource.getMessages(chatId).map((msgModels) {
      // Cache messages locally
      final localModels = msgModels
          .map((m) => ChatMessageLocalModel.fromEntity(chatId, m.toEntity()))
          .toList();
      _localDataSource.cacheMessages(chatId, localModels);

      // Convert to entities
      return msgModels.map((m) => m.toEntity()).toList();
    });
  }

  // ─── sendMessage ──────────────────────────────────

  @override
  Future<Either<Failure, void>> sendMessage(
      String chatId, ChatMessageEntity message) async {
    try {
      final msgModel = ChatMessageModel.fromEntity(message);
      await _remoteDataSource.sendMessage(chatId, msgModel);

      // Cache the sent message locally
      final localModel = ChatMessageLocalModel.fromEntity(chatId, message);
      await _localDataSource.cacheMessage(chatId, localModel);

      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  // ─── markAsRead ───────────────────────────────────

  @override
  Future<Either<Failure, void>> markAsRead(String chatId, String userId) async {
    try {
      await _remoteDataSource.markAsRead(chatId, userId);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }
}
