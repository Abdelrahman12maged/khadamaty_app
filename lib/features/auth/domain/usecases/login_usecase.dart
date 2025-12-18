import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/i_auth_repository.dart';
import '../repositories/i_user_repository.dart';

/// Use case for user login
class LoginUseCase {
  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;

  LoginUseCase({
    required IAuthRepository authRepository,
    required IUserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository;

  /// Execute login
  /// Returns Either<Failure, LoginResult>
  Future<Either<Failure, LoginResult>> call({
    required String email,
    required String password,
  }) async {
    // Login with auth provider
    final loginResult = await _authRepository.login(
      email: email,
      password: password,
    );

    return loginResult.fold(
      (failure) => Left(failure),
      (user) async {
        // Check email verification
        final verifiedResult = await _authRepository.isEmailVerified();

        return verifiedResult.fold(
          (failure) => Left(failure),
          (isVerified) async {
            if (!isVerified) {
              return Right(LoginResult(
                user: user,
                isEmailVerified: false,
              ));
            }

            // Update email verification status in database if needed
            final dbUserResult = await _userRepository.getUser(user.id);
            dbUserResult.fold(
              (failure) => null,
              (dbUser) async {
                if (dbUser != null && !dbUser.isEmailVerified) {
                  await _userRepository.updateEmailVerified(user.id, true);
                }
              },
            );

            return Right(LoginResult(
              user: user.copyWith(isEmailVerified: true),
              isEmailVerified: true,
            ));
          },
        );
      },
    );
  }
}

/// Login result containing user and verification status
class LoginResult {
  final UserEntity user;
  final bool isEmailVerified;

  const LoginResult({
    required this.user,
    required this.isEmailVerified,
  });
}
