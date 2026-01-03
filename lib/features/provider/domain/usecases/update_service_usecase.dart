import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/service_entity.dart';
import '../repositories/service_repository.dart';

/// Use case for updating an existing service
class UpdateServiceUseCase {
  final ServiceRepository _repository;

  UpdateServiceUseCase({required ServiceRepository repository})
      : _repository = repository;

  /// Execute service update
  /// Returns Either<Failure, ServiceEntity>
  Future<Either<Failure, ServiceEntity>> call(ServiceEntity service) async {
    return await _repository.updateService(service);
  }
}
