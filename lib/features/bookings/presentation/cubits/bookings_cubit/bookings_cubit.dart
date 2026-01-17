import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bookings_state.dart';
import 'mock_bookings_data.dart';

/// Bookings cubit for managing bookings data
class BookingsCubit extends Cubit<BookingsState> {
  BookingsCubit() : super(const BookingsState());

  /// Load all bookings and filter by status
  Future<void> loadBookings(BuildContext context) async {
    try {
      emit(state.copyWith(isLoading: true, clearError: true));

      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Load mock data
      final bookings = MockBookingsData.getBookings(context);

      // Filter bookings by status
      final filtered = _filterBookings(bookings);

      emit(state.copyWith(
        isLoading: false,
        allBookings: bookings,
        upcomingBookings: filtered['upcoming']!,
        pastBookings: filtered['past']!,
        cancelledBookings: filtered['cancelled']!,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to load bookings: ${e.toString()}',
      ));
    }
  }

  /// Refresh bookings (pull-to-refresh)
  Future<void> refreshBookings(BuildContext context) async {
    await loadBookings(context);
  }

  /// Filter bookings by status and date
  Map<String, List<BookingData>> _filterBookings(List<BookingData> bookings) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final upcoming = <BookingData>[];
    final past = <BookingData>[];
    final cancelled = <BookingData>[];

    for (final booking in bookings) {
      final bookingDay = DateTime(
        booking.bookingDate.year,
        booking.bookingDate.month,
        booking.bookingDate.day,
      );

      if (booking.status == BookingStatus.cancelled) {
        // All cancelled bookings
        cancelled.add(booking);
      } else if (booking.status == BookingStatus.completed) {
        // Completed bookings go to past
        past.add(booking);
      } else if (bookingDay.isAfter(today) ||
          bookingDay.isAtSameMomentAs(today)) {
        // Pending/Confirmed bookings with future or today date
        if (booking.status == BookingStatus.pending ||
            booking.status == BookingStatus.confirmed) {
          upcoming.add(booking);
        }
      } else {
        // Past date with pending/confirmed status -> still goes to past
        past.add(booking);
      }
    }

    // Sort upcoming by date (earliest first)
    upcoming.sort((a, b) => a.bookingDate.compareTo(b.bookingDate));

    // Sort past by date (most recent first)
    past.sort((a, b) => b.bookingDate.compareTo(a.bookingDate));

    // Sort cancelled by date (most recent first)
    cancelled.sort((a, b) => b.bookingDate.compareTo(a.bookingDate));

    return {
      'upcoming': upcoming,
      'past': past,
      'cancelled': cancelled,
    };
  }
}
