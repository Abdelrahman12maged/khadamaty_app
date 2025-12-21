import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/utils/responsive_font_size.dart';

/// Section header with title and optional "See All" action
class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAllTap;
  final String? seeAllText;

  const SectionHeader({
    super.key,
    required this.title,
    this.onSeeAllTap,
    this.seeAllText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: ResponsiveFontSize.titleLarge(context),
              ),
        ),
        if (onSeeAllTap != null && seeAllText != null)
          TextButton(
            onPressed: onSeeAllTap,
            child: Text(
              seeAllText!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
      ],
    );
  }
}
