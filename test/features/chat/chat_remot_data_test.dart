import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khadamaty_app/features/bookings/domain/entities/booking_entity.dart';
import 'package:khadamaty_app/features/chat_system/data/remote_data_source/chat_remote_datasource.dart';

void main() {
  late ChatRemoteDataSource chatRemoteDataSource;
  late FakeFirebaseFirestore fakeFirestore;

  setUp(
    () {
      fakeFirestore = FakeFirebaseFirestore();

      chatRemoteDataSource = ChatRemoteDataSourceImpl(firestore: fakeFirestore);
    },
  );
  test(
    "test get or create chat",
    () async {
      final booking = BookingEntity(
        id: '1',
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

      await chatRemoteDataSource.getOrCreateChat(booking);
      final chatcol = fakeFirestore.collection('chats');

      final querySnapshot = await chatcol
          .where('bookingId', isEqualTo: booking.id)
          .limit(1)
          .get();
      final doc = querySnapshot.docs.first;

      expect(doc.exists, true);
      expect(doc.data()['bookingId'], booking.id);
    },
  );
}
