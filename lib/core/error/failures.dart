import 'package:equatable/equatable.dart';

/// Base class for all failures in the app
abstract class Failure extends Equatable {
  final String message;
  final String? code;

  const Failure({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];
}

/// Server/Network related failures
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.code,
  });
}

/// Authentication related failures
class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    super.code,
  });

  /// Factory methods for common auth failures
  factory AuthFailure.emailAlreadyInUse() => const AuthFailure(
        message: 'This email is already registered',
        code: 'email-already-in-use',
      );

  factory AuthFailure.invalidEmail() => const AuthFailure(
        message: 'Invalid email address',
        code: 'invalid-email',
      );

  factory AuthFailure.weakPassword() => const AuthFailure(
        message: 'Password is too weak',
        code: 'weak-password',
      );

  factory AuthFailure.userNotFound() => const AuthFailure(
        message: 'No account found with this email',
        code: 'user-not-found',
      );

  factory AuthFailure.wrongPassword() => const AuthFailure(
        message: 'Incorrect password',
        code: 'wrong-password',
      );

  factory AuthFailure.userDisabled() => const AuthFailure(
        message: 'This account has been disabled',
        code: 'user-disabled',
      );

  factory AuthFailure.tooManyRequests() => const AuthFailure(
        message: 'Too many attempts. Please try again later',
        code: 'too-many-requests',
      );

  factory AuthFailure.emailNotVerified() => const AuthFailure(
        message: 'Email not verified',
        code: 'email-not-verified',
      );

  factory AuthFailure.unknown([String? message]) => AuthFailure(
        message: message ?? 'An unknown error occurred',
        code: 'unknown',
      );
}

/// Database related failures
class DatabaseFailure extends Failure {
  const DatabaseFailure({
    required super.message,
    super.code,
  });

  factory DatabaseFailure.notFound() => const DatabaseFailure(
        message: 'Data not found',
        code: 'not-found',
      );

  factory DatabaseFailure.permissionDenied() => const DatabaseFailure(
        message: 'Permission denied',
        code: 'permission-denied',
      );
}

/// Validation related failures
class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.code,
  });

  factory ValidationFailure.invalidInput(String field) => ValidationFailure(
        message: 'Invalid $field',
        code: 'invalid-input',
      );
}

/// Cache related failures
class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.code,
  });
}
