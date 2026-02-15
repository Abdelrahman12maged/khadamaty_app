import 'package:khadamaty_app/features/Payment/data/models/payment_model.dart';
import 'package:khadamaty_app/features/Payment/data/models/payment_params.dart';
import 'package:khadamaty_app/features/Payment/domain/entities/payment_type.dart';

abstract class PaymentService {
  Future<PaymentModel> makePaymentIntent({
   required PaymentParams params
  });


}