import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';
import 'package:khadamaty_app/generated/l10n.dart';

/// Image picker section for Add Service form
class ImagePickerSection extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback onTap;

  const ImagePickerSection({
    super.key,
    this.imageUrl,
    required this.onTap,
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
            context.responsive(mobile: 150.0, tablet: 180.0, desktop: 200.0),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.divider(context),
            width: imageUrl != null ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: AppColors.surface(context),
          image: imageUrl != null
              ? DecorationImage(
                  image: NetworkImage(imageUrl!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: imageUrl == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 48,
                    color: AppColors.primaryBlue,
                  ),
                  SizedBox(height: AppSpacing.sm(context)),
                  Text(
                    s.tapToAddImage,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary(context),
                    ),
                  ),
                ],
              )
            : Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(8),
                child: CircleAvatar(
                  backgroundColor:
                      AppColors.textPrimary(context).withValues(alpha: 0.5),
                  radius: 18,
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
      ),
    );
  }
}
