import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamaty_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:khadamaty_app/features/bookings/domain/entities/booking_entity.dart';
import 'package:khadamaty_app/features/bookings/domain/usecases/get_user_bookings_usecase.dart';
import 'bookings_state.dart';


/// Bookings cubit for managing real bookings data from Firestore
class BookingsCubit extends Cubit<BookingsState> {
  final GetUserBookingsUseCase _getUserBookingsUseCase;
  final AuthRepository _authRepository;

  BookingsCubit({
    required GetUserBookingsUseCase getUserBookingsUseCase,
    required AuthRepository authRepository,
  })  : _getUserBookingsUseCase = getUserBookingsUseCase,
        _authRepository = authRepository,
        super(const BookingsState());

  /// Load all bookings for the current user and filter them
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

      final result = await _getUserBookingsUseCase(user.id);

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

      if (booking.status == BookingStatus.cancelled) {
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
