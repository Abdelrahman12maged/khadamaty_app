import 'package:khadamaty_app/features/Payment/domain/entities/payment_type.dart';

class PaymentParams {
  final int amount;
  final String currency;
  final PaymentType paymentType;
  final String? customerId;
  final String? customerEmail;
  final String? customerName;

  PaymentParams({
    required this.amount,
    required this.currency,
    required this.paymentType,
    this.customerId,
    this.customerEmail,
    this.customerName,
  });
}
