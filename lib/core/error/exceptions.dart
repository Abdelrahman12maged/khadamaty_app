/// Base class for all exceptions in the app
abstract class AppException implements Exception {
  final String message;
  final String? code;

  const AppException(this.message, [this.code]);

  @override
  String toString() => message;
}

/// Server related exceptions (network, 500s, etc.)
class ServerException extends AppException {
  const ServerException(super.message, [super.code]);
}

/// Database related exceptions (Firestore errors, etc.)
class DatabaseException extends AppException {
  const DatabaseException(super.message, [super.code]);
}

/// Cache related exceptions
class CacheException extends AppException {
  const CacheException(super.message, [super.code]);
}

/// Authentication related exceptions
class AuthException extends AppException {
  const AuthException(super.message, [super.code]);
}

/// Validation related exceptions
class ValidationException extends AppException {
  const ValidationException(super.message, [super.code]);
}
