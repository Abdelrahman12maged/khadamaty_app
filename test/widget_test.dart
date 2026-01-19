import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:khadamaty_app/features/provider/data/repositories/firebase_service_repository.dart';
import 'package:khadamaty_app/firebase_options.dart'; // ملف الإعدادات الخاص بك

void main() async {
 
  final repository = FirebaseServiceRepository(
    firestore: FirebaseFirestore.instance, // استخدام النسخة الحقيقية
  );

  test('جلب البيانات من السيرفر الحقيقي', () async {
    final result = await repository.getActiveServices();

    result.fold(
      (failure) => print('❌ فشل الاتصال: ${failure.message}'),
      (services) {
        print('✅ نجاح! تم جلب ${services.length} خدمة من السيرفر.');
        for (var s in services) {
          print('--- الخدمة: ${s.title} | التقييم: ${s.rating}');
        }
      },
    );
  });
}