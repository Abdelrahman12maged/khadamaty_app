import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/service_entity.dart';

/// Abstract repository interface for services
/// Data layer will implement this interface (Firebase, Supabase, etc.)
abstract class IServiceRepository {
  /// Create a new service
  Future<Either<Failure, ServiceEntity>> createService(ServiceEntity service);

  /// Update an existing service
  Future<Either<Failure, ServiceEntity>> updateService(ServiceEntity service);

  /// Delete a service
  Future<Either<Failure, void>> deleteService(String serviceId);

  /// Get service by ID
  Future<Either<Failure, ServiceEntity>> getServiceById(String serviceId);

  /// Get all services for a provider
  Future<Either<Failure, List<ServiceEntity>>> getProviderServices(
      String providerId);

  /// Get all active services (for explore/search)
  Future<Either<Failure, List<ServiceEntity>>> getActiveServices({
    String? category,
    String? searchQuery,
    double? latitude,
    double? longitude,
    double? radiusKm,
  });

  /// Get featured services for home screen
  Future<Either<Failure, List<ServiceEntity>>> getFeaturedServices(
      {int limit = 10});

  /// Toggle service active status
  Future<Either<Failure, void>> toggleServiceStatus(
      String serviceId, bool isActive);

  /// Stream of provider's services (real-time updates)
  Stream<List<ServiceEntity>> watchProviderServices(String providerId);
}
