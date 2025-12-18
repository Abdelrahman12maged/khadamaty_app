import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/i_auth_repository.dart';

/// Use case for user logout
class LogoutUseCase {
  final IAuthRepository _authRepository;

  LogoutUseCase({required IAuthRepository authRepository})
      : _authRepository = authRepository;

  /// Execute logout
  Future<Either<Failure, void>> call() async {
    return await _authRepository.logout();
  }
}
