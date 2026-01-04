import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';

/// Abstract repository interface for user data operations
/// Data layer will implement this interface
/// Returns Either<Failure, T> for error handling
abstract class UserRepository {
  /// Save user to database
  Future<Either<Failure, void>> saveUser(UserEntity user);

  /// Get user by ID
  Future<Either<Failure, UserEntity?>> getUser(String uid);

  /// Update user profile
  Future<Either<Failure, void>> updateUser(
      String uid, Map<String, dynamic> data);

  /// Check if user exists
  Future<Either<Failure, bool>> userExists(String uid);

  /// Update email verification status
  Future<Either<Failure, void>> updateEmailVerified(String uid, bool verified);

  /// Stream of user data
  Stream<UserEntity?> userStream(String uid);
}
