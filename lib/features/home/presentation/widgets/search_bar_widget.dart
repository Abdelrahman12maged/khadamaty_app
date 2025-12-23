import 'package:flutter/material.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';

/// Reusable search bar widget for home screen
/// Tappable to navigate to explore/search screen
class SearchBarWidget extends StatelessWidget {
  final VoidCallback? onTap;

  const SearchBarWidget({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Responsive values
    final borderRadius =
        context.responsive(mobile: 10.0, tablet: 12.0, desktop: 14.0);
    final iconSize =
        context.responsive(mobile: 20.0, tablet: 22.0, desktop: 24.0);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.surfaceDark.withOpacity(0.5)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: isDark ? AppColors.dividerDark : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color:
                  isDark ? AppColors.textSecondaryDark : Colors.grey.shade600,
              size: iconSize,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                S.of(context).searchServices,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Icon(
              Icons.tune,
              color:
                  isDark ? AppColors.textSecondaryDark : Colors.grey.shade600,
              size: iconSize - 2,
            ),
          ],
        ),
      ),
    );
  }
}
