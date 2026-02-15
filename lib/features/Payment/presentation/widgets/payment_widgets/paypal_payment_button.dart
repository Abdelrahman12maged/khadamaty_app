import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import 'package:khadamaty_app/features/Payment/data/datasources/paypal_service.dart';
import 'package:khadamaty_app/features/Payment/presentation/cubit/payment_cubit.dart';

/// PayPal payment button widget with responsive design.
///
/// Uses `PaypalCheckoutView` for the full payment flow.
/// On success → emits through cubit. On error/cancel → handles gracefully.
class PaypalPaymentButton extends StatelessWidget {
  final int amount;
  final String currency;
  final String description;

  // PayPal brand color
  static const Color paypalColor = Color(0xFF0070BA);

  const PaypalPaymentButton({
    super.key,
    required this.amount,
    required this.currency,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    // Responsive button padding
    final buttonPadding = context.responsive(
      mobile: AppSpacing.md(context),
      tablet: AppSpacing.lg(context),
      desktop: AppSpacing.lg(context),
    );

    // Responsive font size
    final fontSize = context.responsive(
      mobile: 16.0,
      tablet: 18.0,
      desktop: 20.0,
    );

    // Responsive icon size
    final iconSize = context.responsive(
      mobile: 24.0,
      tablet: 28.0,
      desktop: 32.0,
    );

    return ElevatedButton.icon(
      onPressed: () => _launchPaypal(context),
      icon: Image.network(
        'https://www.paypalobjects.com/webstatic/icon/pp258.png',
        width: iconSize,
        height: iconSize,
        errorBuilder: (_, __, ___) => Icon(Icons.payment, size: iconSize),
      ),
      label: Text(S.of(context).payWithPaypal),
      style: ElevatedButton.styleFrom(
        backgroundColor: paypalColor,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(
          vertical: buttonPadding,
          horizontal: context.isDesktop ? AppSpacing.xl(context) : 0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.header(context)),
        ),
        textStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
      ),
    );
  }

  void _launchPaypal(BuildContext context) {
    final cubit = context.read<PaymentCubit>();

    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext ctx) => PaypalCheckoutView(
        sandboxMode: PaypalService.sandboxMode,
        clientId: PaypalService.clientId,
        secretKey: PaypalService.secretKey,
        transactions: [
          PaypalService.buildTransaction(
            amount: amount.toStringAsFixed(2),
            currency: currency,
            description: description,
          ),
        ],
        note: S.of(context).paypalNote,
        onSuccess: (Map params) async {
          Navigator.pop(ctx);
          cubit.recordPayalSuccess(
            paymentData: Map<String, dynamic>.from(params),
          );
        },
        onError: (error) {
          Navigator.pop(ctx);
          cubit.recordPaypalError(error: error.toString());
        },
        onCancel: () {
          Navigator.pop(ctx);
        },
      ),
    ));
  }
}
