import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';
import 'package:khadamaty_app/generated/l10n.dart';

/// Success dialog content widget for payment success
class PaymentSuccessDialog extends StatelessWidget {
  final String transactionId;
  final String paymentMethod;
  final VoidCallback onDone;

  const PaymentSuccessDialog({
    super.key,
    required this.transactionId,
    required this.paymentMethod,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    // Responsive icon size
    final iconSize = context.responsive(
      mobile: 64.0,
      tablet: 80.0,
      desktop: 96.0,
    );

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.md(context)),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            color: AppColors.successGreen,
            size: iconSize,
          ),
          SizedBox(height: AppSpacing.md(context)),
          Text(
            S.of(context).paymentSuccessful,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSpacing.sm(context)),
          Text(
            S.of(context).paidVia(paymentMethod),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: AppSpacing.xs(context)),
          Text(
            '${S.of(context).transactionId}: $transactionId',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onDone,
          child: Text(S.of(context).done),
        ),
      ],
    );
  }
}
