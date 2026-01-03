import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/service_entity.dart';
import '../../../domain/usecases/get_provider_services_usecase.dart';
import '../../../domain/usecases/delete_service_usecase.dart';
import '../../../domain/usecases/toggle_service_status_usecase.dart';
import 'my_services_state.dart';

/// My Services cubit for managing provider's services
class MyServicesCubit extends Cubit<MyServicesState> {
  final GetProviderServicesUseCase _getProviderServicesUseCase;
  final DeleteServiceUseCase _deleteServiceUseCase;
  final ToggleServiceStatusUseCase _toggleServiceStatusUseCase;
  final FirebaseAuth _auth;

  StreamSubscription<List<ServiceEntity>>? _subscription;

  MyServicesCubit({
    required GetProviderServicesUseCase getProviderServicesUseCase,
    required DeleteServiceUseCase deleteServiceUseCase,
    required ToggleServiceStatusUseCase toggleServiceStatusUseCase,
    FirebaseAuth? auth,
  })  : _getProviderServicesUseCase = getProviderServicesUseCase,
        _deleteServiceUseCase = deleteServiceUseCase,
        _toggleServiceStatusUseCase = toggleServiceStatusUseCase,
        _auth = auth ?? FirebaseAuth.instance,
        super(const MyServicesState());

  /// Get current user ID
  String? get _currentUserId => _auth.currentUser?.uid;

  /// Load my services (one-time fetch)
  Future<void> loadMyServices() async {
    if (_currentUserId == null) {
      emit(state.copyWith(error: 'User not authenticated'));
      return;
    }

    try {
      emit(state.copyWith(isLoading: true, clearError: true));

      final result = await _getProviderServicesUseCase(_currentUserId!);

      result.fold(
        (failure) => emit(state.copyWith(
          isLoading: false,
          error: failure.message,
        )),
        (services) => emit(state.copyWith(
          myServices: services,
          isLoading: false,
        )),
      );
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to load services: ${e.toString()}',
      ));
    }
  }

  /// Watch my services (real-time updates)
  void watchMyServices() {
    if (_currentUserId == null) {
      emit(state.copyWith(error: 'User not authenticated'));
      return;
    }

    emit(state.copyWith(isLoading: true, clearError: true));

    _subscription?.cancel();
    _subscription = _getProviderServicesUseCase.watch(_currentUserId!).listen(
      (services) {
        emit(state.copyWith(
          myServices: services,
          isLoading: false,
        ));
      },
      onError: (error) {
        emit(state.copyWith(
          isLoading: false,
          error: 'Failed to load services: $error',
        ));
      },
    );
  }

  /// Refresh services
  Future<void> refreshServices() async {
    await loadMyServices();
  }

  /// Delete service
  Future<bool> deleteService(String serviceId) async {
    try {
      emit(state.copyWith(isLoading: true));

      final result = await _deleteServiceUseCase(serviceId);

      return result.fold(
        (failure) {
          emit(state.copyWith(
            isLoading: false,
            error: failure.message,
          ));
          return false;
        },
        (_) {
          // Remove from local list
          final updatedServices = state.myServices
              .where((service) => service.id != serviceId)
              .toList();

          emit(state.copyWith(
            myServices: updatedServices,
            isLoading: false,
          ));
          return true;
        },
      );
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to delete service: ${e.toString()}',
      ));
      return false;
    }
  }

  /// Toggle service active status
  Future<bool> toggleServiceStatus(String serviceId, bool isActive) async {
    try {
      final result = await _toggleServiceStatusUseCase(
        serviceId: serviceId,
        isActive: isActive,
      );

      return result.fold(
        (failure) {
          emit(state.copyWith(error: failure.message));
          return false;
        },
        (_) {
          // Update local list
          final updatedServices = state.myServices.map((service) {
            if (service.id == serviceId) {
              return service.copyWith(isActive: isActive);
            }
            return service;
          }).toList();

          emit(state.copyWith(myServices: updatedServices));
          return true;
        },
      );
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to update status: ${e.toString()}',
      ));
      return false;
    }
  }

  /// Add service to local list (called after successful creation)
  void addServiceToList(ServiceEntity service) {
    final updatedServices = [service, ...state.myServices];
    emit(state.copyWith(myServices: updatedServices));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
