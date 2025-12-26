import 'package:equatable/equatable.dart';
import '../../../../home/presentation/cubits/home_cubit/home_state.dart';

/// Service status enum
enum ServiceStatus {
  active,
  inactive,
  pending,
}

/// My Services state
class MyServicesState extends Equatable {
  final List<ServiceData> myServices;
  final bool isLoading;
  final String? error;

  const MyServicesState({
    this.myServices = const [],
    this.isLoading = false,
    this.error,
  });

  MyServicesState copyWith({
    List<ServiceData>? myServices,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return MyServicesState(
      myServices: myServices ?? this.myServices,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [myServices, isLoading, error];
}
