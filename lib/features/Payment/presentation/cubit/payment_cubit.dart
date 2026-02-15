import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamaty_app/features/Payment/data/models/payment_params.dart';
import 'package:khadamaty_app/features/Payment/domain/entities/paymentreuslt.dart';
import 'package:khadamaty_app/features/Payment/domain/repositories/payment_repository.dart';

part 'payment_state.dart';

/// Cubit for managing payment state.
class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepository _paymentRepository;

  PaymentCubit({required PaymentRepository paymentRepository})
      : _paymentRepository = paymentRepository,
        super(PaymentInitial());

  /// Process Stripe payment via repository.
  Future<void> makePayment({
    required PaymentParams params,
  }) async {
    emit(PaymentLoading());

    final result = await _paymentRepository.makePayment(
      params: params,
    );

    result.fold(
      (failure) => emit(PaymentFailure(message: failure.message)),
      (result) => emit(PaymentSuccess(
        paymentResultEntity: result,
      )),
    );
  }

  /// Record PayPal payment success (called from PaypalPaymentButton).
  void recordPayalSuccess({required Map<String, dynamic> paymentData}) {
    final transactionId = paymentData['id']?.toString() ?? 'unknown';
    emit(PaymentSuccess(
      paymentResultEntity: PaymentResultEntity(
        clientSecret: transactionId,
      ),
    ));
  }

  /// Record PayPal payment error (called from PaypalPaymentButton).
  void recordPaypalError({required String error}) {
    emit(PaymentFailure(message: error));
  }

  /// Reset payment state.
  void resetPayment() {
    emit(PaymentInitial());
  }
}
