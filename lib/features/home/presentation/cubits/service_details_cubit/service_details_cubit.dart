import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamaty_app/features/provider/domain/entities/service_entity.dart';
import 'service_details_state.dart';

class ServiceDetailsCubit extends Cubit<ServiceDetailsState> {
  ServiceDetailsCubit() : super(const ServiceDetailsState());

  Future<void> loadService(String id) async {
    emit(state.copyWith(status: ServiceDetailsStatus.loading));

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Use mock data for now
    final mockService = ServiceEntity(
      id: id,
      providerId: 'p123',
      providerName: 'Ahmed Mahmoud',
      title: 'Plumbing & Pipe Repair',
      description:
          'Professional plumbing services for all your home needs. We fix leaks, install new pipes, and repair water heaters with 24/7 availability for emergencies.',
      category: 'Maintenance',
      serviceType: ServiceType.appointment,
      price: 250.0,
      priceUnit: 'Fixed',
      durationMinutes: 60,
      imageUrl:
          'https://images.unsplash.com/photo-1581244276823-86f789bc3330?q=80&w=2000',
      location: const ServiceLocation(
        latitude: 30.0444,
        longitude: 31.2357,
        address: 'Downtown, Cairo, Egypt',
      ),
      availability: const ServiceAvailability(
        workDays: [0, 1, 2, 3, 4],
        startTime: '09:00',
        endTime: '18:00',
      ),
      rating: 4.8,
      reviewCount: 124,
      createdAt: DateTime.now(),
    );

    emit(state.copyWith(
      status: ServiceDetailsStatus.success,
      service: mockService,
    ));
  }
}
