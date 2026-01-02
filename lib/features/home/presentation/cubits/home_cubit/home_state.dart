import 'package:equatable/equatable.dart';

/// Home screen state
class HomeState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<CategoryData> categories;
  final List<ServiceData> featuredServices;
  final List<ServiceData> popularProviders;

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
    List<ServiceData>? featuredServices,
    List<ServiceData>? popularProviders,
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

/// Service data model
class ServiceData extends Equatable {
  final String id;
  final String title;
  final String description;
  final String providerName;
  final double price;
  final String priceUnit;
  final double rating;
  final int reviewCount;
  final String? imageUrl;
  // New fields for Add Service form
  final String? category;
  final double? latitude;
  final double? longitude;
  final String? address;

  const ServiceData({
    required this.id,
    required this.title,
    required this.description,
    required this.providerName,
    required this.price,
    required this.priceUnit,
    required this.rating,
    required this.reviewCount,
    this.imageUrl,
    this.category,
    this.latitude,
    this.longitude,
    this.address,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        providerName,
        price,
        priceUnit,
        rating,
        reviewCount,
        imageUrl,
        category,
        latitude,
        longitude,
        address,
      ];
}
