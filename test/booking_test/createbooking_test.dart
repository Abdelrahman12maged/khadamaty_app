import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:khadamaty_app/features/bookings/domain/repositories/booking_repository.dart';
import 'package:khadamaty_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:khadamaty_app/features/auth/domain/entities/user_entity.dart';
import 'package:khadamaty_app/features/provider/domain/entities/service_entity.dart';
import 'package:khadamaty_app/features/bookings/domain/usecases/create_booking_usecase.dart';
import 'package:khadamaty_app/features/bookings/presentation/cubits/create_booking_cubit/create_booking_cubit.dart';
import 'package:khadamaty_app/features/bookings/presentation/cubits/create_booking_cubit/create_booking_state.dart';

import 'createbooking_test.mocks.dart';

@GenerateMocks([BookingRepository, AuthRepository, CreateBookingUseCase])
void main() {
  late CreateBookingCubit cubit;
  late MockCreateBookingUseCase mockCreateBookingUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockCreateBookingUseCase = MockCreateBookingUseCase();
    mockAuthRepository = MockAuthRepository();
    cubit = CreateBookingCubit(
      createBookingUseCase: mockCreateBookingUseCase,
      authRepository: mockAuthRepository,
    );
  });

  final tService = ServiceEntity(
    id: '1',
    providerId: 'provider_1',
    providerName: 'Provider One',
    title: 'Cleaning',
    description: 'Clean everything',
    category: 'Home Service',
    serviceType: ServiceType.appointment,
    price: 100,
    priceUnit: 'EGP',
    location:
        const ServiceLocation(latitude: 0, longitude: 0, address: 'Cairo'),
    createdAt: DateTime.now(),
  );

  final tUser = UserEntity(
    id: 'user_1',
    email: 'user@test.com',
    name: 'User Test',
  );

  test('initial state is correct', () {
    expect(cubit.state, const CreateBookingState());
  });

  test('should emit [loading, success] when booking is created successfully',
      () async {
    // arrange
    when(mockAuthRepository.currentUser).thenReturn(tUser);
    when(mockCreateBookingUseCase(any))
        .thenAnswer((_) async => const Right(null));

    cubit.selectDate(DateTime(2024, 1, 1));
    cubit.selectTime('10:00 AM');

    // act
    await cubit.confirmBooking(service: tService);

    // assert
    expect(cubit.state.status, CreateBookingStatus.success);
    verify(mockCreateBookingUseCase(any)).called(1);
  });

  test('should emit [loading, error] when selection is missing', () async {
    // act
    await cubit.confirmBooking(service: tService);

    // assert
    expect(cubit.state.status, CreateBookingStatus.error);
    expect(cubit.state.errorMessage, 'يرجى اختيار التاريخ والوقت');
  });
}
