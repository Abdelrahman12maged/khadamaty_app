import 'package:flutter/material.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import '../error/failures.dart';

/// Maps Failure codes to localized error messages
class ErrorMapper {
  /// Get localized message for a Failure
  static String getLocalizedMessage(BuildContext context, Failure failure) {
    final s = S.of(context);

    if (failure is AuthFailure) {
      return _mapAuthError(s, failure.code);
    } else if (failure is DatabaseFailure) {
      return _mapDatabaseError(s, failure.code);
    }

    return failure.message;
  }

  /// Map auth error codes to localized messages
  static String _mapAuthError(S s, String? code) {
    switch (code) {
      case 'email-already-in-use':
        return s.errorEmailAlreadyInUse;
      case 'invalid-email':
        return s.errorInvalidEmail;
      case 'weak-password':
        return s.errorWeakPassword;
      case 'user-not-found':
        return s.errorUserNotFound;
      case 'wrong-password':
        return s.errorWrongPassword;
      case 'user-disabled':
        return s.errorUserDisabled;
      case 'too-many-requests':
        return s.errorTooManyRequests;
      case 'operation-not-allowed':
        return s.errorOperationNotAllowed;
      case 'network-request-failed':
        return s.errorNetworkRequestFailed;
      case 'email-not-verified':
        return s.emailNotVerified;
      default:
        return s.errorUnknown;
    }
  }

  /// Map database error codes to localized messages
  static String _mapDatabaseError(S s, String? code) {
    switch (code) {
      case 'not-found':
        return s.errorDataNotFound;
      case 'permission-denied':
        return s.errorPermissionDenied;
      default:
        return s.errorSaveFailed;
    }
  }
}
