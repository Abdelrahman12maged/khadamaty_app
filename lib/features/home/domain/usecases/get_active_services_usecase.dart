import 'package:dartz/dartz.dart';
import 'package:khadamaty_app/features/provider/domain/entities/service_entity.dart';
import 'package:khadamaty_app/features/provider/domain/repositories/service_repository.dart';
import '../../../../core/error/failures.dart';

/// Use case for getting active services (optionally filtered by category)
class GetActiveServicesUseCase {
  final ServiceRepository _repository;

  GetActiveServicesUseCase({required ServiceRepository repository})
      : _repository = repository;

  /// Execute getting active services
  Future<Either<Failure, List<ServiceEntity>>> call({
    String? category,
    String? searchQuery,
  }) async {
    return await _repository.getActiveServices(
      category: category,
      searchQuery: searchQuery,
    );
  }
}
