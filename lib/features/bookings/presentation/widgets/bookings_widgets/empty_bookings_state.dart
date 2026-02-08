import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';

/// Empty state widget for bookings tabs
class EmptyBookingsState extends StatelessWidget {
  final String message;
  final IconData icon;

  const EmptyBookingsState({
    super.key,
    required this.message,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // Custom larger icon size for empty state
    final iconSize = context.responsive(
      mobile: 80.0,
      tablet: 100.0,
      desktop: 120.0,
    );

    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xl(context)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: AppColors.textSecondary(context).withValues(alpha: 0.5),
            ),
            SizedBox(height: AppSpacing.lg(context)),
            Text(
              message,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textSecondary(context),
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
