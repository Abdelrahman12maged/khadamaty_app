import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_active_services_usecase.dart';
import 'home_state.dart';

/// Hardcoded categories — rarely change, no need for Firestore
const defaultCategories = [
  CategoryData(
    id: '1',
    name: 'Cleaning',
    icon: 'cleaning_services',
    gradientStartColor: 0xFF2196F3,
    gradientEndColor: 0xFF1976D2,
    serviceCount: 15,
  ),
  CategoryData(
    id: '2',
    name: 'Plumbing',
    icon: 'plumbing',
    gradientStartColor: 0xFFFF9800,
    gradientEndColor: 0xFFF57C00,
    serviceCount: 12,
  ),
  CategoryData(
    id: '3',
    name: 'Electrical',
    icon: 'electrical_services',
    gradientStartColor: 0xFFFFC107,
    gradientEndColor: 0xFFFFA000,
    serviceCount: 18,
  ),
  CategoryData(
    id: '4',
    name: 'Carpentry',
    icon: 'carpenter',
    gradientStartColor: 0xFF795548,
    gradientEndColor: 0xFF5D4037,
    serviceCount: 10,
  ),
  CategoryData(
    id: '5',
    name: 'Painting',
    icon: 'format_paint',
    gradientStartColor: 0xFF9C27B0,
    gradientEndColor: 0xFF7B1FA2,
    serviceCount: 14,
  ),
  CategoryData(
    id: '6',
    name: 'AC Repair',
    icon: 'ac_unit',
    gradientStartColor: 0xFF00BCD4,
    gradientEndColor: 0xFF0097A7,
    serviceCount: 8,
  ),
];

/// Home cubit for managing home screen data
class HomeCubit extends Cubit<HomeState> {
  final GetActiveServicesUseCase _getActiveServicesUseCase;

  HomeCubit({
    required GetActiveServicesUseCase getActiveServicesUseCase,
  })  : _getActiveServicesUseCase = getActiveServicesUseCase,
        super(const HomeState());

  /// Load all home screen data
  Future<void> loadHomeData(BuildContext context) async {
    emit(state.copyWith(isLoading: true, clearError: true));

    try {
      final categories = defaultCategories;

      final servicesResult = await _getActiveServicesUseCase();

      servicesResult.fold(
        (failure) => emit(state.copyWith(
          isLoading: false,
          error: failure.message,
          categories: categories,
        )),
        (services) {
          emit(state.copyWith(
            isLoading: false,
            categories: categories,
            featuredServices: services,
            popularProviders: services,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  /// Refresh home data
  Future<void> refreshHomeData(BuildContext context) async {
    await loadHomeData(context);
  }

  /// Clear error
  void clearError() {
    emit(state.copyWith(clearError: true));
  }
}
