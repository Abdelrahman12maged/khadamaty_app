import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/service_entity.dart';

/// Service model for Firestore serialization
class ServiceModel extends ServiceEntity {
  const ServiceModel({
    required super.id,
    required super.providerId,
    required super.providerName,
    required super.title,
    required super.description,
    required super.category,
    super.subcategory,
    required super.serviceType,
    required super.price,
    required super.priceUnit,
    super.durationMinutes,
    super.imageUrl,
    required super.location,
    super.availability,
    super.isActive,
    super.rating,
    super.reviewCount,
    required super.createdAt,
    super.updatedAt,
  });

  /// Create from Firestore document
  factory ServiceModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return ServiceModel(
      id: doc.id,
      providerId: data['providerId'] ?? '',
      providerName: data['providerName'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      subcategory: data['subcategory'],
      serviceType: _parseServiceType(data['serviceType']),
      price: (data['price'] ?? 0).toDouble(),
      priceUnit: data['priceUnit'] ?? 'per_visit',
      durationMinutes: data['durationMinutes'],
      imageUrl: data['imageUrl'],
      location: ServiceLocation.fromMap(data['location'] ?? {}),
      availability: data['availability'] != null
          ? ServiceAvailability.fromMap(data['availability'])
          : null,
      isActive: data['isActive'] ?? true,
      rating: (data['rating'] ?? 0).toDouble(),
      reviewCount: data['reviewCount'] ?? 0,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  /// Convert to Firestore map
  Map<String, dynamic> toFirestore() {
    return {
      'providerId': providerId,
      'providerName': providerName,
      'title': title,
      'description': description,
      'category': category,
      'subcategory': subcategory,
      'serviceType': serviceType.name,
      'price': price,
      'priceUnit': priceUnit,
      'durationMinutes': durationMinutes,
      'imageUrl': imageUrl,
      'location': location.toMap(),
      'availability': availability?.toMap(),
      'isActive': isActive,
      'rating': rating,
      'reviewCount': reviewCount,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }

  /// Create model from entity
  factory ServiceModel.fromEntity(ServiceEntity entity) {
    return ServiceModel(
      id: entity.id,
      providerId: entity.providerId,
      providerName: entity.providerName,
      title: entity.title,
      description: entity.description,
      category: entity.category,
      subcategory: entity.subcategory,
      serviceType: entity.serviceType,
      price: entity.price,
      priceUnit: entity.priceUnit,
      durationMinutes: entity.durationMinutes,
      imageUrl: entity.imageUrl,
      location: entity.location,
      availability: entity.availability,
      isActive: entity.isActive,
      rating: entity.rating,
      reviewCount: entity.reviewCount,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  static ServiceType _parseServiceType(String? value) {
    switch (value) {
      case 'appointment':
        return ServiceType.appointment;
      case 'onDemand':
      default:
        return ServiceType.onDemand;
    }
  }
}
