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
    // Responsive values
    final cardWidth =
        context.responsive(mobile: 280.0, tablet: 300.0, desktop: 320.0);
    // Slightly reduced padding in grid view to prevent overflow
    final cardPadding = isInGrid
        ? context.responsive(mobile: 6.0, tablet: 8.0, desktop: 10.0)
        : context.responsive(mobile: 10.0, tablet: 12.0, desktop: 14.0);
    final borderRadius =
        context.responsive(mobile: 12.0, tablet: 14.0, desktop: 16.0);
    // Minimal spacing in grid view
    final titleSpacing = isInGrid
        ? context.responsive(mobile: 2.0, tablet: 2.0, desktop: 3.0)
        : context.responsive(mobile: 2.0, tablet: 3.0, desktop: 4.0);
    final descSpacing = isInGrid
        ? context.responsive(mobile: 3.0, tablet: 3.0, desktop: 5.0)
        : context.responsive(mobile: 4.0, tablet: 6.0, desktop: 8.0);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isInGrid ? null : cardWidth,
        margin: isInGrid ? EdgeInsets.zero : const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: AppColors.surface(context),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ServiceImage(imageUrl: imageUrl, isInGrid: isInGrid),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: isInGrid
                          ? Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              )
                          : Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    SizedBox(height: titleSpacing),

                    // Description
                    Text(
                      description,
                      maxLines: isInGrid ? 1 : 2,
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
                        Flexible(
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
