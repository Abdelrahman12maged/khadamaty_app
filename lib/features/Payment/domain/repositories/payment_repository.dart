import 'package:dartz/dartz.dart';
import 'package:khadamaty_app/core/error/failures.dart';
import 'package:khadamaty_app/features/Payment/data/models/payment_params.dart';
import 'package:khadamaty_app/features/Payment/domain/entities/payment_type.dart';
import 'package:khadamaty_app/features/Payment/domain/entities/paymentreuslt.dart';

/// Abstract repository for payment operations.
abstract class PaymentRepository {
  /// Initiates a Stripe payment.
  /// [amount] - Amount in the smallest currency unit (e.g., cents).
  /// [currency] - Currency code (e.g., 'usd', 'egp').
  Future<Either<Failure, PaymentResultEntity>> makePayment({
    required PaymentParams params
  });

  /// Initiates a PayPal payment.
  /// [amount] - Amount as a string (e.g., '10.00').
  /// [currency] - Currency code (e.g., 'USD').
  // Future<Either<Failure, String>> makePaypalPayment({
  //   required String amount,
  //   required String currency,
  //   required String description,
  // });

  // /// Initiates a Paymob payment.
  // /// [amount] - Amount in the smallest currency unit (e.g., cents/piasters).
  // /// [currency] - Currency code (e.g., 'EGP').
  // Future<Either<Failure, String>> makePaymobPayment({
  //   required int amount,
  //   required String currency,
  // });
}
