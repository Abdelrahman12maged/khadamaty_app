import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';

/// Provider info row widget
class ProviderInfo extends StatelessWidget {
  final String providerName;

  const ProviderInfo({super.key, required this.providerName});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconSize = context.responsive(
      mobile: 14.0,
      tablet: 16.0,
      desktop: 18.0,
    );

    return Row(
      children: [
        Icon(
          Icons.person_outline,
          size: iconSize,
          color: isDark ? AppColors.textSecondaryDark : Colors.grey.shade600,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            providerName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
