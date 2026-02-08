import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';

/// Service image widget with placeholder support
class ServiceImage extends StatelessWidget {
  final String? imageUrl;
  final bool isInGrid;

  const ServiceImage({
    super.key,
    this.imageUrl,
    this.isInGrid = false,
  });

  @override
  Widget build(BuildContext context) {
    // Smaller image in grid to leave more space for content
    final imageHeight = isInGrid
        ? context.responsive(mobile: 80.0, tablet: 90.0, desktop: 100.0)
        : context.responsive(mobile: 120.0, tablet: 140.0, desktop: 160.0);

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
    final iconSize = context.responsive(
      mobile: 40.0,
      tablet: 48.0,
      desktop: 56.0,
    );

    return Container(
      height: height,
      width: double.infinity,
      color: AppColors.divider(context),
      child: Icon(
        Icons.image_outlined,
        size: iconSize,
        color: AppColors.textSecondary(context),
      ),
    );
  }
}