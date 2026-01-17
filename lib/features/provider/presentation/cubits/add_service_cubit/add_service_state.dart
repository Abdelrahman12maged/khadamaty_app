import 'package:equatable/equatable.dart';
import '../../../domain/entities/service_entity.dart';

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
  final ServiceType serviceType;
  final int? durationMinutes; // For appointment services
  final double? latitude;
  final double? longitude;
  final String? address;
  final String? imageUrl;
  final ServiceAvailability availability;

  // Form status
  final AddServiceStatus status;
  final String? error;
  final ServiceEntity? createdService;

  // Validation state
  final bool hasAttemptedSubmit;

  const AddServiceState({
    this.title = '',
    this.description = '',
    this.category = '',
    this.price,
    this.priceUnit = 'per_visit',
    this.serviceType = ServiceType.onDemand,
    this.durationMinutes,
    this.latitude,
    this.longitude,
    this.address,
    this.imageUrl,
    this.availability = ServiceAvailability.defaultAvailability,
    this.status = AddServiceStatus.initial,
    this.error,
    this.createdService,
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

  /// Check if this is an appointment service
  bool get isAppointmentService => serviceType == ServiceType.appointment;

  AddServiceState copyWith({
    String? title,
    String? description,
    String? category,
    double? price,
    String? priceUnit,
    ServiceType? serviceType,
    int? durationMinutes,
    double? latitude,
    double? longitude,
    String? address,
    String? imageUrl,
    ServiceAvailability? availability,
    AddServiceStatus? status,
    String? error,
    ServiceEntity? createdService,
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
      serviceType: serviceType ?? this.serviceType,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      latitude: clearLocation ? null : (latitude ?? this.latitude),
      longitude: clearLocation ? null : (longitude ?? this.longitude),
      address: clearLocation ? null : (address ?? this.address),
      imageUrl: imageUrl ?? this.imageUrl,
      availability: availability ?? this.availability,
      status: status ?? this.status,
      error: clearError ? null : (error ?? this.error),
      createdService: createdService ?? this.createdService,
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
        serviceType,
        durationMinutes,
        latitude,
        longitude,
        address,
        imageUrl,
        availability,
        status,
        error,
        createdService,
        hasAttemptedSubmit,
      ];
}
