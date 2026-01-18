import 'package:equatable/equatable.dart';
import 'package:khadamaty_app/features/provider/domain/entities/service_entity.dart';

enum ServiceDetailsStatus { initial, loading, success, error }

class ServiceDetailsState extends Equatable {
  final ServiceDetailsStatus status;
  final ServiceEntity? service;
  final String? errorMessage;

  const ServiceDetailsState({
    this.status = ServiceDetailsStatus.initial,
    this.service,
    this.errorMessage,
  });

  ServiceDetailsState copyWith({
    ServiceDetailsStatus? status,
    ServiceEntity? service,
    String? errorMessage,
  }) {
    return ServiceDetailsState(
      status: status ?? this.status,
      service: service ?? this.service,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, service, errorMessage];
}
