import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';

/// Profile setting item with switch/toggle
class ProfileSettingItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool value;
  final ValueChanged<bool>? onChanged;

  const ProfileSettingItem({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppSpacing.xs(context),
        horizontal: AppSpacing.md(context),
      ),
      child: Row(
        children: [
          // Icon
          Icon(
            icon,
            color: AppColors.primaryBlue,
            size: 20,
          ),
          SizedBox(width: AppSpacing.md(context)),

          // Title
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),

          // Switch
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryBlue,
          ),
        ],
      ),
    );
  }
}
