import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

/// Use case for user logout
class LogoutUseCase {
  final AuthRepository _authRepository;

  LogoutUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  /// Execute logout
  Future<Either<Failure, void>> call() async {
    return await _authRepository.logout();
  }
}
