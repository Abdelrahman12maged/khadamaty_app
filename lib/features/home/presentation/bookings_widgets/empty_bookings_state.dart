import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
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
    final iconSize = context.responsive(
      mobile: 80.0,
      tablet: 100.0,
      desktop: 120.0,
    );

    return Center(
      child: Padding(
        padding: EdgeInsets.all(
          context.responsive(mobile: 32.0, tablet: 48.0, desktop: 64.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: AppColors.textSecondary(context).withOpacity(0.5),
            ),
            const SizedBox(height: 24),
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
