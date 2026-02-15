import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/di/injection_container.dart';
import 'package:khadamaty_app/core/error/failures.dart';
import 'package:khadamaty_app/core/service/Api.dart';
import 'package:khadamaty_app/features/Payment/data/datasources/payment_service.dart';
import 'package:khadamaty_app/features/Payment/data/datasources/stripe_service.dart';
import 'package:khadamaty_app/features/Payment/data/models/payment_params.dart';
import 'package:khadamaty_app/features/Payment/domain/entities/payment_type.dart';
import 'package:khadamaty_app/features/Payment/domain/entities/paymentreuslt.dart';
import 'package:khadamaty_app/features/Payment/domain/repositories/payment_repository.dart';

/// Implementation of [PaymentRepository] using Stripe and PayPal services.
class PaymentRepositoryImpl implements PaymentRepository {
  //final PaymentService _paymentService;
  final PaymentServiceFactory _paymentFactory;

  PaymentRepositoryImpl({
    required PaymentServiceFactory paymentFactory,
  }

      /// required  PaymentService paymentservice,
      ) : _paymentFactory = paymentFactory;

  @override
  Future<Either<Failure, PaymentResultEntity>> makePayment(
      {required PaymentParams params}) async {
    try {
      final paymentService = await _paymentFactory.create(params.paymentType);
      final result = await paymentService.makePaymentIntent(params: params);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

// class PaymentServiceFactory {
//   static PaymentService create( PaymentType type) {
//     switch (type) {
//       case PaymentType.stripe:
//         return sl<StripeServiceImp>();
//       case PaymentType.paypal:
//         throw Exception('وسيلة الدفع غير مدعومة حالياً');
//       default:
//         throw Exception('وسيلة الدفع غير مدعومة حالياً');
//     }
//   }
// }

class PaymentServiceFactory {
  // المصنع الآن يستقبل الخدمات التي يحتاجها من الخارج
  final PaymentService stripeService;
  final PaymentService paypalService;

  PaymentServiceFactory(
      {required this.stripeService, required this.paypalService
      // required this.paypalService,
      });

  PaymentService create(PaymentType type) {
    switch (type) {
      case PaymentType.stripe:
        return stripeService;
      case PaymentType.paypal:
        return paypalService;
      default:
        throw Exception('وسيلة الدفع غير مدعومة');
    }
  }
}
