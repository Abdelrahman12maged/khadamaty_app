import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../../domain/entities/user_entity.dart';

/// Interface for Auth Remote Data Source
abstract class AuthRemoteDataSource {
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<void> logout();

  UserEntity? get currentUser;

  Stream<UserEntity?> get authStateChanges;

  Future<void> sendEmailVerification();

  Future<bool> isEmailVerified();

  Future<UserEntity?> reloadUser();

  Future<void> sendPasswordResetEmail(String email);
}

/// Implementation of AuthRemoteDataSource using Firebase
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthRemoteDataSourceImpl({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw const AuthException('Registration failed: No user returned');
      }

      // Update display name
      try {
        await credential.user!.updateDisplayName(name);
      } catch (e) {
        // Ignore updateDisplayName error
      }

      return UserModel(
        id: credential.user!.uid,
        email: email,
        name: name,
        isEmailVerified: false,
        createdAt: DateTime.now(),
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Registration failed', e.code);
    }
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw const AuthException('Login failed: No user returned');
      }

      return UserModel(
        id: credential.user!.uid,
        email: credential.user!.email ?? email,
        name: credential.user!.displayName ?? '',
        isEmailVerified: credential.user!.emailVerified,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Login failed', e.code);
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  UserEntity? get currentUser {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;

    return UserEntity(
      id: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
      isEmailVerified: user.emailVerified,
    );
  }

  @override
  Stream<UserEntity?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((user) {
      if (user == null) return null;
      return UserEntity(
        id: user.uid,
        email: user.email ?? '',
        name: user.displayName ?? '',
        isEmailVerified: user.emailVerified,
      );
    });
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = _firebaseAuth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  @override
  Future<bool> isEmailVerified() async {
    await _firebaseAuth.currentUser?.reload();
    return _firebaseAuth.currentUser?.emailVerified ?? false;
  }

  @override
  Future<UserEntity?> reloadUser() async {
    await _firebaseAuth.currentUser?.reload();
    return currentUser;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Unknown error', e.code);
    }
  }
}

class AuthException implements Exception {
  final String message;
  final String? code;
  const AuthException(this.message, [this.code]);
  @override
  String toString() => message;
}
