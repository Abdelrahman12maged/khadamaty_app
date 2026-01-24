import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/booking_entity.dart';

abstract class BookingRepository {
  Future<Either<Failure, void>> createBooking(BookingEntity booking);
  Future<Either<Failure, List<BookingEntity>>> getUserBookings(String userId);
  Future<Either<Failure, List<BookingEntity>>> getProviderBookings(
      String providerId);
  Future<Either<Failure, void>> updateBookingStatus(
      String bookingId, BookingStatus status);
}
