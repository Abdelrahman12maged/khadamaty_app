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
          color: AppColors.surface(context).withOpacity(0.5),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: AppColors.divider(context),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: AppColors.textSecondary(context),
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
              color: AppColors.textSecondary(context),
              size: iconSize - 2,
            ),
          ],
        ),
      ),
    );
  }
}
