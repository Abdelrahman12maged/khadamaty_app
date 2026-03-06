import 'package:dartz/dartz.dart';
import 'package:khadamaty_app/core/error/failures.dart';
import 'package:khadamaty_app/features/Payment/data/models/payment_params.dart';
import 'package:khadamaty_app/features/Payment/domain/entities/payment_type.dart';
import 'package:khadamaty_app/features/Payment/domain/entities/paymentreuslt.dart';

abstract class PaymentRepository {

  Future<Either<Failure, PaymentResultEntity>> makePayment({
    required PaymentParams params
  });

 
}
