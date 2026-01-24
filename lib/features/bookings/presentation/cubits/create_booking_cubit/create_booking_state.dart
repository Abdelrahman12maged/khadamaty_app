import 'package:equatable/equatable.dart';

enum CreateBookingStatus { initial, loading, success, error }

class CreateBookingState extends Equatable {
  final CreateBookingStatus status;
  final DateTime? selectedDate;
  final String? selectedTime;
  final String? errorMessage;

  const CreateBookingState({
    this.status = CreateBookingStatus.initial,
    this.selectedDate,
    this.selectedTime,
    this.errorMessage,
  });

  CreateBookingState copyWith({
    CreateBookingStatus? status,
    DateTime? selectedDate,
    String? selectedTime,
    String? errorMessage,
  }) {
    return CreateBookingState(
      status: status ?? this.status,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, selectedDate, selectedTime, errorMessage];
}
