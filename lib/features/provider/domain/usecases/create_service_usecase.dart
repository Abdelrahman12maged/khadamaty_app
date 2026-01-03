import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/service_entity.dart';
import '../repositories/service_repository.dart';

/// Use case for creating a new service
class CreateServiceUseCase {
  final ServiceRepository _repository;

  CreateServiceUseCase({required ServiceRepository repository})
      : _repository = repository;

  /// Execute service creation
  /// Returns Either<Failure, ServiceEntity>
  Future<Either<Failure, ServiceEntity>> call(ServiceEntity service) async {
    return await _repository.createService(service);
  }
}
