import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';
import '../repositories/user_repository.dart';

/// Use case for checking and handling email verification
class VerifyEmailUseCase {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  VerifyEmailUseCase({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository;

  /// Check if email is verified and update status
  Future<Either<Failure, EmailVerificationResult>> call() async {
    // Reload user to get latest status
    final userResult = await _authRepository.reloadUser();

    return userResult.fold(
      (failure) => Left(failure),
      (user) async {
        if (user == null) {
          return const Right(EmailVerificationResult(
            isVerified: false,
            user: null,
          ));
        }

        final verifiedResult = await _authRepository.isEmailVerified();

        return verifiedResult.fold(
          (failure) => Left(failure),
          (isVerified) async {
            if (isVerified) {
              // Update database
              await _userRepository.updateEmailVerified(user.id, true);

              return Right(EmailVerificationResult(
                isVerified: true,
                user: user.copyWith(isEmailVerified: true),
              ));
            }

            return Right(EmailVerificationResult(
              isVerified: false,
              user: user,
            ));
          },
        );
      },
    );
  }

  /// Resend verification email
  Future<Either<Failure, void>> resendVerificationEmail() async {
    return await _authRepository.sendEmailVerification();
  }
}

/// Result of email verification check
class EmailVerificationResult {
  final bool isVerified;
  final UserEntity? user;

  const EmailVerificationResult({
    required this.isVerified,
    required this.user,
  });
}
