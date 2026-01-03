import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/service_repository.dart';

/// Use case for deleting a service
class DeleteServiceUseCase {
  final ServiceRepository _repository;

  DeleteServiceUseCase({required ServiceRepository repository})
      : _repository = repository;

  /// Execute service deletion
  /// Returns Either<Failure, void>
  Future<Either<Failure, void>> call(String serviceId) async {
    return await _repository.deleteService(serviceId);
  }
}
