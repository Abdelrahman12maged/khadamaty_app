import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';
import '../repositories/user_repository.dart';

/// Use case for user registration
class RegisterUseCase {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  RegisterUseCase({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository;

  /// Execute registration
  /// Returns Either<Failure, UserEntity>
  Future<Either<Failure, UserEntity>> call({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    // Register with auth provider
    final registerResult = await _authRepository.register(
      name: name,
      phone: phone,
      email: email,
      password: password,
    );

    
    return registerResult.fold(
      (failure) => Left(failure),
      (user) async {
        // Send verification email
        final verificationResult =
            await _authRepository.sendEmailVerification();
        if (verificationResult.isLeft()) {
          // Log but don't fail the registration
        }

        // Save user to database
        final saveResult = await _userRepository.saveUser(user);
        return saveResult.fold(
          (failure) => Left(failure),
          (_) => Right(user),
        );
      },
    );
  }
}
