import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';
import 'package:khadamaty_app/features/Payment/data/models/payment_params.dart';
import 'package:khadamaty_app/features/Payment/domain/entities/payment_type.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import 'package:khadamaty_app/features/Payment/presentation/cubit/payment_cubit.dart';

/// Stripe payment button widget with responsive design
class StripePaymentButton extends StatelessWidget {
  final int amount;
  final String currency;
  final bool isLoading;

  // Stripe brand color
  static const Color stripeColor = Color(0xFF635BFF);

  const StripePaymentButton({
    super.key,
    required this.amount,
    required this.currency,
    required this.isLoading,
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
      onPressed: isLoading ? null : () => _processPayment(context),
      icon: Icon(Icons.credit_card, size: iconSize),
      label: Text(S.of(context).payWithStripe),
      style: ElevatedButton.styleFrom(
        backgroundColor: stripeColor,
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

  void _processPayment(BuildContext context) {
    context.read<PaymentCubit>().makePayment(
          params: PaymentParams(
            amount: amount,
            currency: currency.toLowerCase(),
            paymentType: PaymentType.stripe,
          ),
        );
  }
}
