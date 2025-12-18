import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/i_auth_repository.dart';

/// Use case for sending password reset email
class ResetPasswordUseCase {
  final IAuthRepository _authRepository;

  ResetPasswordUseCase({required IAuthRepository authRepository})
      : _authRepository = authRepository;

  /// Send password reset email
  Future<Either<Failure, void>> call(String email) async {
    return await _authRepository.sendPasswordResetEmail(email);
  }
}
