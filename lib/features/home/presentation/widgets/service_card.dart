import 'package:flutter/material.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import 'package:khadamaty_app/core/utils/responsive_font_size.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';

/// Service card widget for displaying service information
/// Works in both horizontal ListView and Grid
class ServiceCard extends StatelessWidget {
  final String title;
  final String description;
  final String providerName;
  final double price;
  final String priceUnit;
  final double rating;
  final int reviewCount;
  final String? imageUrl;
  final VoidCallback? onTap;
  final bool isInGrid;

  const ServiceCard({
    super.key,
    required this.title,
    required this.description,
    required this.providerName,
    required this.price,
    required this.priceUnit,
    required this.rating,
    required this.reviewCount,
    this.imageUrl,
    this.onTap,
    this.isInGrid = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        // Only set width for horizontal scroll
        width: isInGrid
            ? null
            : (MediaQuery.of(context).size.width > 600 ? 300.0 : 280.0),
        margin: isInGrid ? EdgeInsets.zero : const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.3)
                  : Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service Image
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: imageUrl != null
                  ? Image.network(
                      imageUrl!,
                      height: 140,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildPlaceholderImage(context),
                    )
                  : _buildPlaceholderImage(context),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Service Title
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveFontSize.titleMedium(context),
                          ),
                    ),

                    const SizedBox(height: 2),

                    // Description
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : Colors.grey.shade600,
                            fontSize: ResponsiveFontSize.bodySmall(context),
                          ),
                    ),

                    const SizedBox(height: 4),

                    // Provider name
                    Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 16,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            providerName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: isDark
                                          ? AppColors.textSecondaryDark
                                          : Colors.grey.shade600,
                                      fontSize:
                                          ResponsiveFontSize.bodySmall(context),
                                    ),
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Price and Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Price
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${S.of(context).from} \$${price.toStringAsFixed(0)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: ResponsiveFontSize.titleMedium(
                                          context),
                                    ),
                              ),
                              Text(
                                priceUnit,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: isDark
                                          ? AppColors.textSecondaryDark
                                          : Colors.grey.shade600,
                                      fontSize: ResponsiveFontSize.labelSmall(
                                          context),
                                    ),
                              ),
                            ],
                          ),
                        ),

                        // Rating
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                rating.toStringAsFixed(1),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: ResponsiveFontSize.labelSmall(
                                          context),
                                    ),
                              ),
                              Text(
                                ' ($reviewCount)',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: isDark
                                          ? AppColors.textSecondaryDark
                                          : Colors.grey.shade600,
                                      fontSize: ResponsiveFontSize.labelSmall(
                                          context),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 140,
      width: double.infinity,
      color: isDark ? AppColors.dividerDark : Colors.grey.shade200,
      child: Icon(
        Icons.image_outlined,
        size: 48,
        color: isDark ? AppColors.textSecondaryDark : Colors.grey.shade400,
      ),
    );
  }
}
