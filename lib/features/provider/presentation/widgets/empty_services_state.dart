import 'package:flutter/material.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';

/// Empty state for my services
class EmptyServicesState extends StatelessWidget {
  const EmptyServicesState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.work_outline,
            size: 100,
            color: AppColors.textSecondary(context).withOpacity(0.5),
          ),
          SizedBox(height: AppSpacing.lg(context)),
          Text(
            S.of(context).noServicesYet,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: AppSpacing.sm(context)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl(context)),
            child: Text(
              S.of(context).startAddingServices,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
