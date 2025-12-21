import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/utils/responsive_font_size.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';

/// Category card widget with icon, name, and service count
class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String name;
  final int serviceCount;
  final Color gradientStartColor;
  final Color gradientEndColor;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.icon,
    required this.name,
    required this.serviceCount,
    required this.gradientStartColor,
    required this.gradientEndColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final padding =
        context.responsive(mobile: 16.0, tablet: 18.0, desktop: 20.0);
    final iconSize =
        context.responsive(mobile: 28.0, tablet: 30.0, desktop: 32.0);
    final spacing =
        context.responsive(mobile: 8.0, tablet: 10.0, desktop: 12.0);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [gradientStartColor, gradientEndColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: gradientStartColor.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: iconSize,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: spacing),

              // Category name
              Text(
                name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: ResponsiveFontSize.bodyMedium(context),
                    ),
              ),

              const SizedBox(height: 4),

              // Service count
              Text(
                '$serviceCount services',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: ResponsiveFontSize.bodySmall(context),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
