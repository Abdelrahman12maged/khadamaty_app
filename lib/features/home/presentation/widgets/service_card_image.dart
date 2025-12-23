import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';

/// Service image widget with placeholder support
class ServiceImage extends StatelessWidget {
  final String? imageUrl;

  const ServiceImage({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final imageHeight = context.responsive(
      mobile: 120.0,
      tablet: 140.0,
      desktop: 160.0,
    );
    final borderRadius = context.responsive(
      mobile: 12.0,
      tablet: 14.0,
      desktop: 16.0,
    );

    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(borderRadius)),
      child: imageUrl != null
          ? Image.network(
              imageUrl!,
              height: imageHeight,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  _PlaceholderImage(height: imageHeight),
            )
          : _PlaceholderImage(height: imageHeight),
    );
  }
}

class _PlaceholderImage extends StatelessWidget {
  final double height;

  const _PlaceholderImage({required this.height});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconSize = context.responsive(
      mobile: 40.0,
      tablet: 48.0,
      desktop: 56.0,
    );

    return Container(
      height: height,
      width: double.infinity,
      color: isDark ? AppColors.dividerDark : Colors.grey.shade200,
      child: Icon(
        Icons.image_outlined,
        size: iconSize,
        color: isDark ? AppColors.textSecondaryDark : Colors.grey.shade400,
      ),
    );
  }
}
