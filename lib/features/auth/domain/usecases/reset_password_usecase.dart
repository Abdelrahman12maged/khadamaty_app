import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

/// Use case for sending password reset email
class ResetPasswordUseCase {
  final AuthRepository _authRepository;

  ResetPasswordUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  /// Send password reset email
  Future<Either<Failure, void>> call(String email) async {
    return await _authRepository.sendPasswordResetEmail(email);
  }
}
