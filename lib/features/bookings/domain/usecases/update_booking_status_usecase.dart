import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/booking_entity.dart';
import '../repositories/booking_repository.dart';

class UpdateBookingStatusUseCase {
  final BookingRepository _repository;

  UpdateBookingStatusUseCase({required BookingRepository repository})
      : _repository = repository;

  Future<Either<Failure, void>> call({
    required String bookingId,
    required BookingStatus status,
  }) async {
    return await _repository.updateBookingStatus(bookingId, status);
  }
}
