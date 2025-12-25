import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamaty_app/features/home/presentation/cubits/home_cubit/home_state.dart';
import 'explore_state.dart';
import '../home_cubit/mock_home_data.dart';

/// Explore cubit for managing search, filter, and sort functionality
class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit() : super(const ExploreState());

  /// Load all services
  Future<void> loadServices(BuildContext context) async {
    emit(state.copyWith(isLoading: true, clearError: true));

    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Get all services from mock data
      final featured = MockHomeData.getFeaturedServices(context);
      final providers = MockHomeData.getPopularProviders(context);
      final allServices = [...featured, ...providers];

      emit(state.copyWith(
        isLoading: false,
        allServices: allServices,
        filteredServices: allServices,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  /// Search services by query
  void searchServices(String query) {
    emit(state.copyWith(searchQuery: query));
    _applyAllFilters();
  }

  /// Filter by category
  void filterByCategory(String? categoryId) {
    emit(state.copyWith(
      selectedCategoryId: categoryId,
      clearCategory: categoryId == null,
    ));
    _applyAllFilters();
  }

  /// Sort services
  void sortServices(SortOption option) {
    emit(state.copyWith(sortBy: option));
    _applyAllFilters();
  }

  /// Apply custom filters
  void applyFilters(Map<String, dynamic> filters) {
    emit(state.copyWith(filters: filters));
    _applyAllFilters();
  }

  /// Clear all filters
  void clearAllFilters() {
    emit(state.copyWith(
      searchQuery: '',
      clearCategory: true,
      sortBy: SortOption.mostPopular,
      clearFilters: true,
    ));
    emit(state.copyWith(filteredServices: state.allServices));
  }

  /// Apply all filters, search, and sort
  void _applyAllFilters() {
    var filtered = List<ServiceData>.from(state.allServices);

    // Apply search
    if (state.searchQuery.isNotEmpty) {
      final query = state.searchQuery.toLowerCase();
      filtered = filtered.where((service) {
        return service.title.toLowerCase().contains(query) ||
            service.description.toLowerCase().contains(query) ||
            service.providerName.toLowerCase().contains(query);
      }).toList();
    }

    // Apply category filter (would need category info in ServiceData)
    // For now, skipping category filter as mock data doesn't have category field

    // Apply custom filters
    if (state.filters != null) {
      final minPrice = state.filters!['minPrice'] as double?;
      final maxPrice = state.filters!['maxPrice'] as double?;
      final minRating = state.filters!['minRating'] as double?;

      if (minPrice != null) {
        filtered = filtered.where((s) => s.price >= minPrice).toList();
      }
      if (maxPrice != null) {
        filtered = filtered.where((s) => s.price <= maxPrice).toList();
      }
      if (minRating != null) {
        filtered = filtered.where((s) => s.rating >= minRating).toList();
      }
    }

    // Apply sorting
    switch (state.sortBy) {
      case SortOption.mostPopular:
        filtered.sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
        break;
      case SortOption.topRated:
        filtered.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case SortOption.priceLowToHigh:
        filtered.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortOption.priceHighToLow:
        filtered.sort((a, b) => b.price.compareTo(a.price));
        break;
    }

    emit(state.copyWith(filteredServices: filtered));
  }

  /// Refresh services
  Future<void> refreshServices(BuildContext context) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      final featured = MockHomeData.getFeaturedServices(context);
      final providers = MockHomeData.getPopularProviders(context);
      final allServices = [...featured, ...providers];

      emit(state.copyWith(
        allServices: allServices,
        clearError: true,
      ));
      _applyAllFilters();
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
