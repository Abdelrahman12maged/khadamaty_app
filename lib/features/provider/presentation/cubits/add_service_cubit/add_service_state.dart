import 'package:equatable/equatable.dart';

/// Add Service form states
enum AddServiceStatus {
  initial,
  loading,
  success,
  error,
}

/// State for Add Service form
class AddServiceState extends Equatable {
  // Form fields
  final String title;
  final String description;
  final String category;
  final double? price;
  final String priceUnit;
  final double? latitude;
  final double? longitude;
  final String? address;
  final String? imageUrl;

  // Form status
  final AddServiceStatus status;
  final String? error;

  // Validation state
  final bool hasAttemptedSubmit;

  const AddServiceState({
    this.title = '',
    this.description = '',
    this.category = '',
    this.price,
    this.priceUnit = 'per visit',
    this.latitude,
    this.longitude,
    this.address,
    this.imageUrl,
    this.status = AddServiceStatus.initial,
    this.error,
    this.hasAttemptedSubmit = false,
  });

  /// Check if form is valid
  bool get isValid =>
      title.isNotEmpty &&
      description.isNotEmpty &&
      category.isNotEmpty &&
      price != null &&
      price! > 0 &&
      latitude != null &&
      longitude != null;

  /// Check if location is selected
  bool get hasLocation => latitude != null && longitude != null;

  AddServiceState copyWith({
    String? title,
    String? description,
    String? category,
    double? price,
    String? priceUnit,
    double? latitude,
    double? longitude,
    String? address,
    String? imageUrl,
    AddServiceStatus? status,
    String? error,
    bool? hasAttemptedSubmit,
    bool clearError = false,
    bool clearLocation = false,
  }) {
    return AddServiceState(
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
      priceUnit: priceUnit ?? this.priceUnit,
      latitude: clearLocation ? null : (latitude ?? this.latitude),
      longitude: clearLocation ? null : (longitude ?? this.longitude),
      address: clearLocation ? null : (address ?? this.address),
      imageUrl: imageUrl ?? this.imageUrl,
      status: status ?? this.status,
      error: clearError ? null : (error ?? this.error),
      hasAttemptedSubmit: hasAttemptedSubmit ?? this.hasAttemptedSubmit,
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        category,
        price,
        priceUnit,
        latitude,
        longitude,
        address,
        imageUrl,
        status,
        error,
        hasAttemptedSubmit,
      ];
}
