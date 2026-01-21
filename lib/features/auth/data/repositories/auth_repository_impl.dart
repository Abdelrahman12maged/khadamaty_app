import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

/// Firebase implementation of AuthRepository
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl({required AuthRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  UserEntity? get currentUser => _remoteDataSource.currentUser;

  @override
  Stream<UserEntity?> get authStateChanges =>
      _remoteDataSource.authStateChanges;

  @override
  Future<Either<Failure, UserEntity>> register({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await _remoteDataSource.register(
        name: name,
        email: email,
        password: password,
      );

      return Right(UserEntity(
        id: userModel.id,
        email: userModel.email,
        name: userModel.name,
        phoneNumber: phone,
        isEmailVerified: userModel.isEmailVerified,
        createdAt: userModel.createdAt,
      ));
    } on AuthException catch (e) {
      return Left(_mapAuthException(e));
    } catch (e) {
      return Left(AuthFailure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await _remoteDataSource.login(
        email: email,
        password: password,
      );

      return Right(UserEntity(
        id: userModel.id,
        email: userModel.email,
        name: userModel.name,
        isEmailVerified: userModel.isEmailVerified,
      ));
    } on AuthException catch (e) {
      return Left(_mapAuthException(e));
    } catch (e) {
      return Left(AuthFailure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _remoteDataSource.logout();
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendEmailVerification() async {
    try {
      await _remoteDataSource.sendEmailVerification();
      return const Right(null);
    } catch (e) {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, bool>> isEmailVerified() async {
    try {
      final isVerified = await _remoteDataSource.isEmailVerified();
      return Right(isVerified);
    } catch (e) {
      return const Right(false);
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> reloadUser() async {
    try {
      final userEntity = await _remoteDataSource.reloadUser();
      if (userEntity == null) return const Right(null);

      // We already returned UserEntity? from remoteDataSource based on interface
      return Right(userEntity);
    } catch (e) {
      return Left(AuthFailure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    try {
      await _remoteDataSource.sendPasswordResetEmail(email);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(_mapAuthException(e));
    } catch (e) {
      return Left(AuthFailure.unknown(e.toString()));
    }
  }

  /// Map AuthException (from Data Source) to AuthFailure
  AuthFailure _mapAuthException(AuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return AuthFailure.emailAlreadyInUse();
      case 'invalid-email':
        return AuthFailure.invalidEmail();
      case 'weak-password':
        return AuthFailure.weakPassword();
      case 'user-not-found':
        return AuthFailure.userNotFound();
      case 'wrong-password':
        return AuthFailure.wrongPassword();
      case 'user-disabled':
        return AuthFailure.userDisabled();
      case 'too-many-requests':
        return AuthFailure.tooManyRequests();
      default:
        return AuthFailure.unknown(e.message);
    }
  }
}
