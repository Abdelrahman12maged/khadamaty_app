import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/service_entity.dart';
import '../../domain/repositories/service_repository.dart';
import '../datasources/service_remote_data_source.dart';

/// Firebase implementation of ServiceRepository
class FirebaseServiceRepository implements ServiceRepository {
  final ServiceRemoteDataSource _remoteDataSource;

  FirebaseServiceRepository({
    required ServiceRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, ServiceEntity>> createService(
      ServiceEntity service) async {
    try {
      final generatedId = await _remoteDataSource.createService(service);
      final created = service.copyWith(id: generatedId);
      return Right(created);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ServiceEntity>> updateService(
      ServiceEntity service) async {
    try {
      await _remoteDataSource.updateService(service);
      return Right(service);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteService(String serviceId) async {
    try {
      await _remoteDataSource.deleteService(serviceId);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ServiceEntity>> getServiceById(
      String serviceId) async {
    try {
      final service = await _remoteDataSource.getServiceById(serviceId);
      return Right(service);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ServiceEntity>>> getProviderServices(
      String providerId) async {
    try {
      final services = await _remoteDataSource.getProviderServices(providerId);
      return Right(services);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message, code: e.code));
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
      final services = await _remoteDataSource.getActiveServices(
        category: category,
        searchQuery: searchQuery,
      );

      // Client-side sort if needed
      final sortedServices = List<ServiceEntity>.from(services);
      sortedServices.sort((a, b) => b.rating.compareTo(a.rating));

      return Right(sortedServices);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ServiceEntity>>> getFeaturedServices({
    int limit = 10,
  }) async {
    try {
      final services = await _remoteDataSource.getFeaturedServices(limit);
      return Right(services);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleServiceStatus(
      String serviceId, bool isActive) async {
    try {
      await _remoteDataSource.toggleServiceStatus(serviceId, isActive);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Stream<List<ServiceEntity>> watchProviderServices(String providerId) {
    return _remoteDataSource.watchProviderServices(providerId);
  }
}
