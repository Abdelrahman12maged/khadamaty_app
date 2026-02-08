import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:khadamaty_app/core/error/exceptions.dart';
import '../../domain/entities/booking_entity.dart';
import '../models/booking_model.dart';

abstract class BookingRemoteDataSource {
  Future<void> createBooking(BookingEntity booking);
  Future<List<BookingModel>> getUserBookings(String userId);
  Future<List<BookingModel>> getProviderBookings(String providerId);
  Future<void> updateBookingStatus(String bookingId, BookingStatus status);
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final FirebaseFirestore _firestore;

  BookingRemoteDataSourceImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createBooking(BookingEntity booking) async {
    try {
      final model = BookingModel.fromEntity(booking);
      final _bookingCollection = _firestore.collection('bookings');
        await _bookingCollection.add(model.toFirestore());
   
      // await _firestore
      //     .collection('bookings')
      //     .doc(model.id)
      //     .set(model.toFirestore());
    } on FirebaseException catch (e) {
      throw DatabaseException(e.message ?? 'فشل إنشاء الحجز', e.code);
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<BookingModel>> getUserBookings(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('bookings')
          .where('customerId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => BookingModel.fromFirestore(doc))
          .toList();
    } on FirebaseException catch (e) {
      if (e.code == 'failed-precondition') {
        throw const DatabaseException(
          'يجب إنشاء فهرس (Index) في Firebase لتشغيل هذا الاستعلام.',
          'failed-precondition',
        );
      }
      throw DatabaseException(e.message ?? 'فشل جلب الحجوزات', e.code);
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<BookingModel>> getProviderBookings(String providerId) async {
    try {
      final querySnapshot = await _firestore
          .collection('bookings')
          .where('providerId', isEqualTo: providerId)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => BookingModel.fromFirestore(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw DatabaseException(e.message ?? 'فشل جلب الحجوزات للمزود', e.code);
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> updateBookingStatus(
      String bookingId, BookingStatus status) async {
    try {
      await _firestore.collection('bookings').doc(bookingId).update({
        'status': status.name,
      });
    } on FirebaseException catch (e) {
      throw DatabaseException(e.message ?? 'فشل تحديث حالة الحجز', e.code);
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
