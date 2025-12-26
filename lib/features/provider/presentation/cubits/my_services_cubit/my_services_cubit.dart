import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'my_services_state.dart';
import 'mock_my_services_data.dart';

/// My Services cubit for managing user's services
class MyServicesCubit extends Cubit<MyServicesState> {
  MyServicesCubit() : super(const MyServicesState());

  /// Load my services
  Future<void> loadMyServices(BuildContext context) async {
    try {
      emit(state.copyWith(isLoading: true, clearError: true));

      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Load mock data
      final services = MockMyServicesData.getMyServices(context);

      emit(state.copyWith(
        myServices: services,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to load services: ${e.toString()}',
      ));
    }
  }

  /// Refresh services
  Future<void> refreshServices(BuildContext context) async {
    await loadMyServices(context);
  }

  /// Add new service (placeholder)
  Future<void> addService() async {
    // TODO: Implement add service
    // Will be handled in Add Service Form
  }

  /// Delete service
  Future<void> deleteService(String serviceId) async {
    try {
      emit(state.copyWith(isLoading: true));

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

      // Remove from list
      final updatedServices =
          state.myServices.where((service) => service.id != serviceId).toList();

      emit(state.copyWith(
        myServices: updatedServices,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to delete service: ${e.toString()}',
      ));
    }
  }

  /// Toggle service active status
  Future<void> toggleServiceStatus(String serviceId) async {
    try {
      // TODO: Implement toggle status
      // For now, just reload
      await Future.delayed(const Duration(milliseconds: 300));
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to update status: ${e.toString()}',
      ));
    }
  }
}
