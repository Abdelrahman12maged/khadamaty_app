import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/service_model.dart';
import '../../domain/entities/service_entity.dart';
import '../../../../core/error/exceptions.dart';

abstract class ServiceRemoteDataSource {
  Future<String> createService(ServiceEntity service);
  Future<void> updateService(ServiceEntity service);
  Future<void> deleteService(String serviceId);
  Future<ServiceModel> getServiceById(String serviceId);
  Future<List<ServiceModel>> getProviderServices(String providerId);
  Future<List<ServiceModel>> getActiveServices({
    String? category,
    String? searchQuery,
  });
  Future<List<ServiceModel>> getFeaturedServices(int limit);
  Future<void> toggleServiceStatus(String serviceId, bool isActive);
  Stream<List<ServiceModel>> watchProviderServices(String providerId);
}

class ServiceRemoteDataSourceImpl implements ServiceRemoteDataSource {
  final FirebaseFirestore _firestore;

  ServiceRemoteDataSourceImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _servicesCollection =>
      _firestore.collection('services');

  @override
  Future<String> createService(ServiceEntity service) async {
    try {
      final model = ServiceModel.fromEntity(service);
      final docRef = await _servicesCollection.add(model.toFirestore());
      return docRef.id;
    } on FirebaseException catch (e) {
      throw DatabaseException(e.message ?? 'Failed to create service', e.code);
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> updateService(ServiceEntity service) async {
    try {
      final model = ServiceModel.fromEntity(service.copyWith(
        updatedAt: DateTime.now(),
      ));
      await _servicesCollection.doc(service.id).update(model.toFirestore());
    } on FirebaseException catch (e) {
      throw DatabaseException(e.message ?? 'Failed to update service', e.code);
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> deleteService(String serviceId) async {
    try {
      await _servicesCollection.doc(serviceId).delete();
    } on FirebaseException catch (e) {
      throw DatabaseException(e.message ?? 'Failed to delete service', e.code);
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<ServiceModel> getServiceById(String serviceId) async {
    try {
      final doc = await _servicesCollection.doc(serviceId).get();
      if (!doc.exists) {
        throw const DatabaseException('Service not found', 'not-found');
      }
      return ServiceModel.fromFirestore(doc);
    } on FirebaseException catch (e) {
      throw DatabaseException(e.message ?? 'Failed to get service', e.code);
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<ServiceModel>> getProviderServices(String providerId) async {
    try {
      final snapshot = await _servicesCollection
          .where('providerId', isEqualTo: providerId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => ServiceModel.fromFirestore(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw DatabaseException(
          e.message ?? 'Failed to get provider services', e.code);
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<ServiceModel>> getActiveServices({
    String? category,
    String? searchQuery,
  }) async {
    try {
      Query<Map<String, dynamic>> query =
          _servicesCollection.where('isActive', isEqualTo: true);

      if (category != null && category.isNotEmpty) {
        query = query.where('category', isEqualTo: category);
      }

      final snapshot = await query.get();

      List<ServiceModel> services =
          snapshot.docs.map((doc) => ServiceModel.fromFirestore(doc)).toList();

      if (searchQuery != null && searchQuery.isNotEmpty) {
        final lowerQuery = searchQuery.toLowerCase();
        services = services.where((s) {
          return s.title.toLowerCase().contains(lowerQuery) ||
              s.description.toLowerCase().contains(lowerQuery) ||
              s.category.toLowerCase().contains(lowerQuery);
        }).toList();
      }

      return services;
    } on FirebaseException catch (e) {
      throw DatabaseException(
          e.message ?? 'Failed to get active services', e.code);
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<ServiceModel>> getFeaturedServices(int limit) async {
    try {
      final snapshot =
          await _servicesCollection.where('isActive', isEqualTo: true).get();

      final services =
          snapshot.docs.map((doc) => ServiceModel.fromFirestore(doc)).toList();

      services.sort((a, b) => b.rating.compareTo(a.rating));
      return services.take(limit).toList();
    } on FirebaseException catch (e) {
      throw DatabaseException(
          e.message ?? 'Failed to get featured services', e.code);
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> toggleServiceStatus(String serviceId, bool isActive) async {
    try {
      await _servicesCollection.doc(serviceId).update({
        'isActive': isActive,
        'updatedAt': Timestamp.now(),
      });
    } on FirebaseException catch (e) {
      throw DatabaseException(
          e.message ?? 'Failed to toggle service status', e.code);
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Stream<List<ServiceModel>> watchProviderServices(String providerId) {
    return _servicesCollection
        .where('providerId', isEqualTo: providerId)
        .snapshots()
        .map((snapshot) {
      final services =
          snapshot.docs.map((doc) => ServiceModel.fromFirestore(doc)).toList();
      services.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return services;
    });
  }
}
