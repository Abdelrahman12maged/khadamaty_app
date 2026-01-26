import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khadamaty_app/features/bookings/data/datasources/booking_remote_data_source.dart';
import 'package:khadamaty_app/features/bookings/domain/entities/booking_entity.dart';

void main() {
  late BookingRemoteDataSourceImpl dataSource;
  late FakeFirebaseFirestore fakeFirestore;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    dataSource = BookingRemoteDataSourceImpl(firestore: fakeFirestore);
  });

  final tBooking = BookingEntity(
    id: 'booking_123',
    serviceId: 'service_1',
    serviceName: 'Test Service',
    providerId: 'provider_1',
    providerName: 'Test Provider',
    customerId: 'customer_1',
    bookingDate: DateTime(2024, 1, 1, 10, 0),
    createdAt: DateTime.now(),
    status: BookingStatus.pending,
    totalPrice: 50.0,
    address: 'Test Address',
  );

  group('createBooking', () {
    test('should create a booking in Firestore successfully', () async {
      // act
      await dataSource.createBooking(tBooking);

      // assert
      final doc =
          await fakeFirestore.collection('bookings').doc(tBooking.id).get();
      expect(doc.exists, true);
      expect(doc.data()?['serviceName'], 'Test Service');
      expect(doc.data()?['customerId'], 'customer_1');
    });
  });
}
