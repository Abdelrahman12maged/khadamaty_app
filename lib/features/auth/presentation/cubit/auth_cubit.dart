import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';
import '../../data/models/user_model.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      emit(const AuthLoading());

      // TODO: Implement actual login logic with API
      await Future.delayed(const Duration(seconds: 2)); // Simulating API call

      // Mock user data
      const user = UserModel(
        id: '1',
        email: 'user@example.com',
        name: 'John Doe',
      );

      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> register({
    required String name,
    required String phone, // NEW
    required String email,
    required String password,
  }) async {
    try {
      emit(const AuthLoading());

      // TODO: Implement actual registration logic with API
      await Future.delayed(const Duration(seconds: 2)); // Simulating API call

      // Mock user data
      final user = UserModel(
        id: '1',
        email: email,
        name: name,
        phoneNumber: phone, // NEW
        createdAt: DateTime.now(), // NEW
      );

      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      emit(const AuthLoading());

      // TODO: Implement actual logout logic
      await Future.delayed(const Duration(seconds: 1));

      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  void reset() {
    emit(const AuthInitial());
  }
}
