import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';
import 'package:khadamaty_app/generated/l10n.dart';

/// Amount display card widget with responsive design
class AmountCard extends StatelessWidget {
  final int amount;
  final String currency;
  final String description;

  const AmountCard({
    super.key,
    required this.amount,
    required this.currency,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    // Responsive card padding
    final cardPadding = context.responsive(
      mobile: AppSpacing.lg(context),
      tablet: AppSpacing.xl(context),
      desktop: AppSpacing.xl(context) * 1.5,
    );

    // Responsive amount font size
    final amountFontSize = context.responsive(
      mobile: 32.0,
      tablet: 40.0,
      desktop: 48.0,
    );

    return Card(
      elevation: context.isMobile ? 4 : 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.md(context)),
      ),
      child: Padding(
        padding: EdgeInsets.all(cardPadding),
        child: Column(
          children: [
            Text(
              S.of(context).paymentTotalAmount,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: AppSpacing.sm(context)),
            Text(
              '$currency ${amount.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlue,
                    fontSize: amountFontSize,
                  ),
            ),
            SizedBox(height: AppSpacing.sm(context)),
            Text(
              description,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
