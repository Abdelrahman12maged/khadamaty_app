import 'package:equatable/equatable.dart';

class PaymentResultEntity extends Equatable {
  // final bool isSuccess;
  // final String transactionId;
  // final String message;
  final String clientSecret;

  const PaymentResultEntity({
    // required this.isSuccess,
    // required this.transactionId,
    // required this.message,
    required this.clientSecret,
  });

  @override
  List<Object?> get props => [clientSecret];
}