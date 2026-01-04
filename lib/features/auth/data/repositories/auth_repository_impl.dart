import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

/// Firebase implementation of AuthRepository
class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

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
  Future<Either<Failure, UserEntity>> register({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        return Left(
            AuthFailure.unknown('Registration failed: No user returned'));
      }

      // Update display name - wrapped in try-catch due to known Firebase issue
      try {
        await credential.user!.updateDisplayName(name);
      } catch (e) {
        // Ignore updateDisplayName error - name will be stored in Firestore
        // This is a known issue with some firebase_auth versions
      }

      return Right(UserEntity(
        id: credential.user!.uid,
        email: email,
        name: name,
        phoneNumber: phone,
        isEmailVerified: false,
        isPhoneVerified: false,
        createdAt: DateTime.now(),
      ));
    } on FirebaseAuthException catch (e) {
      return Left(_mapFirebaseAuthException(e));
    } catch (e) {
      return Left(AuthFailure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        return Left(AuthFailure.unknown('Login failed: No user returned'));
      }

      return Right(UserEntity(
        id: credential.user!.uid,
        email: credential.user!.email ?? email,
        name: credential.user!.displayName ?? '',
        isEmailVerified: credential.user!.emailVerified,
      ));
    } on FirebaseAuthException catch (e) {
      return Left(_mapFirebaseAuthException(e));
    } catch (e) {
      return Left(AuthFailure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _firebaseAuth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendEmailVerification() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null && !user.emailVerified) {
        // Wrap in try-catch due to known Firebase Pigeon issue
        try {
          await user.sendEmailVerification();
        } catch (e) {
          // Ignore - verification email might fail but shouldn't block flow
          // User can request resend later
        }
      }
      return const Right(null);
    } catch (e) {
      // Return success anyway - email verification is not critical for registration
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, bool>> isEmailVerified() async {
    try {
      // Wrap reload in try-catch due to known Firebase Pigeon issue
      try {
        await _firebaseAuth.currentUser?.reload();
      } catch (e) {
        // Ignore reload error
      }
      return Right(_firebaseAuth.currentUser?.emailVerified ?? false);
    } catch (e) {
      return const Right(false);
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> reloadUser() async {
    try {
      // Wrap reload in try-catch due to known Firebase Pigeon issue
      try {
        await _firebaseAuth.currentUser?.reload();
      } catch (e) {
        // Ignore reload error
      }
      final user = _firebaseAuth.currentUser;

      if (user == null) return const Right(null);

      return Right(UserEntity(
        id: user.uid,
        email: user.email ?? '',
        name: user.displayName ?? '',
        isEmailVerified: user.emailVerified,
      ));
    } catch (e) {
      return Left(AuthFailure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(_mapFirebaseAuthException(e));
    } catch (e) {
      return Left(AuthFailure.unknown(e.toString()));
    }
  }

  /// Map Firebase Auth exceptions to AuthFailure
  AuthFailure _mapFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return AuthFailure.emailAlreadyInUse();
      case 'invalid-email':
        return AuthFailure.invalidEmail();
      case 'weak-password':
        return AuthFailure.weakPassword();
      case 'user-not-found':
        return AuthFailure.userNotFound();
      case 'wrong-password':
        return AuthFailure.wrongPassword();
      case 'user-disabled':
        return AuthFailure.userDisabled();
      case 'too-many-requests':
        return AuthFailure.tooManyRequests();
      default:
        return AuthFailure.unknown(e.message);
    }
  }
}
