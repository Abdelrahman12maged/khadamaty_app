import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/booking_entity.dart';

class BookingModel extends BookingEntity {
  const BookingModel({
    required super.id,
    required super.serviceId,
    required super.serviceName,
    required super.providerId,
    required super.providerName,
    required super.customerId,
    required super.bookingDate,
    required super.createdAt,
    required super.status,
    required super.totalPrice,
    super.notes,
    super.address,
  });

  factory BookingModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BookingModel(
      id: doc.id,
      serviceId: data['serviceId'] ?? '',
      serviceName: data['serviceName'] ?? '',
      providerId: data['providerId'] ?? '',
      providerName: data['providerName'] ?? '',
      customerId: data['customerId'] ?? '',
      bookingDate: (data['bookingDate'] as Timestamp).toDate(),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      status: BookingStatus.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => BookingStatus.pending,
      ),
      totalPrice: (data['totalPrice'] ?? 0).toDouble(),
      notes: data['notes'],
      address: data['address'],
    );
  }

  factory BookingModel.fromEntity(BookingEntity entity) {
    return BookingModel(
      id: entity.id,
      serviceId: entity.serviceId,
      serviceName: entity.serviceName,
      providerId: entity.providerId,
      providerName: entity.providerName,
      customerId: entity.customerId,
      bookingDate: entity.bookingDate,
      createdAt: entity.createdAt,
      status: entity.status,
      totalPrice: entity.totalPrice,
      notes: entity.notes,
      address: entity.address,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'serviceId': serviceId,
      'serviceName': serviceName,
      'providerId': providerId,
      'providerName': providerName,
      'customerId': customerId,
      'bookingDate': Timestamp.fromDate(bookingDate),
      'createdAt': Timestamp.fromDate(createdAt),
      'status': status.name,
      'totalPrice': totalPrice,
      'notes': notes,
      'address': address,
    };
  }
}
