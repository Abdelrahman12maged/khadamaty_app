import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

/// Interface for User Remote Data Source
abstract class UserRemoteDataSource {
  Future<void> saveUser(UserEntity user);

  Future<UserModel?> getUser(String uid);

  Future<void> updateUser(String uid, Map<String, dynamic> data);

  Future<bool> userExists(String uid);

  Future<void> updateEmailVerified(String uid, bool verified);

  Stream<UserModel?> userStream(String uid);
}

/// Implementation of UserRemoteDataSource using Firestore
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore _firestore;
  final String _collection = 'users';

  UserRemoteDataSourceImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _usersCollection =>
      _firestore.collection(_collection);

  @override
  Future<void> saveUser(UserEntity user) async {
    try {
      final model = UserModel.fromEntity(user);
      await _usersCollection.doc(user.id).set(model.toFirestore());
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  @override
  Future<UserModel?> getUser(String uid) async {
    try {
      final doc = await _usersCollection.doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return UserModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  @override
  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    try {
      await _usersCollection.doc(uid).update(data);
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  @override
  Future<bool> userExists(String uid) async {
    try {
      final doc = await _usersCollection.doc(uid).get();
      return doc.exists;
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  @override
  Future<void> updateEmailVerified(String uid, bool verified) async {
    try {
      await _usersCollection.doc(uid).update({
        'isEmailVerified': verified,
      });
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  @override
  Stream<UserModel?> userStream(String uid) {
    return _usersCollection.doc(uid).snapshots().map((doc) {
      if (doc.exists && doc.data() != null) {
        return UserModel.fromFirestore(doc);
      }
      return null;
    });
  }
}
