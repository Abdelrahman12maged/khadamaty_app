import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/service_entity.dart';
import '../../domain/repositories/i_service_repository.dart';
import '../models/service_model.dart';

/// Firebase implementation of IServiceRepository
class FirebaseServiceRepository implements IServiceRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  FirebaseServiceRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _servicesCollection =>
      _firestore.collection('services');

  /// Get current user ID
  String? get currentUserId => _auth.currentUser?.uid;

  @override
  Future<Either<Failure, ServiceEntity>> createService(
      ServiceEntity service) async {
    try {
      final model = ServiceModel.fromEntity(service);
      final docRef = await _servicesCollection.add(model.toFirestore());

      // Return with generated ID
      final created = service.copyWith(id: docRef.id);
      return Right(created);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ServiceEntity>> updateService(
      ServiceEntity service) async {
    try {
      final model = ServiceModel.fromEntity(service.copyWith(
        updatedAt: DateTime.now(),
      ));

      await _servicesCollection.doc(service.id).update(model.toFirestore());
      return Right(service);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteService(String serviceId) async {
    try {
      await _servicesCollection.doc(serviceId).delete();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ServiceEntity>> getServiceById(
      String serviceId) async {
    try {
      final doc = await _servicesCollection.doc(serviceId).get();
      if (!doc.exists) {
        return Left(ServerFailure(message: 'Service not found'));
      }
      return Right(ServiceModel.fromFirestore(doc));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ServiceEntity>>> getProviderServices(
      String providerId) async {
    try {
      final snapshot = await _servicesCollection
          .where('providerId', isEqualTo: providerId)
          .orderBy('createdAt', descending: true)
          .get();

      final services =
          snapshot.docs.map((doc) => ServiceModel.fromFirestore(doc)).toList();
      return Right(services);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ServiceEntity>>> getActiveServices({
    String? category,
    String? searchQuery,
    double? latitude,
    double? longitude,
    double? radiusKm,
  }) async {
    try {
      Query<Map<String, dynamic>> query =
          _servicesCollection.where('isActive', isEqualTo: true);

      if (category != null && category.isNotEmpty) {
        query = query.where('category', isEqualTo: category);
      }

      final snapshot = await query.orderBy('rating', descending: true).get();

      List<ServiceEntity> services =
          snapshot.docs.map((doc) => ServiceModel.fromFirestore(doc)).toList();

      // Client-side search filtering (Firestore doesn't support full-text search)
      if (searchQuery != null && searchQuery.isNotEmpty) {
        final lowerQuery = searchQuery.toLowerCase();
        services = services.where((s) {
          return s.title.toLowerCase().contains(lowerQuery) ||
              s.description.toLowerCase().contains(lowerQuery) ||
              s.category.toLowerCase().contains(lowerQuery);
        }).toList();
      }

      return Right(services);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ServiceEntity>>> getFeaturedServices({
    int limit = 10,
  }) async {
    try {
      final snapshot = await _servicesCollection
          .where('isActive', isEqualTo: true)
          .orderBy('rating', descending: true)
          .limit(limit)
          .get();

      final services =
          snapshot.docs.map((doc) => ServiceModel.fromFirestore(doc)).toList();
      return Right(services);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleServiceStatus(
      String serviceId, bool isActive) async {
    try {
      await _servicesCollection.doc(serviceId).update({
        'isActive': isActive,
        'updatedAt': Timestamp.now(),
      });
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Stream<List<ServiceEntity>> watchProviderServices(String providerId) {
    return _servicesCollection
        .where('providerId', isEqualTo: providerId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ServiceModel.fromFirestore(doc))
            .toList());
  }
}
