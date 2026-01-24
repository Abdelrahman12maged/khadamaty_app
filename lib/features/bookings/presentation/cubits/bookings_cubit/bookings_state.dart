import 'package:equatable/equatable.dart';
import 'package:khadamaty_app/features/bookings/domain/entities/booking_entity.dart';

/// Bookings page state
class BookingsState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<BookingEntity> allBookings;
  final List<BookingEntity> upcomingBookings;
  final List<BookingEntity> pastBookings;
  final List<BookingEntity> cancelledBookings;

  const BookingsState({
    this.isLoading = false,
    this.error,
    this.allBookings = const [],
    this.upcomingBookings = const [],
    this.pastBookings = const [],
    this.cancelledBookings = const [],
  });

  BookingsState copyWith({
    bool? isLoading,
    String? error,
    bool clearError = false,
    List<BookingEntity>? allBookings,
    List<BookingEntity>? upcomingBookings,
    List<BookingEntity>? pastBookings,
    List<BookingEntity>? cancelledBookings,
  }) {
    return BookingsState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      allBookings: allBookings ?? this.allBookings,
      upcomingBookings: upcomingBookings ?? this.upcomingBookings,
      pastBookings: pastBookings ?? this.pastBookings,
      cancelledBookings: cancelledBookings ?? this.cancelledBookings,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        allBookings,
        upcomingBookings,
        pastBookings,
        cancelledBookings,
      ];
}
