import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamaty_app/features/home/presentation/cubits/home_cubit/home_state.dart';
import 'mock_home_data.dart';

/// Home cubit for managing home screen data
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  /// Load all home screen data
  Future<void> loadHomeData(BuildContext context) async {
    emit(state.copyWith(isLoading: true, clearError: true));

    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      // TODO: Replace with actual repository calls
      final categories = MockHomeData.getCategories();
      final featuredServices = MockHomeData.getFeaturedServices(context);
      final popularProviders = MockHomeData.getPopularProviders(context);

      emit(state.copyWith(
        isLoading: false,
        categories: categories,
        featuredServices: featuredServices,
        popularProviders: popularProviders,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  /// Refresh home data
  Future<void> refreshHomeData(BuildContext context) async {
    try {
      // Don't show loading indicator for refresh
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // TODO: Replace with actual repository calls
      final categories = MockHomeData.getCategories();
      final featuredServices = MockHomeData.getFeaturedServices(context);
      final popularProviders = MockHomeData.getPopularProviders(context);

      emit(state.copyWith(
        categories: categories,
        featuredServices: featuredServices,
        popularProviders: popularProviders,
        clearError: true,
      ));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  /// Clear error
  void clearError() {
    emit(state.copyWith(clearError: true));
  }
}
