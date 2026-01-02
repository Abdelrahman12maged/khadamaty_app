import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_service_state.dart';
import '../../../../home/presentation/cubits/home_cubit/home_state.dart';

/// Cubit for managing Add Service form
class AddServiceCubit extends Cubit<AddServiceState> {
  AddServiceCubit() : super(const AddServiceState());

  /// Update title
  void updateTitle(String title) {
    emit(state.copyWith(title: title, clearError: true));
  }

  /// Update description
  void updateDescription(String description) {
    emit(state.copyWith(description: description, clearError: true));
  }

  /// Update category
  void updateCategory(String category) {
    emit(state.copyWith(category: category, clearError: true));
  }

  /// Update price
  void updatePrice(double? price) {
    emit(state.copyWith(price: price, clearError: true));
  }

  /// Update price unit
  void updatePriceUnit(String priceUnit) {
    emit(state.copyWith(priceUnit: priceUnit));
  }

  /// Update location
  void updateLocation({
    required double latitude,
    required double longitude,
    String? address,
  }) {
    emit(state.copyWith(
      latitude: latitude,
      longitude: longitude,
      address: address,
      clearError: true,
    ));
  }

  /// Clear location
  void clearLocation() {
    emit(state.copyWith(clearLocation: true));
  }

  /// Submit form
  Future<ServiceData?> submitForm({
    required String providerName,
  }) async {
    // Mark that submit was attempted (for showing validation errors)
    emit(state.copyWith(hasAttemptedSubmit: true));

    // Validate
    if (!state.isValid) {
      return null;
    }

    try {
      emit(state.copyWith(status: AddServiceStatus.loading));

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 800));

      // Create service data
      final service = ServiceData(
        id: 'service_${DateTime.now().millisecondsSinceEpoch}',
        title: state.title,
        description: state.description,
        providerName: providerName,
        price: state.price!,
        priceUnit: state.priceUnit,
        rating: 0.0, // New service has no ratings
        reviewCount: 0,
        imageUrl: state.imageUrl,
        category: state.category,
        latitude: state.latitude,
        longitude: state.longitude,
        address: state.address,
      );

      emit(state.copyWith(status: AddServiceStatus.success));
      return service;
    } catch (e) {
      emit(state.copyWith(
        status: AddServiceStatus.error,
        error: 'Failed to create service: ${e.toString()}',
      ));
      return null;
    }
  }

  /// Reset form
  void reset() {
    emit(const AddServiceState());
  }
}
