import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/service_entity.dart';
import '../repositories/service_repository.dart';

/// Use case for getting provider's services
class GetProviderServicesUseCase {
  final ServiceRepository _repository;

  GetProviderServicesUseCase({required ServiceRepository repository})
      : _repository = repository;

  /// Execute - get all services for a provider
  /// Returns Either<Failure, List<ServiceEntity>>
  Future<Either<Failure, List<ServiceEntity>>> call(String providerId) async {
    return await _repository.getProviderServices(providerId);
  }

  /// Watch provider services in real-time
  Stream<List<ServiceEntity>> watch(String providerId) {
    return _repository.watchProviderServices(providerId);
  }
}
