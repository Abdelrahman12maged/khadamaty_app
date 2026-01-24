import 'package:dartz/dartz.dart';
import 'package:khadamaty_app/core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/repositories/booking_repository.dart';
import '../datasources/booking_remote_data_source.dart';

class FirebaseBookingRepositoryImp implements BookingRepository {
  final BookingRemoteDataSource _remoteDataSource;

  FirebaseBookingRepositoryImp(
      {required BookingRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, void>> createBooking(BookingEntity booking) async {
    try {
      await _remoteDataSource.createBooking(booking);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookingEntity>>> getUserBookings(
      String userId) async {
    try {
      final models = await _remoteDataSource.getUserBookings(userId);
      return Right(models);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookingEntity>>> getProviderBookings(
      String providerId) async {
    try {
      final models = await _remoteDataSource.getProviderBookings(providerId);
      return Right(models);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateBookingStatus(
      String bookingId, BookingStatus status) async {
    try {
      await _remoteDataSource.updateBookingStatus(bookingId, status);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }
}
