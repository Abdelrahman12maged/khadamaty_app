import 'package:flutter/material.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';

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

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.surfaceDark.withOpacity(0.5)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
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
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                S.of(context).searchServices,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : Colors.grey.shade600,
                    ),
              ),
            ),
            Icon(
              Icons.tune,
              color:
                  isDark ? AppColors.textSecondaryDark : Colors.grey.shade600,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
