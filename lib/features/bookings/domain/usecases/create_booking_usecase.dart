import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/booking_entity.dart';
import '../repositories/booking_repository.dart';

class CreateBookingUseCase {
  final BookingRepository _repository;

  CreateBookingUseCase( {required BookingRepository repository})
      : _repository = repository;

  Future<Either<Failure, void>> call(BookingEntity booking) async {
    return await _repository.createBooking(booking);
  }
}
