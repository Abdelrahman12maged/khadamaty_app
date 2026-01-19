import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_active_services_usecase.dart';
import 'home_state.dart';
import 'mock_home_data.dart';

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
      // 1. Load Categories (Static for now, or from config)
      final categories = MockHomeData.getCategories();

      // 2. Load Featured Services from Firestore
      final servicesResult = await _getActiveServicesUseCase();

      servicesResult.fold(
        (failure) => emit(state.copyWith(
          isLoading: false,
          error: failure.message,
          categories: categories,
        )),
        (services) {
          final serviceDataList = services
              .map((e) => ServiceData(
                    id: e.id,
                    title: e.title,
                    description: e.description,
                    providerName: e.providerName,
                    price: e.price,
                    priceUnit: e.priceUnit,
                    rating: e.rating,
                    reviewCount: e.reviewCount,
                    imageUrl: e.imageUrl,
                    category: e.category,
                    latitude: e.location.latitude,
                    longitude: e.location.longitude,
                    address: e.location.address,
                  ))
              .toList();

          emit(state.copyWith(
            isLoading: false,
            categories: categories,
            featuredServices: serviceDataList,
            popularProviders:
                serviceDataList, // For now, use same list or filter
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
