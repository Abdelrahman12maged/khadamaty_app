import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/service_repository.dart';

/// Use case for toggling service active status
class ToggleServiceStatusUseCase {
  final ServiceRepository _repository;

  ToggleServiceStatusUseCase({required ServiceRepository repository})
      : _repository = repository;

  /// Execute status toggle
  /// Returns Either<Failure, void>
  Future<Either<Failure, void>> call({
    required String serviceId,
    required bool isActive,
  }) async {
    return await _repository.toggleServiceStatus(serviceId, isActive);
  }
}
