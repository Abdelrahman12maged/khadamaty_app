import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';
import 'package:khadamaty_app/generated/l10n.dart';

/// Image picker placeholder section for Add Service form
/// TODO: Implement actual image picking when needed
class ImagePickerSection extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback? onTap;

  const ImagePickerSection({
    super.key,
    this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height:
            context.responsive(mobile: 100.0, tablet: 120.0, desktop: 150.0),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.divider(context),
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(12),
          color: AppColors.surface(context),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate_outlined,
              size: 40,
              color: AppColors.textSecondary(context),
            ),
            SizedBox(height: AppSpacing.sm(context)),
            Text(
              s.imageComingSoon,
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
