import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../auth/domain/repositories/auth_repository.dart';
import '../../../../provider/domain/entities/service_entity.dart';
import '../../../domain/entities/booking_entity.dart';
import '../../../domain/usecases/create_booking_usecase.dart';
import 'create_booking_state.dart';

class CreateBookingCubit extends Cubit<CreateBookingState> {
  final CreateBookingUseCase _createBookingUseCase;
  final AuthRepository _authRepository;

  CreateBookingCubit({
    required CreateBookingUseCase createBookingUseCase,
    required AuthRepository authRepository,
  })  : _createBookingUseCase = createBookingUseCase,
        _authRepository = authRepository,
        super(const CreateBookingState());

  void selectDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  void selectTime(String time) {
    emit(state.copyWith(selectedTime: time));
  }

  Future<void> confirmBooking({
    required ServiceEntity service,
    String? notes,
    String? address,
  }) async {
    if (state.selectedDate == null || state.selectedTime == null) {
      emit(state.copyWith(
        status: CreateBookingStatus.error,
        errorMessage: 'يرجى اختيار التاريخ والوقت',
      ));
      return;
    }

    final user = _authRepository.currentUser;
    if (user == null) {
      emit(state.copyWith(
        status: CreateBookingStatus.error,
        errorMessage: 'يجب تسجيل الدخول لإتمام الحجز',
      ));
      return;
    }

    // Prevent self-booking
    if (user.id == service.providerId) {
      emit(state.copyWith(
        status: CreateBookingStatus.error,
        errorMessage: 'لا يمكنك حجز خدمتك الخاصة',
      ));
      return;
    }

    emit(state.copyWith(status: CreateBookingStatus.loading));

    // Combine date and time
    final bookingDateTime = DateTime(
      state.selectedDate!.year,
      state.selectedDate!.month,
      state.selectedDate!.day,
      // Parse time (e.g. "10:00 AM") - basic parser
      _parseHour(state.selectedTime!),
      _parseMinute(state.selectedTime!),
    );

    final booking = BookingEntity(
      id: '',
      serviceId: service.id,
      serviceName: service.title,
      providerId: service.providerId,
      providerName: service.providerName,
      customerId: user.id,
      bookingDate: bookingDateTime,
      createdAt: DateTime.now(),
      status: BookingStatus.pending,
      totalPrice: service.price,
      notes: notes,
      address: address ?? service.location.address,
    );

    final result = await _createBookingUseCase(booking);

    result.fold(
      (failure) => emit(state.copyWith(
        status: CreateBookingStatus.error,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(status: CreateBookingStatus.success)),
    );
  }

  int _parseHour(String timeStr) {
    // Basic parser for "HH:mm AM/PM" or "HH:mm"
    try {
      final parts = timeStr.split(':');
      var hour = int.parse(parts[0]);
      if (timeStr.toLowerCase().contains('pm') && hour < 12) hour += 12;
      if (timeStr.toLowerCase().contains('am') && hour == 12) hour = 0;
      return hour;
    } catch (_) {
      return 12;
    }
  }

  int _parseMinute(String timeStr) {
    try {
      final parts = timeStr.split(':');
      final minutePart = parts[1].split(' ')[0];
      return int.parse(minutePart);
    } catch (_) {
      return 0;
    }
  }
}
