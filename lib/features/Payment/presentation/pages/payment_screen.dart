import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamaty_app/core/di/injection_container.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';
import 'package:khadamaty_app/core/utils/ui_helpers.dart';
import 'package:khadamaty_app/core/widgets/loading_indicator.dart';
import 'package:khadamaty_app/features/Payment/data/models/payment_params.dart';
import 'package:khadamaty_app/features/Payment/domain/entities/payment_type.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import 'package:khadamaty_app/features/Payment/presentation/cubit/payment_cubit.dart';
import 'package:khadamaty_app/features/Payment/presentation/widgets/payment_widgets/amount_card.dart';
import 'package:khadamaty_app/features/Payment/presentation/widgets/payment_widgets/stripe_payment_button.dart';
import 'package:khadamaty_app/features/Payment/presentation/widgets/payment_widgets/paypal_payment_button.dart';
import 'package:khadamaty_app/features/Payment/presentation/widgets/payment_widgets/paymob_payment_button.dart';
import 'package:khadamaty_app/features/Payment/presentation/widgets/payment_widgets/payment_success_dialog.dart';

/// Payment screen with options for Stripe, PayPal, and Paymob.
/// Responsive design adapts to mobile, tablet, and desktop.
class PaymentScreen extends StatelessWidget {
  final int amount;
  final String currency;
  final String description;

  const PaymentScreen({
    super.key,
    required this.amount,
    this.currency = 'usd',
    this.description = 'Khadamaty Service Payment',
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PaymentCubit>(),
      child: _PaymentScreenContent(
        amount: amount,
        currency: currency,
        description: description,
      ),
    );
  }
}

class _PaymentScreenContent extends StatelessWidget {
  final int amount;
  final String currency;
  final String description;

  const _PaymentScreenContent({
    required this.amount,
    required this.currency,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    // Responsive max width for content
    final maxContentWidth = context.responsive(
      mobile: double.infinity,
      tablet: 500.0,
      desktop: 600.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).payment),
        centerTitle: true,
      ),
      body: BlocConsumer<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state is PaymentSuccess) {
            _showSuccessDialog(context, state);
          } else if (state is PaymentFailure) {
            UIHelpers.showErrorSnackbar(
              context: context,
              message: state.message,
            );
            // context.read<PaymentCubit>().makePayment(params: PaymentParams(
            //   amount: amount,
            //   currency: currency,
            //   paymentType: PaymentType.strip,
             
            // ));
          }
        },
        builder: (context, state) {
          print(amount);
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxContentWidth),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(AppSpacing.page(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Amount Card
                    AmountCard(
                      amount: amount,
                      currency: currency,
                      description: description,
                    ),
                    SizedBox(height: AppSpacing.xl(context)),

                    // Payment Methods Header
                    Text(
                      S.of(context).selectPaymentMethod,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: AppSpacing.md(context)),

                    // Stripe Button
                    StripePaymentButton(
                      amount: amount,
                      currency: currency,
                      isLoading: state is PaymentLoading,
                    ),
                    SizedBox(height: AppSpacing.md(context)),

                    // PayPal Button
                    PaypalPaymentButton(
                      amount: amount,
                      currency: currency,
                      description: description,
                    ),
                    SizedBox(height: AppSpacing.md(context)),

                    // Paymob Button (Cards + Wallets)
                    // PaymobPaymentButton(
                    //   amount: amount,
                    //   currency: currency.toUpperCase(),
                    //   isLoading: state is PaymentLoading,
                    //   customerEmail:
                    //       'customer@example.com', // TODO: Get from user profile
                    //   customerPhone:
                    //       '+201234567890', // TODO: Get from user profile
                    //   customerName:
                    //       'Customer Name', // TODO: Get from user profile
                    // ),
                    SizedBox(height: AppSpacing.lg(context)),

                    // Loading indicator
                    if (state is PaymentLoading)
                      LoadingIndicator(
                        message: S.of(context).processingPayment,
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showSuccessDialog(BuildContext context, PaymentSuccess state) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Center(child: Text("goooood"),)
    );
  }
}
