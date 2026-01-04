import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';

/// Abstract repository interface for authentication
/// Data layer will implement this interface
/// Returns Either<Failure, T> for error handling
abstract class AuthRepository {
  /// Register a new user with email and password
  Future<Either<Failure, UserEntity>> register({
    required String name,
    required String phone,
    required String email,
    required String password,
  });

  /// Login with email and password
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });

  /// Logout the current user
  Future<Either<Failure, void>> logout();

  /// Send email verification to current user
  Future<Either<Failure, void>> sendEmailVerification();

  /// Check if current user's email is verified
  Future<Either<Failure, bool>> isEmailVerified();

  /// Reload user to get latest verification status
  Future<Either<Failure, UserEntity?>> reloadUser();

  /// Send password reset email
  Future<Either<Failure, void>> sendPasswordResetEmail(String email);

  /// Get current user
  UserEntity? get currentUser;

  /// Stream of authentication state changes
  Stream<UserEntity?> get authStateChanges;
}
