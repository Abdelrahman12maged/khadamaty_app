import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamaty_app/features/provider/domain/entities/service_entity.dart';
import 'package:khadamaty_app/features/home/domain/usecases/get_active_services_usecase.dart';
import 'explore_state.dart';

/// Explore cubit for managing search, filter, and sort functionality
class ExploreCubit extends Cubit<ExploreState> {
  final GetActiveServicesUseCase _getActiveServicesUseCase;

  ExploreCubit({
    required GetActiveServicesUseCase getActiveServicesUseCase,
  })  : _getActiveServicesUseCase = getActiveServicesUseCase,
        super(const ExploreState());

  /// Load all services from Firestore
  Future<void> loadServices() async {
    emit(state.copyWith(isLoading: true, clearError: true));

    final result = await _getActiveServicesUseCase();

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        error: failure.message,
      )),
      (services) => emit(state.copyWith(
        isLoading: false,
        allServices: services,
        filteredServices: services,
      )),
    );
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
    var filtered = List<ServiceEntity>.from(state.allServices);

    // Apply search
    if (state.searchQuery.isNotEmpty) {
      final query = state.searchQuery.toLowerCase();
      filtered = filtered.where((service) {
        return service.title.toLowerCase().contains(query) ||
            service.description.toLowerCase().contains(query) ||
            service.providerName.toLowerCase().contains(query);
      }).toList();
    }

    // Apply category filter
    if (state.selectedCategoryId != null) {
      filtered = filtered
          .where((s) => s.category == state.selectedCategoryId)
          .toList();
    }

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
  Future<void> refreshServices() async {
    final result = await _getActiveServicesUseCase();

    result.fold(
      (failure) => emit(state.copyWith(error: failure.message)),
      (services) {
        emit(state.copyWith(
          allServices: services,
          clearError: true,
        ));
        _applyAllFilters();
      },
    );
  }
}
