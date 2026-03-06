import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamaty_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:khadamaty_app/features/bookings/domain/entities/booking_entity.dart';
import 'package:khadamaty_app/features/bookings/domain/usecases/get_provider_bookings_usecase.dart';
import 'package:khadamaty_app/features/bookings/domain/usecases/update_booking_status_usecase.dart';
import 'provider_bookings_state.dart';

/// Cubit for managing provider-side bookings (incoming requests)
class ProviderBookingsCubit extends Cubit<ProviderBookingsState> {
  final GetProviderBookingsUseCase _getProviderBookingsUseCase;
  final UpdateBookingStatusUseCase _updateBookingStatusUseCase;
  final AuthRepository _authRepository;

  ProviderBookingsCubit({
    required GetProviderBookingsUseCase getProviderBookingsUseCase,
    required UpdateBookingStatusUseCase updateBookingStatusUseCase,
    required AuthRepository authRepository,
  })  : _getProviderBookingsUseCase = getProviderBookingsUseCase,
        _updateBookingStatusUseCase = updateBookingStatusUseCase,
        _authRepository = authRepository,
        super(const ProviderBookingsState());

  /// Load all bookings for the current provider
  Future<void> loadBookings() async {
    final user = _authRepository.currentUser;
    if (user == null) {
      emit(state.copyWith(
        isLoading: false,
        error: 'يجب تسجيل الدخول لعرض الحجوزات',
      ));
      return;
    }

    try {
      emit(state.copyWith(isLoading: true, clearError: true));

      final result = await _getProviderBookingsUseCase(user.id);

      result.fold(
        (failure) => emit(state.copyWith(
          isLoading: false,
          error: failure.message,
        )),
        (bookings) {
          final filtered = _filterBookings(bookings);
          emit(state.copyWith(
            isLoading: false,
            allBookings: bookings,
            upcomingBookings: filtered['upcoming']!,
            pastBookings: filtered['past']!,
            cancelledBookings: filtered['cancelled']!,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'فشل تحميل الحجوزات: ${e.toString()}',
      ));
    }
  }

  /// Accept a pending booking
  Future<void> acceptBooking(String bookingId) async {
    final result = await _updateBookingStatusUseCase(
      bookingId: bookingId,
      status: BookingStatus.confirmed,
    );

    result.fold(
      (failure) => emit(state.copyWith(error: failure.message)),
      (_) => loadBookings(), // Reload to reflect updated status
    );
  }

  /// Decline a pending booking
  Future<void> declineBooking(String bookingId) async {
    final result = await _updateBookingStatusUseCase(
      bookingId: bookingId,
      status: BookingStatus.declined,
    );

    result.fold(
      (failure) => emit(state.copyWith(error: failure.message)),
      (_) => loadBookings(),
    );
  }

  /// Refresh bookings
  Future<void> refreshBookings() async {
    await loadBookings();
  }

  /// Filter bookings by status and date
  Map<String, List<BookingEntity>> _filterBookings(
      List<BookingEntity> bookings) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final upcoming = <BookingEntity>[];
    final past = <BookingEntity>[];
    final cancelled = <BookingEntity>[];

    for (final booking in bookings) {
      final bookingDay = DateTime(
        booking.bookingDate.year,
        booking.bookingDate.month,
        booking.bookingDate.day,
      );

      if (booking.status == BookingStatus.cancelled ||
          booking.status == BookingStatus.declined) {
        cancelled.add(booking);
      } else if (booking.status == BookingStatus.completed) {
        past.add(booking);
      } else if (bookingDay.isAfter(today) ||
          bookingDay.isAtSameMomentAs(today)) {
        if (booking.status == BookingStatus.pending ||
            booking.status == BookingStatus.confirmed) {
          upcoming.add(booking);
        }
      } else {
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
