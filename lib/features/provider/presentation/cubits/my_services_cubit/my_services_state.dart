import 'package:equatable/equatable.dart';
import '../../../domain/entities/service_entity.dart';

/// My Services state
class MyServicesState extends Equatable {
  final List<ServiceEntity> myServices;
  final bool isLoading;
  final String? error;

  const MyServicesState({
    this.myServices = const [],
    this.isLoading = false,
    this.error,
  });

  /// Check if list is empty
  bool get isEmpty => myServices.isEmpty && !isLoading;

  /// Get active services count
  int get activeCount => myServices.where((s) => s.isActive).length;

  MyServicesState copyWith({
    List<ServiceEntity>? myServices,
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
