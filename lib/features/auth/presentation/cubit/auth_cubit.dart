import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/verify_email_usecase.dart';
import '../../domain/usecases/reset_password_usecase.dart';

/// Auth Cubit - manages authentication state
/// All usecases are injected via DI
class AuthCubit extends Cubit<AuthState> {
  final RegisterUseCase _registerUseCase;
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final VerifyEmailUseCase _verifyEmailUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  AuthCubit({
    required RegisterUseCase registerUseCase,
    required LoginUseCase loginUseCase,
    required LogoutUseCase logoutUseCase,
    required VerifyEmailUseCase verifyEmailUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
  })  : _registerUseCase = registerUseCase,
        _loginUseCase = loginUseCase,
        _logoutUseCase = logoutUseCase,
        _verifyEmailUseCase = verifyEmailUseCase,
        _resetPasswordUseCase = resetPasswordUseCase,
        super(const AuthInitial());

  /// Login with email and password
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());

    final result = await _loginUseCase(
      email: email,
      password: password,
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.message, failure: failure)),
      (loginResult) {
        if (!loginResult.isEmailVerified) {
          emit(AuthEmailVerificationPending(user: loginResult.user));
        } else {
          emit(AuthAuthenticated(user: loginResult.user));
        }
      },
    );
  }

  /// Register a new user
  Future<void> register({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());

    final result = await _registerUseCase(
      name: name,
      phone: phone,
      email: email,
      password: password,
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.message, failure: failure)),
      (user) => emit(AuthEmailVerificationPending(user: user)),
    );
  }

  /// Logout the current user
  Future<void> logout() async {
    emit(const AuthLoading());

    final result = await _logoutUseCase();

    result.fold(
      (failure) => emit(AuthError(message: failure.message, failure: failure)),
      (_) => emit(const AuthUnauthenticated()),
    );
  }

  /// Resend email verification
  Future<void> resendEmailVerification() async {
    final result = await _verifyEmailUseCase.resendVerificationEmail();

    result.fold(
      (failure) => emit(AuthError(message: failure.message, failure: failure)),
      (_) {
        // Success - no state change needed, just show snackbar
      },
    );
  }

  /// Check if email is verified and update state
  Future<void> checkEmailVerification() async {
    emit(const AuthLoading());

    final result = await _verifyEmailUseCase();

    result.fold(
      (failure) => emit(AuthError(message: failure.message, failure: failure)),
      (verificationResult) {
        if (verificationResult.isVerified && verificationResult.user != null) {
          emit(AuthAuthenticated(user: verificationResult.user!));
        } else if (verificationResult.user != null) {
          emit(AuthEmailVerificationPending(user: verificationResult.user!));
        } else {
          emit(const AuthUnauthenticated());
        }
      },
    );
  }

  /// Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    emit(const AuthLoading());

    final result = await _resetPasswordUseCase(email);

    result.fold(
      (failure) => emit(AuthError(message: failure.message, failure: failure)),
      (_) => emit(const AuthInitial()),
    );
  }

  /// Reset state
  void reset() {
    emit(const AuthInitial());
  }
}
