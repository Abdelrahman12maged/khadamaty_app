import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';
import 'service_card_image.dart';
import 'provider_info.dart';
import 'price_display.dart';
import 'rating_badge.dart';

/// Clean, modular service card widget
/// Composed of smaller, reusable widgets
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

    // Responsive values
    final cardWidth =
        context.responsive(mobile: 280.0, tablet: 300.0, desktop: 320.0);
    final cardPadding =
        context.responsive(mobile: 10.0, tablet: 12.0, desktop: 14.0);
    final borderRadius =
        context.responsive(mobile: 12.0, tablet: 14.0, desktop: 16.0);
    final titleSpacing =
        context.responsive(mobile: 2.0, tablet: 3.0, desktop: 4.0);
    final descSpacing =
        context.responsive(mobile: 4.0, tablet: 6.0, desktop: 8.0);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isInGrid ? null : cardWidth,
        margin: isInGrid ? EdgeInsets.zero : const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
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
            ServiceImage(imageUrl: imageUrl),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: titleSpacing),

                    // Description
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(height: descSpacing),

                    // Provider
                    ProviderInfo(providerName: providerName),

                    const Spacer(),

                    // Price & Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: PriceDisplay(
                            price: price,
                            priceUnit: priceUnit,
                          ),
                        ),
                        RatingBadge(
                          rating: rating,
                          reviewCount: reviewCount,
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
}
