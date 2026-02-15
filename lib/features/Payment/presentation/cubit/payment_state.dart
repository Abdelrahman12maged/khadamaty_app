part of 'payment_cubit.dart';

/// Base state for payment operations.
abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any payment action.
class PaymentInitial extends PaymentState {}

/// Loading state while payment is being processed.
class PaymentLoading extends PaymentState {}

/// Success state when payment completes successfully.
class PaymentSuccess extends PaymentState {
 PaymentResultEntity paymentResultEntity;
   PaymentSuccess({
    required this.paymentResultEntity
  });

  @override
  List<Object?> get props => [ paymentResultEntity];
}

/// Failure state when payment fails.
class PaymentFailure extends PaymentState {
  final String message;

  const PaymentFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
