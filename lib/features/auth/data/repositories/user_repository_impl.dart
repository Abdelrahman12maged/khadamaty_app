import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/i_user_repository.dart';
import '../models/user_model.dart';

/// Firestore implementation of IUserRepository
class UserRepositoryImpl implements IUserRepository {
  final FirebaseFirestore _firestore;
  final String _collection = 'users';

  UserRepositoryImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Reference to users collection
  CollectionReference<Map<String, dynamic>> get _usersCollection =>
      _firestore.collection(_collection);

  @override
  Future<Either<Failure, void>> saveUser(UserEntity user) async {
    try {
      final model = UserModel.fromEntity(user);
      await _usersCollection.doc(user.id).set(model.toJson());
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'Failed to save user'));
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getUser(String uid) async {
    try {
      final doc = await _usersCollection.doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return Right(UserModel.fromJson(doc.data()!).toEntity());
      }
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'Failed to get user'));
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateUser(
      String uid, Map<String, dynamic> data) async {
    try {
      await _usersCollection.doc(uid).update(data);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(
          DatabaseFailure(message: e.message ?? 'Failed to update user'));
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> userExists(String uid) async {
    try {
      final doc = await _usersCollection.doc(uid).get();
      return Right(doc.exists);
    } on FirebaseException catch (e) {
      return Left(
          DatabaseFailure(message: e.message ?? 'Failed to check user'));
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateEmailVerified(
      String uid, bool verified) async {
    try {
      await _usersCollection.doc(uid).update({
        'isEmailVerified': verified,
      });
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(
          message: e.message ?? 'Failed to update email verification'));
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Stream<UserEntity?> userStream(String uid) {
    return _usersCollection.doc(uid).snapshots().map((doc) {
      if (doc.exists && doc.data() != null) {
        return UserModel.fromJson(doc.data()!).toEntity();
      }
      return null;
    });
  }
}
