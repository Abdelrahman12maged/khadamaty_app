import 'package:equatable/equatable.dart';
import 'package:khadamaty_app/features/provider/domain/entities/service_entity.dart';

/// Home screen state
class HomeState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<CategoryData> categories;
  final List<ServiceEntity> featuredServices;
  final List<ServiceEntity> popularProviders;

  const HomeState({
    this.isLoading = false,
    this.error,
    this.categories = const [],
    this.featuredServices = const [],
    this.popularProviders = const [],
  });

  HomeState copyWith({
    bool? isLoading,
    String? error,
    bool clearError = false,
    List<CategoryData>? categories,
    List<ServiceEntity>? featuredServices,
    List<ServiceEntity>? popularProviders,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      categories: categories ?? this.categories,
      featuredServices: featuredServices ?? this.featuredServices,
      popularProviders: popularProviders ?? this.popularProviders,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        categories,
        featuredServices,
        popularProviders,
      ];
}

/// Category data model
class CategoryData extends Equatable {
  final String id;
  final String name;
  final String icon;
  final int gradientStartColor;
  final int gradientEndColor;
  final int serviceCount;

  const CategoryData({
    required this.id,
    required this.name,
    required this.icon,
    required this.gradientStartColor,
    required this.gradientEndColor,
    required this.serviceCount,
  });

  @override
  List<Object> get props => [
        id,
        name,
        icon,
        gradientStartColor,
        gradientEndColor,
        serviceCount,
      ];
}
