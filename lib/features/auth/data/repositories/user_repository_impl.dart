import 'package:dartz/dartz.dart';
import 'package:khadamaty_app/core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../datasources/user_remote_data_source.dart';

/// Firestore implementation of UserRepository
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;

  UserRepositoryImpl({required UserRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, void>> saveUser(UserEntity user) async {
    try {
      await _remoteDataSource.saveUser(user);
      return const Right(null);
    } on AuthException catch (e) {
      // Assuming database failure is treated similarly
      return Left(DatabaseFailure(message: e.message));
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getUser(String uid) async {
    try {
      final userModel = await _remoteDataSource.getUser(uid);
      if (userModel == null) return const Right(null);

      return Right(UserEntity(
        id: userModel.id,
        email: userModel.email,
        name: userModel.name,
        phoneNumber: userModel.phoneNumber,
        isEmailVerified: userModel.isEmailVerified,
        isPhoneVerified: userModel.isPhoneVerified,
        createdAt: userModel.createdAt,
      ));
    } on AuthException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateUser(
      String uid, Map<String, dynamic> data) async {
    try {
      await _remoteDataSource.updateUser(uid, data);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> userExists(String uid) async {
    try {
      final exists = await _remoteDataSource.userExists(uid);
      return Right(exists);
    } on AuthException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateEmailVerified(
      String uid, bool verified) async {
    try {
      await _remoteDataSource.updateEmailVerified(uid, verified);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Stream<UserEntity?> userStream(String uid) {
    return _remoteDataSource.userStream(uid).map((userModel) {
      if (userModel == null) return null;
      return UserEntity(
        id: userModel.id,
        email: userModel.email,
        name: userModel.name,
        phoneNumber: userModel.phoneNumber,
        isEmailVerified: userModel.isEmailVerified,
        isPhoneVerified: userModel.isPhoneVerified,
        createdAt: userModel.createdAt,
      );
    });
  }
}
