import 'package:equatable/equatable.dart';

enum BookingStatus {
  pending,
  confirmed,
  completed,
  cancelled,
  declined,
}

class BookingEntity extends Equatable {
  final String id;
  final String serviceId;
  final String serviceName;
  final String providerId;
  final String providerName;
  final String customerId;
  final DateTime bookingDate;
  final DateTime createdAt;
  final BookingStatus status;
  final double totalPrice;
  final bool isPaid;
  final String? notes;
  final String? address;

  const BookingEntity({
    required this.id,
    required this.serviceId,
    required this.serviceName,
    required this.providerId,
    required this.providerName,
    required this.customerId,
    required this.bookingDate,
    required this.createdAt,
    required this.status,
    required this.totalPrice,
    this.isPaid = false,
    this.notes,
    this.address,
  });

  @override
  List<Object?> get props => [
        id,
        serviceId,
        providerId,
        customerId,
        bookingDate,
        status,
        totalPrice,
        isPaid,
      ];

  /// CopyWith for modifying state
  BookingEntity copyWith({
    String? id,
    String? serviceId,
    String? serviceName,
    String? providerId,
    String? providerName,
    String? customerId,
    DateTime? bookingDate,
    DateTime? createdAt,
    BookingStatus? status,
    double? totalPrice,
    bool? isPaid,
    String? notes,
    String? address,
  }) {
    return BookingEntity(
      id: id ?? this.id,
      serviceId: serviceId ?? this.serviceId,
      serviceName: serviceName ?? this.serviceName,
      providerId: providerId ?? this.providerId,
      providerName: providerName ?? this.providerName,
      customerId: customerId ?? this.customerId,
      bookingDate: bookingDate ?? this.bookingDate,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      totalPrice: totalPrice ?? this.totalPrice,
      isPaid: isPaid ?? this.isPaid,
      notes: notes ?? this.notes,
      address: address ?? this.address,
    );
  }
}
