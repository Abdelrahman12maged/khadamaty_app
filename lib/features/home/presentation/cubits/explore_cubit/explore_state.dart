import 'package:equatable/equatable.dart';
import '../home_state.dart';

/// Sort options for explore page
enum SortOption {
  mostPopular,
  topRated,
  priceLowToHigh,
  priceHighToLow,
}

/// Explore page state
class ExploreState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<ServiceData> allServices;
  final List<ServiceData> filteredServices;
  final String searchQuery;
  final String? selectedCategoryId;
  final SortOption sortBy;
  final Map<String, dynamic>? filters;

  const ExploreState({
    this.isLoading = false,
    this.error,
    this.allServices = const [],
    this.filteredServices = const [],
    this.searchQuery = '',
    this.selectedCategoryId,
    this.sortBy = SortOption.mostPopular,
    this.filters,
  });

  ExploreState copyWith({
    bool? isLoading,
    String? error,
    bool clearError = false,
    List<ServiceData>? allServices,
    List<ServiceData>? filteredServices,
    String? searchQuery,
    String? selectedCategoryId,
    bool clearCategory = false,
    SortOption? sortBy,
    Map<String, dynamic>? filters,
    bool clearFilters = false,
  }) {
    return ExploreState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      allServices: allServices ?? this.allServices,
      filteredServices: filteredServices ?? this.filteredServices,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategoryId: clearCategory
          ? null
          : (selectedCategoryId ?? this.selectedCategoryId),
      sortBy: sortBy ?? this.sortBy,
      filters: clearFilters ? null : (filters ?? this.filters),
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        allServices,
        filteredServices,
        searchQuery,
        selectedCategoryId,
        sortBy,
        filters,
      ];
}
