import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../provider/domain/entities/service_entity.dart';
import '../../../provider/domain/repositories/service_repository.dart';

/// Use case for getting a single service by its ID
class GetServiceByIdUseCase {
  final ServiceRepository _repository;

  GetServiceByIdUseCase({required ServiceRepository repository})
      : _repository = repository;

  Future<Either<Failure, ServiceEntity>> call(String serviceId) async {
    return await _repository.getServiceById(serviceId);
  }
}
