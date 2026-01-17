import 'package:equatable/equatable.dart';

/// Booking status enum
enum BookingStatus {
  pending,
  confirmed,
  completed,
  cancelled,
}

/// Booking data model
class BookingData extends Equatable {
  final String id;
  final String serviceTitle;
  final String providerName;
  final String? imageUrl;
  final DateTime bookingDate;
  final String timeSlot;
  final double price;
  final BookingStatus status;
  final String? address;

  const BookingData({
    required this.id,
    required this.serviceTitle,
    required this.providerName,
    this.imageUrl,
    required this.bookingDate,
    required this.timeSlot,
    required this.price,
    required this.status,
    this.address,
  });

  @override
  List<Object?> get props => [
        id,
        serviceTitle,
        providerName,
        imageUrl,
        bookingDate,
        timeSlot,
        price,
        status,
        address,
      ];
}

/// Bookings page state
class BookingsState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<BookingData> allBookings;
  final List<BookingData> upcomingBookings;
  final List<BookingData> pastBookings;
  final List<BookingData> cancelledBookings;

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
    List<BookingData>? allBookings,
    List<BookingData>? upcomingBookings,
    List<BookingData>? pastBookings,
    List<BookingData>? cancelledBookings,
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
