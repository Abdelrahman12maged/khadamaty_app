import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/verify_email_usecase.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/user_repository_impl.dart';

class AuthCubit extends Cubit<AuthState> {
  final RegisterUseCase _registerUseCase;
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final VerifyEmailUseCase _verifyEmailUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  AuthCubit({
    RegisterUseCase? registerUseCase,
    LoginUseCase? loginUseCase,
    LogoutUseCase? logoutUseCase,
    VerifyEmailUseCase? verifyEmailUseCase,
    ResetPasswordUseCase? resetPasswordUseCase,
  })  : _registerUseCase = registerUseCase ?? _createDefaultRegisterUseCase(),
        _loginUseCase = loginUseCase ?? _createDefaultLoginUseCase(),
        _logoutUseCase = logoutUseCase ?? _createDefaultLogoutUseCase(),
        _verifyEmailUseCase =
            verifyEmailUseCase ?? _createDefaultVerifyEmailUseCase(),
        _resetPasswordUseCase =
            resetPasswordUseCase ?? _createDefaultResetPasswordUseCase(),
        super(const AuthInitial());

  // Factory methods to create default use cases
  static RegisterUseCase _createDefaultRegisterUseCase() {
    return RegisterUseCase(
      authRepository: AuthRepositoryImpl(),
      userRepository: UserRepositoryImpl(),
    );
  }

  static LoginUseCase _createDefaultLoginUseCase() {
    return LoginUseCase(
      authRepository: AuthRepositoryImpl(),
      userRepository: UserRepositoryImpl(),
    );
  }

  static LogoutUseCase _createDefaultLogoutUseCase() {
    return LogoutUseCase(authRepository: AuthRepositoryImpl());
  }

  static VerifyEmailUseCase _createDefaultVerifyEmailUseCase() {
    return VerifyEmailUseCase(
      authRepository: AuthRepositoryImpl(),
      userRepository: UserRepositoryImpl(),
    );
  }

  static ResetPasswordUseCase _createDefaultResetPasswordUseCase() {
    return ResetPasswordUseCase(authRepository: AuthRepositoryImpl());
  }

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
