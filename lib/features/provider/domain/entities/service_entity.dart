import 'package:equatable/equatable.dart';

/// Types of services
enum ServiceType {
  /// On-demand service (plumbing, cleaning, etc.)
  onDemand,

  /// Appointment-based service (doctors, salons, etc.)
  appointment,
}

/// Service availability schedule
class ServiceAvailability extends Equatable {
  /// Work days (0 = Sunday, 6 = Saturday)
  final List<int> workDays;

  /// Start time in HH:mm format
  final String startTime;

  /// End time in HH:mm format
  final String endTime;

  const ServiceAvailability({
    required this.workDays,
    required this.startTime,
    required this.endTime,
  });

  @override
  List<Object?> get props => [workDays, startTime, endTime];

  /// Create from Firestore map
  factory ServiceAvailability.fromMap(Map<String, dynamic> map) {
    return ServiceAvailability(
      workDays: List<int>.from(map['workDays'] ?? []),
      startTime: map['startTime'] ?? '09:00',
      endTime: map['endTime'] ?? '17:00',
    );
  }

  /// Convert to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'workDays': workDays,
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  /// Default availability (Sat-Thu, 9-5)
  static const defaultAvailability = ServiceAvailability(
    workDays: [0, 1, 2, 3, 4, 6], // Sun-Thu + Sat (Egyptian work week)
    startTime: '09:00',
    endTime: '17:00',
  );
}

/// Service location
class ServiceLocation extends Equatable {
  final double latitude;
  final double longitude;
  final String address;

  const ServiceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  @override
  List<Object?> get props => [latitude, longitude, address];

  factory ServiceLocation.fromMap(Map<String, dynamic> map) {
    return ServiceLocation(
      latitude: (map['latitude'] ?? 0).toDouble(),
      longitude: (map['longitude'] ?? 0).toDouble(),
      address: map['address'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };
  }
}

/// Service domain entity
class ServiceEntity extends Equatable {
  final String id;
  final String providerId;
  final String providerName;
  final String title;
  final String description;
  final String category;
  final String? subcategory;
  final ServiceType serviceType;
  final double price;
  final String priceUnit;
  final int? durationMinutes; // For appointment services
  final String? imageUrl;
  final ServiceLocation location;
  final ServiceAvailability? availability; // For appointment services
  final bool isActive;
  final double rating;
  final int reviewCount;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const ServiceEntity({
    required this.id,
    required this.providerId,
    required this.providerName,
    required this.title,
    required this.description,
    required this.category,
    this.subcategory,
    required this.serviceType,
    required this.price,
    required this.priceUnit,
    this.durationMinutes,
    this.imageUrl,
    required this.location,
    this.availability,
    this.isActive = true,
    this.rating = 0.0,
    this.reviewCount = 0,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        providerId,
        title,
        category,
        serviceType,
        price,
        isActive,
      ];

  /// Check if service requires appointment
  bool get requiresAppointment => serviceType == ServiceType.appointment;

  /// Copy with new values
  ServiceEntity copyWith({
    String? id,
    String? providerId,
    String? providerName,
    String? title,
    String? description,
    String? category,
    String? subcategory,
    ServiceType? serviceType,
    double? price,
    String? priceUnit,
    int? durationMinutes,
    String? imageUrl,
    ServiceLocation? location,
    ServiceAvailability? availability,
    bool? isActive,
    double? rating,
    int? reviewCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ServiceEntity(
      id: id ?? this.id,
      providerId: providerId ?? this.providerId,
      providerName: providerName ?? this.providerName,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      serviceType: serviceType ?? this.serviceType,
      price: price ?? this.price,
      priceUnit: priceUnit ?? this.priceUnit,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      imageUrl: imageUrl ?? this.imageUrl,
      location: location ?? this.location,
      availability: availability ?? this.availability,
      isActive: isActive ?? this.isActive,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
